Class arduino.utils.SynchronizationTask Extends %SYS.Task.Definition
{

Property sensorID As %String [ Required ];

Method OnTask() As %Status
{
    set st = $$$OK
   
    TSTART
    try {

        set sensor = ..getSensorById()

        set valueFromSensor =..getValueFromSensor(sensor)
	
        if (..isValueEmpty(valueFromSensor)) {
            do ..callActionWithNoData()
        } else {
            do ..saveValueFromSensor(valueFromSensor)
            do ..callActionWithDataIfShouldBeCalled(valueFromSensor)
        }
	
	    TCOMMIT
	} catch e {
	    TROLLBACK
	    set st = e.AsStatus()
	}
	
	return st
}

Method getSensorById() As arduino.data.Sensor {
    return ##class(arduino.data.Sensor).%OpenId(..sensorID)
}

ClassMethod isValueEmpty(value As %Numeric) As %Boolean {
    if (value = "") {
        return $$$YES
    } else {
        return $$$NO
    }
}

Method callActionWithNoData() {
    set sql = "SELECT id FROM arduino_data.Action WHERE sensor = ? AND (noData = 1)"
    
    set rs = ##class(%ResultSet).%New()
    $$$ThrowOnError(rs.Prepare(sql))
    $$$ThrowOnError(rs.Execute(..sensorID))
    
    while (rs.%Next() '= 0) {
        set action = rs.GetObject()
        
        do ..callAction(action)
    }
}

Method callActionWithDataIfShouldBeCalled(value As %Numeric) {

    set sql = "SELECT id FROM arduino_data.Action WHERE sensor = ? AND (more is not null OR less is not null ) AND (noData is null OR noData = 0)"
    
    set rs = ##class(%ResultSet).%New()
    $$$ThrowOnError(rs.Prepare(sql))
    $$$ThrowOnError(rs.Execute(..sensorID))
    
    while (rs.%Next() '= 0) {
        set action = rs.GetObject()
        
        if (action.more '= "") && (action.more < value) && (action.less = "") {
            do ..callAction(action)
        } elseif (action.less '= "") && (action.less > value) && (action.more = "") {
            do ..callAction(action)
        } elseif (action.less '= "") && (action.more '= "") && (action.more < value) && (action.less > value) {
            do ..callAction(action)
        }
        
    }

}

ClassMethod callAction(action As arduino.data.Action) {
    
    set mail = ##class(%Net.MailMessage).%New()
    set mail.From = "timelordes@gmail.com"
    set mail.Subject = "Notification"
    set mail.Charset = "UTF-8"
    do mail.TextData.Write(action.text)
    do mail.To.Insert(action.email)
    
    set auth=##class(%Net.Authenticator).%New()
    set auth.UserName = "timelordes@gmail.com"
    set auth.Password = "spiridonov1"
    
    set smtp = ##class(%Net.SMTP).%New()
    set smtp.smtpserver ="smtp.gmail.com"
    set smtp.port = 465
    set smtp.authenticator = auth
    set smtp.SSLConfiguration = "GOOGLE"
    
    $$$ThrowOnError(smtp.Send(mail))

}

Method saveValueFromSensor(value As %Numeric) {
    set newTemperature = ##class(arduino.data.Temperature).%New()
    set newTemperature.value = value
    set newTemperature.sensor = ..getSensorById()
    $$$ThrowOnError(newTemperature.%Save())
}

ClassMethod getValueFromSensor(sensor As arduino.data.Sensor) As %Numeric
{
    open sensor.port:(:"I"::" 0801n0":/BAUD=9600):0
    set old = $IO
    
    try {
        
        use sensor.port
        
        set str = ""
        
        for {
            
            read *symbol:15
            
            if (symbol = 10) {
                quit
            }
            
            set symbol = $char(symbol)
            
            set str = str _ symbol
            
        }
        
        use old
        return +str
        
    } catch e {
        use old
        close sensor.port
        return ""
    }
}

}
