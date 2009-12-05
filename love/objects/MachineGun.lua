require "objects/DrawablePoly.lua"

MachineGun = {
  intensity = 30,
  time = 4.0, 

  load = function( world, x, y, orientation )
    local self = {}
    mixin( self, MachineGun )
    mixin( self, DrawablePoly )
    self.x = x
    self.y = y
    self.body = love.physics.newBody( world, x, y, 0, 0 )
    self.world = world

    self.orientation = orientation
    self.color = { 150, 120, 130 }
    self.cooldown = math.random()

    self.poly = love.physics.newRectangleShape( self.body, 0, 0, SIZE * 60, SIZE * 60, 0 )
    self.poly:setSensor(true)
    self.poly:setData(self)
    return self
  end,

  fire = function(self)
    local p = states.game:addPresent(self.x, self.y)
    local cx, cy
    cx = math.cos(self.orientation) * self.intensity
    cy = math.sin(self.orientation) * self.intensity
    p.body:applyImpulse(cx, cy, self.x, self.y)
    self.cooldown = math.random()
  end,

  update = function(self, dt)
    self.cooldown = self.cooldown + dt
    if self.cooldown > self.time then self:fire() end
  end,
}
