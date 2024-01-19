local map = require "map"

local spaceship = {
    restitution = 0.9,
    angularDamping = 0.5,
    linearDamping = 0.5,
    density = 1,
    x = map.width/2,
    y = map.height/2,
    thrust_power = 500,
    vectorial = 200,
    points = {},
    controls = {}
}
spaceship.__index = spaceship

function spaceship:new(ship,points,magnify)
    local magnify = magnify and magnify>0 and magnify or 1
    local ship = ship or {}
    for i,point in ipairs(points) do
        points[i] = point*magnify
    end
    local triangles = love.math.triangulate(points)

    setmetatable(ship,self)
    ship.body = love.physics.newBody(map.world, ship.x, ship.y, "dynamic")
    ship.fixtures = {}
    for k,v in ipairs(triangles) do
        ship.fixtures[k] = love.physics.newFixture(ship.body, love.physics.newPolygonShape(v), ship.density)
        ship.fixtures[k]:setRestitution(ship.restitution)
    end
    ship.points = points
    table.insert(ship.points,ship.points[1])
    table.insert(ship.points,ship.points[2])
    ship.com_x,ship.com_y,ship.mass,ship.inertia = ship.body:getMassData()
    ship.body:setAngularDamping(ship.angularDamping)
    ship.body:setLinearDamping(ship.linearDamping)
    return ship
end

-- controls
function spaceship:connect(key,procedure)
    self.controls[key] = procedure
end

function spaceship:draw(mode)
    for __,fixture in ipairs(self.fixtures) do
        local shape = fixture:getShape()

        if mode == "fill" then
            love.graphics.polygon("fill", self.body:getWorldPoints(shape:getPoints()))
        elseif mode == "line" then
            --love.graphics.line(self.body:getWorldPoints(shape:getPoints()))
            love.graphics.line(self.body:getWorldPoints(unpack(self.points)))
        end
        --[[
        local x
        for k,point in ipairs({self.body:getWorldPoints(shape:getPoints())}) do
            if k%2==0 then
                love.graphics.circle("fill", x, point, 5)
            else
                x = point
            end
        end
        ]]
    end
end

return spaceship
