Class arduino.data.Temperature Extends %Persistent
{

///время замера
Property dateTime As %TimeStamp [InitialExpression = {$zdt($h,3)}, Required ];

///поле содержащее значение в градусах цельсиях
Property value As %Numeric [ Required ];

Property sensor As Sensor [Required];

ForeignKey sensorKey(sensor) References Sensor();
	
Storage Default
{
<Data name="TemperatureDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>value</Value>
</Value>
<Value name="3">
<Value>dateTime</Value>
</Value>
<Value name="4">
<Value>sensor</Value>
</Value>
</Data>
<DataLocation>^arduino.data.TemperatureD</DataLocation>
<DefaultData>TemperatureDefaultData</DefaultData>
<IdLocation>^arduino.data.TemperatureD</IdLocation>
<IndexLocation>^arduino.data.TemperatureI</IndexLocation>
<StreamLocation>^arduino.data.TemperatureS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}