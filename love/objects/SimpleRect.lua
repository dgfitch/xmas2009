require "objects/DrawablePoly.lua"

SimpleRect = {
  load = function( world, x, y, width, height, color, static )
    local self = {}
    mixin( self, SimpleRect )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0, 0 )

    local size = math.random(60) + 20
    width = width or size
    height = height or size

    if color then
      self.color = color
    elseif math.random() < 0.5 then
      self.color = { math.random(255), 0, 0 }
    else
      self.color = { 0, math.random(255), 0 }
    end

    self.poly = love.physics.newRectangleShape( self.body, 0, 0, width, height, 0 )
    self.poly:setData(self)
    if not static then 
      self.body:setMassFromShapes()
    end
    return self
  end,

  setAngle = function(s, a)
    s.body:setAngle( a )
  end,

}
