print("getTime.lua--v2.0")
ip = wifi.sta.getip()
if ip=="0.0.0.0" or ip==nil then
print("...connecting to AP...") 
else
tmr.wdclr()
print("Getting time...")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload)
time = string.sub(payload,string.find(payload,"Date: ")+23,string.find(payload,"Date: ")+31)
hour = string.sub(time, 0, 2) + 2
minute = string.sub(time, 4,5) + 0
second = string.sub(time, 7,9) + 0
print(hour.."-"..minute.."-"..second)
conn:close()
lastUpdate = 0
tmr.wdclr()
collectgarbage()
end) 
conn:dns('google.com',function(conn,ip) ipaddr=ip end)
conn:connect(80,ipaddr) 
conn:send("HEAD / HTTP/1.1\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; ESP8266 NodeMcu Lua;)\r\n") 
conn:send("\r\n")
end
