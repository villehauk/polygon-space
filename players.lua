airship = require "airships"

local player = {
    players = {}
}
player.__index = player

function player:new(o)
    local o = o or {}
    setmetatable(self,o)
    o.spaceship = spaceship:new({},{
         0,  0,
        20,-20,
        30,-20,
        20,-10,
        40,  0,
        20, 10,
        30, 20,
        20, 20
    })
    self.players += o
end

function player.airhsip:forwards()
    self:move(self.thrust)
end

function player.airship:backwards()
    self:move(-self.thrust/2)
end

function player.airship:turn_right()
    self:turn(self.vectorial)
end

function player.airship:turn_right()
    self:turn(-self.vectorial)
end

players[1].airship:connect("w",players[1].airship:forwards())
players[1].airship:connect("s",players[1].airship:backwards())
players[1].airship:connect("a",players[1].airship:turn_left())
players[1].airship:connect("d",players[1].airship:turn_right())

players[2].airship:connect("up",players[2].airship:forwards())
players[2].airship:connect("down",players[2].airship:backwards())
players[2].airship:connect("left",players[2].airship:turn_left())
players[2].airship:connect("right",players[2].airship:turn_right())

return players
