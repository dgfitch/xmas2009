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

  setPosition = function( s )
    s.body:setPosition( love.mouse.getX(), love.mouse.getY() )
  end
}


