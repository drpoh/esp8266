print("ping.lua--v2.0")
tmr.wdclr()
local Temp1="&Temp11="..t.."."..(t%10)..""
local Press1="&Press1="..p.."."..(p%10)..""
local Boot="&Boot="..firstBoot..""
print("Sending data to Raspberry...")
tmr.wdclr()
conn=net.createConnection(net.TCP, false)
conn:on("receive", function(conn, payload) print("Get done.", payload) end )
conn:connect(80,"192.168.1.110")
conn:send("GET /store.php?"..Temp1..""..Press1..""..Boot.." HTTP/1.1\r\nHost: xx.xx.xx.xx\r\n" .. "Connection: keep-alive\r\nAccept: */*\r\n\r\n")
