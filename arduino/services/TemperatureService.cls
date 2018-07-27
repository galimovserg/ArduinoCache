Class arduino.services.TemperatureService [ Abstract ]
{

ClassMethod ConvertToProxyObject(temperature As arduino.data.Temperature) As %ZEN.proxyObject
{
	set proxy = ##class(%ZEN.proxyObject).%New()
	set proxy.value=temperature.value
	set proxy.dateTime=temperature.dateTime
	
	return proxy
}

ClassMethod getTemperatures(beginTime As %TimeStamp, endTime As %TimeStamp) As %Status
{
	set status = $$$OK
	try{
		set sql = "SELECT id FROM arduino_data.Temperature where DateTime >= ? and DateTime <= ?"
		set rs = ##class(%ResultSet).%New("%DynamicQuery:SQL")
		$$$ThrowOnError(rs.Prepare(sql))
		$$$ThrowOnError(rs.Execute(beginTime, endTime))
			
		set proxy = ##class(%ZEN.proxyObject).%New()
		set proxy.result = ##class(%ListOfObjects).%New()
			
		while (rs.%Next() '= 0) {
			#dim temperature as arduino.data.Temperature = rs.GetObject()
			do proxy.result.Insert(..ConvertToProxyObject(temperature))
		}
		do proxy.%ToJSON()
	}
	catch ex{
		set status = ex.AsStatus()
	}
	return status
}

}
