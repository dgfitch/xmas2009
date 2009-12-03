require "objects/DrawablePoly.lua"

SimpleRect = {
  load = function( world, x, y, width, height, color, static )
    local self = {}
    mixin( self, SimpleRect )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0.5, 10 )

    ---- this is wrong
    --if static then self.body:setStatic() end

    local size = math.random(60) + 20
    if not width then width = size end
    if not height then height = size end

    if color then
      self.color = color
    elseif math.random() < 0.5 then
      self.color = { math.random(255), 0, 0 }
    else
      self.color = { 0, math.random(255), 0 }
    end

    self.poly = love.physics.newRectangleShape( self.body, 0, 0, width, height, math.random() * math.twopi )
    self.body:setMassFromShapes()
    return self
  end,
}
