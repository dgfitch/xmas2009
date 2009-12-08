require "objects/DrawablePoly.lua"

Coal = {
  load = function( world, x, y )
    local self = {}
    mixin( self, Coal )
    mixin( self, DrawablePoly )
    mixin( self, Grabbable )
    self.body = love.physics.newBody( world, x, y, 0, 0.1 )
    self.body:setAngularDamping(0.1)

    self.size = (math.random(10) + 20) * SIZE

    self.colorLine = { 0, 0, 0 }
    self.color = { 64, 64, 64 }

    self.poly = love.physics.newRectangleShape( self.body, 0, 0, self.size, self.size, 0 )
    self.poly:setData(self)
    self.poly:setRestitution(0.1)
    self.body:setMassFromShapes()
    return self
  end,

  setRandomAngle = function (s)
    s.body:setAngle( math.random() * math.twopi )
  end,
}
