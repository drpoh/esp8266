gpio = 6
outpin=2
ds18b20 = require('ds18b20')
ds18b20.setup(gpio)
interval = 1
interval_ms=interval*60000
function sendData()
t=ds18b20.read()
while t>80 do
print("wrong temp..."..t.." C")
t=ds18b20.read();
end
print("Temp:"..t.." C")
print("Sending data to thingspeak.com...")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
conn:connect(80,'184.106.153.149') 
conn:send("GET /update?key=G2VB8316AYT1TPMP&field1="..t.." HTTP/1.1\r\n") 
conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("sent",function(conn)
print("Closing connection...")
conn:close()
end)
conn:on("disconnection", function(conn)
print("...Got disconnection\n")
return t
end)
pwm.close(outpin)
gpio.mode(outpin,gpio.OUTPUT)
end
t = nil 
ds18b20 = nil 
package.loaded["ds18b20"]=nil
tmr.alarm(0, interval_ms, 1, function() sendData() end )
