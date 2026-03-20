-- more magic numbers (probably could simplify with %)

ROW_X            = { 60, 135, 210 }
SPAWN_Y          = -30
FLOOR_Y          = 330
PLAYER_Y         = 355
BLOCK            = 30
VISUAL_X_SPEED   = 0.2
DROID_SPEED_INIT = 0.08

DOT_COLORS = {
    top    = { r=255, g=220, b=50  },
    bottom = { r=50,  g=255, b=150 },
    left   = { r=50,  g=150, b=255 },
    right  = { r=255, g=100, b=200 },
}

DOT_SIDES = { 'top', 'bottom', 'left', 'right' }

player_row    = 2
visual_x      = 135
lives         = 3
score         = 0
droids_killed = 0
shake_frames  = 0
droid_speed   = DROID_SPEED_INIT

-- all above, could return as a table
--[[

-- here
local M = {}
...                     -- fills M
return M

-- main
val G = require "local" -- G=M
]]


function check_speed_bump ()
    if droids_killed > 0 and droids_killed % 5 == 0 then
        droid_speed = droid_speed + 0.01
    end
end

-- just call output.sound there (simplify!)
-- why all this checks?
function play_sound (path)
    local f = io.open(path, "r")
    if f then
        f:close()
        pico.output.sound(path)
    else
        print("SOUND NOT FOUND: " .. path)
    end
end

function shuffle_sides ()
    local t = { table.unpack(DOT_SIDES) }
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

function fmt_time (ms)
    local total_s = math.floor(ms / 1000)
    local mins    = math.floor(total_s / 60)
    local secs    = total_s % 60
    local mm      = mins < 10 and ("0" .. mins) or ("" .. mins)
    local ss      = secs < 10 and ("0" .. secs) or ("" .. secs)
    return mm .. ":" .. ss
end
