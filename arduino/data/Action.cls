Class arduino.data.Action extends %Persistent
{

Property sensor As Sensor [ Required ];

ForeignKey sensorKey(sensor) References Sensor();

Property less As %Numeric [ InitialExpression = {""}];

Property more As %Numeric [ InitialExpression = {""}];

Property noData As %Boolean [ InitialExpression = {""} ];

Property email As %String [ Required ];

Property text As %String [ Required ];

Storage Default
{
<Data name="ActionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>sensor</Value>
</Value>
<Value name="3">
<Value>less</Value>
</Value>
<Value name="4">
<Value>more</Value>
</Value>
<Value name="5">
<Value>noData</Value>
</Value>
<Value name="6">
<Value>email</Value>
</Value>
<Value name="7">
<Value>text</Value>
</Value>
</Data>
<DataLocation>^arduino.data.ActionD</DataLocation>
<DefaultData>ActionDefaultData</DefaultData>
<IdLocation>^arduino.data.ActionD</IdLocation>
<IndexLocation>^arduino.data.ActionI</IndexLocation>
<StreamLocation>^arduino.data.ActionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}