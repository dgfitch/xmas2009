require "objects/DrawablePoly.lua"

SimpleRect = {
  load = function( world, x, y )
    local self = {}
    mixin( self, SimpleRect )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0.5, 10 )
    self.size = math.random(60) + 20
    if math.random() < 0.5 then
      self.color = { math.random(255), 0, 0 }
    else
      self.color = { 0, math.random(255), 0 }
    end
    self.poly = love.physics.newRectangleShape( self.body, 0, 0, self.size, self.size, math.random() * math.twopi )
    return self
  end,
}
