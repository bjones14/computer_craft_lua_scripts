local wireless = peripheral.wrap("right")
local mfsu = peripheral.wrap("top")

local viewerID = 4

function OpenWireless()
    rednet.open("right")
end

function CloseWireless()
    rednet.close("right")
end

function MainLoop()
    while true do
        local eu_capacity = mfsu.getEUCapacity()
        local eu_stored = mfsu.getEUStored()
        local charge_percent = eu_stored / eu_capacity


        local status = string.format("mfsu1_charge_%% : %d", charge_percent) 

        print(status)
        
        OpenWireless()
        rednet.send(viewerID, status)
        CloseWireless()
    
        sleep(10)
    end
end

MainLoop()