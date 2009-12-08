require "objects/DrawablePoly.lua"

Goal = {
  load = function( world, polys )
    local self = {}
    mixin( self, Goal )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0, 0 )

    self.color = { 255, 255, 255, 50 }

    self.polys = {}
    for i,poly in ipairs(polys) do
      local p = love.physics.newPolygonShape( self.body, unpack(poly) )
      p:setData(self)
      p:setSensor(true)
      table.insert(self.polys, p)
    end
    return self
  end,

  setAngle = function(s, a)
    s.body:setAngle( a )
  end,
}
