require "objects/DrawablePoly.lua"

Cursor = {
  load = function( world )
    local self = {}
    mixin( self, Cursor )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, 0, 0, 0, 0 )
    self.color = { 255,255,255 }
    self.colorLine = { 0, 0, 0 }
    self.poly = love.physics.newPolygonShape( self.body, 0, 0, 18, 20, 0, 26 )
    self.poly:setSensor(true)
    self.poly:setData(self)
    self:setPosition()
    return self
  end,

  connect = function(s, x, y)
    if #states.game.objects > 1 then
      local o = states.game.objects[2]
      s.joint = love.physics.newMouseJoint( o.body, x, y )
      s.joint:setMaxForce(50)
      s.connected = true
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
  end
}


