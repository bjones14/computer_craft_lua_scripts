local wireless = peripheral.wrap("top")
local monitor = peripheral.wrap("right")

local mon_width, mon_height = monitor.getSize()
   
function OpenWireless()
    rednet.open("top")
end

function WriteLine(sender, message)
    local mX, mY = monitor.getCursorPos()
    local next_mY = mY + 1

    local output_string = os.date("%m/%d/%y %H:%m:%S") .. " [" .. sender .. "] " .. message
    print(output_string)

    if next_mY >= mon_height then
        -- set the cursor position to beginning of the second to last row
        monitor.setCursorPos(1,mon_height-1)

        -- scroll the text up by one row and redraw the MOTD
        monitor.scroll(1)
        MOTD()

        -- write the output string and then set the cursor to the last blank row
        monitor.write(output_string)
        monitor.setCursorPos(1,mon_height)
    else
        -- screen has not filled up yet, write the output and increment cursor to the next row
        monitor.write(output_string)
        monitor.setCursorPos(1,next_mY)
    end
end

function HandleReceivedData()
    local sender, message = rednet.receive()
    WriteLine(sender, message)
end

function MOTD()
    -- displays a message of the day banner on the top of the console monitor
    
    -- store previous position to be restored after MOTD is updated
    local pre_x, pre_y = monitor.getCursorPos()

    monitor.setCursorPos(1,1)
    monitor.write("     clan {sp} Tekkit 2 Server - Status Viewer    ")
    monitor.setCursorPos(1,2)
    monitor.write("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
    monitor.setCursorPos(1,3)

    -- if the cursor was already set at a row greater than where the MOTD ends
    -- then restore it here - otherwise, leave it at the next row after the MOTD
    if pre_y >= 3 then
        monitor.setCursorPos(pre_x, pre_y)
    end
end

function InitMonitor()
    monitor.clear()
    monitor.setCursorPos(0,0)
    MOTD()
    monitor.setCursorBlink(true)
end

function MainLoop()
    InitMonitor()
    while true do
        sleep(1)
        OpenWireless()
        parallel.waitForAny(HandleReceivedData)
    end
end

MainLoop()