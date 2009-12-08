require "objects/DrawablePoly.lua"

Cursor = {
  MAX_FORCE = 500,
  colorTouching = { 255,255,255,128 },
  colorCooldown = { 255,255,0,200 },
  color = { 255,255,255 },
  colorLine = { 0,0,0 },
  destroyTime = 0.2,

  load = function( world )
    local self = {}
    mixin( self, Cursor )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, 0, 0, 0, 0 )
    self.poly = love.physics.newPolygonShape( self.body, 0, 0, 18, 20, 0, 26 )
    self.poly:setSensor(true)
    self.detector = love.physics.newCircleShape( self.body, 0, 0, 5 )
    self.detector:setSensor(true)
    self.detector:setData(self)
    self:setPosition()
    self.cooldown = self.destroyTime
    return self
  end,

  touch = function(s, o)
    if not o.dead then 
      s.touching = o
    end
  end,

  untouch = function(s, o)
    if s.touching == o then
      s.touching = nil
    end
  end,

  click = function(s, x, y)
    if s.touching and s.touching:kindOf(Present) then
      s.joint = love.physics.newMouseJoint( s.touching.body, x, y )
      s.joint:setMaxForce(s.MAX_FORCE)
      s.connected = s.touching
    end
  end,

  clickr = function(s, x, y)
    if s.cooldown <= 0 then
      local destroyed
      if s.connected and s.joint then
        destroyed = s.connected
        s.connected.dead = true
        s:disconnect()
      elseif s.touching then
        destroyed = s.touching
        s.touching.dead = true
        s.touching = nil
      end
      if destroyed then
        s.cooldown = s.destroyTime
        local explosion
        local x, y = destroyed.body:getPosition()
        local size = destroyed.body:getMass()
        if destroyed.broken then
          explosion = DustExplosion:create(x, y, 30, 1.0 + (size / 10))
        else
          explosion = FireyExplosion:create(x, y, 50, 1.0 + (size / 10))
        end
        states.game:add(explosion)
      end
    end
  end,

  disconnect = function(s)
    if s.connected and s.joint then
      s.joint:destroy()
      s.connected = false
    end
  end,

  setPosition = function(s)
    local x, y = love.mouse.getX(), love.mouse.getY() 
    s.body:setPosition( x, y )
    if s.connected and s.joint then
      s.joint:setTarget( x, y )
    end
  end,

  update = function(self, dt)
    self:setPosition()
    if self.cooldown > 0 then 
      self.cooldown = self.cooldown - dt
    end
    if self.touching then
      if self.touching.dead then
        self.touching = nil
      elseif self.touching.poly then
        if not self.touching.poly:testPoint(self.body:getPosition()) then
          self.touching = nil
        end
      end
    end
  end,

  draw = function(self)
    local x, y = self.body:getPosition()
    love.graphics.setLineWidth( SIZE )
    if self.touching then
      love.graphics.setColor( unpack( self.colorTouching ) )
      love.graphics.circle( 'fill', x, y, 4, 20 )
    end
    if self.cooldown > 0 then
      love.graphics.setColor( unpack( self.colorCooldown ) )
      love.graphics.circle( 'line', x, y, self.cooldown * 2, 20 )
    end
    if self.connected then
      DrawablePoly.draw(self, 3)
    else
      DrawablePoly.draw(self)
    end
  end
}


