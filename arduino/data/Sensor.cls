Class arduino.data.Sensor Extends %Persistent
{

Property port As %String [ Required ];

Property type As %String(VALUELIST = ",arduino") [Required];

Storage Default
{
<Data name="SensorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>port</Value>
</Value>
<Value name="3">
<Value>type</Value>
</Value>
</Data>
<DataLocation>^arduino.data.SensorD</DataLocation>
<DefaultData>SensorDefaultData</DefaultData>
<IdLocation>^arduino.data.SensorD</IdLocation>
<IndexLocation>^arduino.data.SensorI</IndexLocation>
<StreamLocation>^arduino.data.SensorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}