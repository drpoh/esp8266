 print("init.lua--v2.0")
wifi.sta.config("ssid","password")
wifi.sta.connect()
tmr.alarm(0, 2000, 1, function()
if wifi.sta.getip()== nil then
print("IP unavaiable, Waiting....")
else
tmr.stop(0)
print("ESP8266 mode is: " .. wifi.getmode())
print("Wifi status is: " .. wifi.sta.status())
print("The module MAC address is: " .. wifi.ap.getmac())
print("Config done, IP is "..wifi.sta.getip())
print("Heap is "..node.heap())
dofile ("time.lua")
collectgarbage()
dofile ("bmp180_script.lua")
end
end)
