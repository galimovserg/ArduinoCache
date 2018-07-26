Class arduino.data.Temperature Extends %Persistent
{

///время замера
Property DateTime As %TimeStamp [InitialExpression = {$zdt($h,3)}, Required ];

///поле содержащее значение в градусах цельсиях
Property Temperature As %Numeric [ Required ];
	
Storage Default
{
<Data name="TemperatureDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Temperature</Value>
</Value>
<Value name="3">
<Value>DateTime</Value>
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