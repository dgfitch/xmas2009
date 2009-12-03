require "objects/DrawablePoly.lua"

PolyTest = {
  load = function( world, x, y )
    local self = {}
    mixin( self, SimpleRect )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0.5, 10 )
    self.size = math.random(60) + 20
    self.color = { 255,255,255 }
    self.poly = love.physics.newPolygonShape( self.body, 0, 10, 15, 0, 8, -12, -8, -12, -15, 0)
    self.poly:setData(self)
    self.body:setAngle ( math.random() * math.twopi )
    return self
  end,
}

