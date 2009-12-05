require "objects/DrawablePoly.lua"

Present = {
  load = function( world, x, y )
    local self = {}
    mixin( self, Present )
    mixin( self, DrawablePoly )
    self.body = love.physics.newBody( world, x, y, 0, 0 )

    local size = math.random(60) + 20 * SIZE
    self.width = size
    self.height = size

    if color then
      self.color = color
    elseif math.random() < 0.5 then
      self.color = { math.random(100,255), 0, 0 }
    else
      self.color = { 0, math.random(100,255), 0 }
    end

    local r = math.random()
    if r < 0.4 then
      self.colorRibbon = { math.random(200,255), math.random(200,255), 0 }
    elseif r < 0.7 then
      self.colorRibbon = { math.random(230,255), math.random(230,255), 50 }
    elseif r > 0.8 then
      local i = r * 255
      self.colorRibbon = { i, i, i }
    else
      self.colorRibbon = { 50, 50, math.random(200,255) }
    end

    self.poly = love.physics.newRectangleShape( self.body, 0, 0, self.width, self.height, 0 )
    self.poly:setData(self)
    if not static then 
      self.body:setMassFromShapes()
    end
    return self
  end,

  setRandomAngle = function (s)
    s.body:setAngle( math.random() * math.twopi )
  end,

  draw = function(self)
    DrawablePoly.draw(self)

    local x, y = self.body:getPosition()
    local theta = self.body:getAngle()

    love.graphics.setColor( unpack( self.colorRibbon ) )

    love.graphics.setLineWidth( (self.width + self.height) / 20.0 )

    local chx = math.cos(theta) * self.height / 2
    local chy = math.sin(theta) * self.height / 2
    love.graphics.line( x - chx, y - chy, x + chx, y + chy )

    local cwx = math.cos(theta + math.halfpi) * self.width / 2
    local cwy = math.sin(theta + math.halfpi) * self.width / 2
    love.graphics.line( x - cwx, y - cwy, x + cwx, y + cwy )
  end,
}
