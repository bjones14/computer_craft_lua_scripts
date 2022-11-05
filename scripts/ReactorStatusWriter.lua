local wireless = peripheral.wrap("top")
local input_chest = peripheral.wrap("left")
local output_chest = peripheral.wrap("right")
local reactor_chamber = peripheral.wrap("back")

local viewerID = 4

function OpenWireless()
    rednet.open("top")
end

function MainLoop()
    while true do
        sleep(5)
        OpenWireless()

        input_list = input_chest.list()
        numUraniumCells = #input_list

        rednet.send(viewerID, "There are " .. toString(numUraniumCells) " uranium cells in the reactor chest.")
    end
end

MainLoop()