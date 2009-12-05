require "objects/DrawablePoly.lua"

Cursor = {
  MAX_FORCE = 200,
  colorTouching = { 255,255,255,128 },
  colorConnected = { 255,255,255,200 },
  color = { 255,255,255 },
  colorLine = { 0,0,0 },

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
    return self
  end,

  touch = function(s, o)
    s.touching = o
  end,

  connect = function(s, x, y)
    if s.touching then
      -- TODO: double check cursor is still touching
      s.joint = love.physics.newMouseJoint( s.touching.body, x, y )
      s.joint:setMaxForce(s.MAX_FORCE)
      s.connected = s.touching
    end
  end,

  destroy = function(s, x, y)
    if s.connected and s.joint then
      s:disconnect()
    end
    if s.touching then
      s.touching.dead = true
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

  update = function(s, dt)
    s:setPosition()
  end,

  draw = function(self)
    local x, y = self.body:getPosition()
    love.graphics.setLineWidth( SIZE )
    if self.touching then
      love.graphics.setColor( unpack( self.colorTouching ) )
      love.graphics.circle( 'line', x, y, 8, 20 )
    end
    if self.connected then
      DrawablePoly.draw(self, 3)
    else
      DrawablePoly.draw(self)
    end
  end
}


