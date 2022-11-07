local chamber = peripheral.wrap("top")

-- positions of elements in breeder chamber
local northDepletedSlot = 8
local westDepletedSlot = 16
local uraniumSlot = 17
local eastDepletedSlot = 18
local southDepletedSlot = 26

local function verifyIntegrity()
    -- this function will verify that no other slots in the breeder reactor are empty
    -- oustide of the slots of consumable items like uranium fuel or depleted isotope cells
    -- if the breed reactor is not intact, then as a safety, no other items will be allowed
    -- to fill the chambers until it is resolved
    for k, v in pairs(chamber.list()) do
        -- check to see if slot is empty (nil)
        if chamber.list()[k] == nil then
            -- slot is empty, check to see if it's an expected slot
            if k ~= uraniumSlot and k ~= northDepletedSlot and k ~= westDepletedSlot and k ~= eastDepletedSlot and k ~= southDepletedSlot then
                return false
            end
        end
    end
    return true
end

local function getRequiredCells()
    -- check if additional uranium fuel or depleted cells to be enriched are required 
    -- (located NSEW of the quad uranium cell fuel input)

    -- table used to store indices of required cells
    local slots = {}

    -- check north depleted isotope cell slot
    if chamber.list()[northDepletedSlot] == nil then table.insert(slots, northDepletedSlot) end

    -- check west depleted isotope cell slot
    if chamber.list()[westDepletedSlot] == nil then table.insert(slots, westDepletedSlot) end

    -- check quad uranium fuel cell slot
    if chamber.list()[uraniumSlot] == nil then table.insert(slots, uraniumSlot) end

    -- check east depleted isotope cell slot
    if chamber.list()[eastDepletedSlot] == nil then table.insert(slots, eastDepletedSlot) end

    -- check south depleted isotope cell slot
    if chamber.list()[southDepletedSlot] == nil then table.insert(slots, southDepletedSlot) end

    return slots
end

local function refillUraniumCell()
    -- turn on redstone signal for 3 seconds, which should be enough time
    -- for the redstone engine to push one item into the reactor chamber
    redstone.setOutput("left", true)
    sleep(3)
    redstone.setOutput("left", false)
end

local function refillDepletedCell()
    -- turn on redstone signal for 3 seconds, which should be enough time
    -- for the redstone engine to push one item into the reactor chamber
    redstone.setOutput("front", true)
    sleep(3)
    redstone.setOutput("front", false)
end

local function refillCells(slots)
    for k, v in pairs(slots) do
        if v == northDepletedSlot or v == westDepletedSlot or v == eastDepletedSlot or v == southDepletedSlot then
            refillDepletedCell()
        elseif v == uraniumSlot then
            refillUraniumCell()
        end
        -- allow time for item to travel and fill the chamber slot
        sleep(30)
    end                
end

function MainLoop()
    while true do
        if verifyIntegrity() then refillCells(getRequiredCells()) end
        sleep(5)
    end
end

MainLoop()