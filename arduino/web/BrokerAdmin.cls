Class arduino.web.BrokerAdmin Extends %CSP.REST
{

Parameter UseSession = 1;

Parameter HandleCorsRequest = 1;

XData UrlMap
{
<Routes>
    <Route Url="/temperatures/:beginTime/:endTime" Method="GET" Call="arduino.services.TemperatureService:getTemperatures" />    	    
</Routes>
}

}
