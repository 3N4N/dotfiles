--
-- mpv-timer
-- By AD2
--
-- A simple plugin for mpv which allows the user to set a starting time and an
-- ending time and see the time elapsed between those points with millisecond
-- precision.
--
-- Adjust keybindings by changing the quoted characters at the bottom of this
-- document.
--

start_time = nil
end_time = nil
total_time = nil

function set_start_time()
    -- Test that the file can be timed
    -- Code taken from the encode.lua script
    local path = mp.get_property("path")
    if not path then
        mp.osd_message("No file currently playing")
        return
    end
    if not mp.get_property_bool("seekable") then
        mp.osd_message("Cannot time non-seekable media")
        return
    end

    start_time = mp.get_property_number("time-pos");

    mp.osd_message(
        string.format("Start time is now at %s seconds",
                      seconds_to_time_string(start_time)),
        1
    )
    time()
end

function set_end_time()
    -- Test that the file can be timed
    -- Code taken from the encode.lua script
    local path = mp.get_property("path")
    if not path then
        mp.osd_message("No file currently playing")
        return
    end
    if not mp.get_property_bool("seekable") then
        mp.osd_message("Cannot time non-seekable media")
        return
    end

    end_time = mp.get_property_number("time-pos");

    mp.osd_message(
        string.format("End time is now at %s seconds",
                      seconds_to_time_string(end_time)),
        1
    )
    time()
end

function time()
    -- Only time if we have a start and end, otherwise return
    if start_time == nil or end_time == nil then
        return
    end

    -- Swap start and end if they are out of order
    if end_time <= start_time then
        mp.osd_message("Second timestamp is before the first")
        return
    end

    total_time = end_time - start_time

    -- Print the final time to the screen
    print_time()
end

function print_time()
    if total_time == nil then
        mp.osd_message("Time not set")
        return
    end

    mp.osd_message(
        string.format("Total time is %s", seconds_to_time_string(total_time)),
        2
    )
end

-- Function taken from the encode.lua script
function seconds_to_time_string(seconds)
    local ret = string.format("%02d:%02d.%03d"
        , math.floor(seconds / 60) % 60
        , math.floor(seconds) % 60
        , seconds * 1000 % 1000
    )
    if seconds > 3600 then
        ret = string.format("%d:%s", math.floor(seconds / 3600), ret)
    end
    return ret
end

mp.add_key_binding("Z", "set-start-time", set_start_time)
mp.add_key_binding("X", "set-end-time", set_end_time)
mp.add_key_binding("C", "print-time", print_time)
