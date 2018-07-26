Class arduino.utils.SynchronizationTask Extends %SYS.Task.Definition
{

Parameter PORT = "COM5";

ClassMethod getTemperature() As %Numeric
{
    open ..#PORT:(:"I"::" 0801n0":/BAUD=9600)
    set old = $IO
    
    try {
        
        use ..#PORT
        
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
        close ..#PORT
        throw e
    }
}

Method OnTask() As %Status
{
    set st = $$$OK
   
    TSTART
    try {

        set temperatureValue=..getTemperature()
	
        set newTemperature = ##class(arduino.data.Temperature).%New()
        set newTemperature.Temperature=temperatureValue
        $$$ThrowOnError(newTemperature.%Save())
	
	    TCOMMIT
	} catch e {
	    TROLLBACK
	    set st = e.AsStatus()
	}
	
	return st
}

}
