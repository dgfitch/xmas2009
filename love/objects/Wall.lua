require "objects/DrawablePoly.lua"

Wall = {
  restitution = 0.1,

  load = function( world, polys )
    local self = {}
    mixin( self, Wall )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0, 0 )

    self.color = { 64, 64, 64, 255 }
    self:loadPolys( polys )
    return self
  end,

  setAngle = function(s, a)
    s.body:setAngle( a )
  end,

}
