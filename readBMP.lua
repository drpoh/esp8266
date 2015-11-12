print("readBMP.lua--v2.0")
bmp180 = require("bmp180")
bmp180.init(SDA_PIN, SCL_PIN)
bmp180.read(OSS)
p = bmp180.getPressure()
p = p * 75 / 10000
t = bmp180.getTemperature()/10
print("Pressure:    "..p.." hPa")
print("Temperature: "..t.." deg C")
-- release module
bmp180 = nil
package.loaded["bmp180"]=nil
tmr.wdclr()