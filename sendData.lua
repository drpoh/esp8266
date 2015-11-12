print("sendData.lua--v2.0")
tmr.wdclr()
local Temp1="&field1="..t.."."..(t%10)..""
local Press1="&field2="..p.."."..(p%10)..""
local Boot="&field3="..firstBoot..""
print("Sending data to thingspeak.com...")
tmr.wdclr()
conn=net.createConnection(net.TCP, 0) 
conn:connect(80,'184.106.153.149')
conn:on("connection",function(conn)
tmr.wdclr()
print("Connection!")
conn:send("GET /update?key="..apiKey..""..Temp1..""..Press1..""..Boot.." HTTP/1.1\r\n") 
conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
end)
tmr.wdclr()
conn:on("sent",function(conn)
print("Sent!")
conn:close() -- You can enable this row for skip thingspeak.com answer
end)
tmr.wdclr()
conn:on("receive",function(conn, payload)
print("Receive!")
print(payload)
conn:close()
end)
conn:on("disconnection",function(conn)
print("Disconnection!")
end)