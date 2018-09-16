--[[
Place this file into the autorun directory to get feedback on how the
PerformanceCounter (the timer used for the sleep function) is working for you.
--]]

package.cpath = getCheatEngineDir() .. "autorun\\Addresslogger\\dlls\\?.dll;" .. package.cpath
if cheatEngineIs64Bit() then
  slimer = require("slimerx64")
else
  slimer = require("slimerx86")
end

freq = slimer.frequency()
cpcount = slimer.clock()

period = 1 / freq * 1000000000

print("System Stats:")
print(string.format("Tick interval (hardware clock speed): %0.0f nanoseconds", period))
print("Current performance counter:", cpcount, "ticks")
print("Current elapsed time since system start:", cpcount * period / 1000000000, "seconds")
print("\tor", cpcount * period / 1000000000 / 60, "minutes")
print("\tor", cpcount * period / 1000000000 / 60 / 60, "hours")
print("\tor", cpcount * period / 1000000000 / 60 / 60 / 24, "days")