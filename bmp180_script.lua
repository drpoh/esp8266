print("mine_script.lua--v2.0")
OSS = 1 -- oversampling setting (0-3)
SDA_PIN = 4 -- sda pin, GPIO2
SCL_PIN = 3 -- scl pin, GPIO0
apiKey = "IDK9ZN6T8D3MYO2R"
firstBoot = 1
hour,h = 0
minute,m = 0
second = 0
time1 = 0
dbUpdate = 30 --seconds
dbUpdate_ms = dbUpdate*60000
lastUpdate = 3600000
lightPin = 2 --GPIO4
gpio.mode(lightPin,gpio.OUTPUT)
--**********
function lightOn(h1, h2, h3, h4)
if (hour >= h1 and hour < h2) or (hour >= h3 and hour < h4) then
gpio.write(lightPin,gpio.LOW)
--print("light is: ON") 
else
gpio.write(lightPin,gpio.HIGH)
--print("light is: OFF") 
end
end
--**********
function increaseTime()
second = second + 30
lastUpdate = lastUpdate + 30
if second >= 60 then
second = 0
minute = minute + 1
end
if minute == 60 then 
minute = 0
hour = hour + 1
end
if hour == 24 then
hour = 0
end
tmr.wdclr()
end
--******
tmr.alarm(1, 30000, 1, function() 
increaseTime()
print("Time is:"..hour.."-"..minute.."-"..second..", "..lastUpdate.."-updates")
print(node.heap())
lightOn(16, 23, 5, 8)
if hour == 1 then
node.restart()
end
if lastUpdate > 3600000 then --3 600 000ms=1h
dofile ("time.lua")
collectgarbage()
end
tmr.wdclr()
end)
tmr.alarm(2, dbUpdate_ms, 1, function()
dofile ("readBMP.lua")
collectgarbage()
dofile ("sendData.lua")
collectgarbage()
end)
