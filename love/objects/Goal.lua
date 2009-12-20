require "objects/DrawablePoly.lua"

Goal = {
  sensor = true,
  static = true,

  load = function( world, polys )
    local self = {}
    mixin( self, Goal )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0, 0 )

    self.color = { 255, 255, 255, 50 }
    self:loadPolys( polys )
    return self
  end,

  contains = function(self, o) 
    if not o.body then return false end
    for i,poly in ipairs(self.polys) do
      if poly:testPoint(o.body:getPosition()) then return true end
    end
    return false
  end,
}
