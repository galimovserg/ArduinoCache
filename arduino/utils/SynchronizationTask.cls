Class arduino.utils.SynchronizationTask Extends %SYS.Task.Definition
{

ClassMethod getTemperature() As %Numeric
{
	return $random(2555)/100.0+12
}

Method OnTask() As %Status
{
	set temperatureValue=..getTemperature()
	set newTemperature = ##class(arduino.data.Temperature).%New()
	set newTemperature.Temperature=temperatureValue
	do newTemperature.%Save()
	Quit $$$OK
}

}
