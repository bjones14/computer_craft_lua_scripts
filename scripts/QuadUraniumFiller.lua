local chamber = peripheral.wrap("top")

function checkFuelSource()
    -- check for the inventory slot for the quad uranium cell and see if it
    -- is empty (nil)
    if chamber.list()[17] == nil then
        refillFuelSource()
    end
end

function refillFuelSource()
    -- turn on redstone signal for 3 seconds, which should be enough time
    -- for the redstone engine to push one fuel item into the reactor chamber
    redstone.setOutput("front", true)
    sleep(3)
    redstone.setOutput("front", false)
end

function MainLoop()
    while true do
        sleep(15)
        checkFuelSource()
    end
end

MainLoop()