local wireless = peripheral.wrap("top")
local input_chest = peripheral.wrap("left")
local output_chest = peripheral.wrap("right")
local reactor_chamber = peripheral.wrap("back")

local viewerID = 4

function OpenWireless()
    rednet.open("top")
end

function CloseWireless()
    rednet.close("top")
end

function getNumUraniumCells()
    num = 0
    for k, v in pairs(input_chest.list()) do
        if v ~= nil then
            num = num + 1
        end
    end                
    return num
end

function MainLoop()
    while true do
        numUraniumCells = getNumUraniumCells()
        numInventorySlots = input_chest.size()
        uraniumPercentFull = (numUraniumCells / numInventorySlots) * 100
                        
        status = string.format("nr1_u92_lvl_%% : %d", uraniumPercentFull) 

        print(status)
        
        OpenWireless()
        rednet.send(viewerID, status)
        CloseWireless()
    
        sleep(10)
    end
end

MainLoop()