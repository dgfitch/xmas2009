require "objects/DrawablePoly.lua"

Background = {
  t = 0,
  c1 = {200, 220, 255},
  c2 = {120, 80, 160},
  h1 = love.graphics.newImage( "graphics/hills1.png" ),
  h2 = love.graphics.newImage( "graphics/hills2.png" ),
  height1 = HEIGHT / 3,
  height2 = HEIGHT / 3 + ( SIZE * 15),

  load = function( owner )
    local self = {}
    mixin( self, Background )
    self.owner = owner
    return self
  end,

  average = function(self, i)
    if self.owner and self.owner.time then
      return (self.c1[i] * (1 - self.owner.time) + self.c2[i] * self.owner.time )
    else
      return self.c2[i]
    end
  end,

  draw = function(self)
    love.graphics.setColor( self:average(1), self:average(2), self:average(3) )
    love.graphics.rectangle( "fill", 0, 0, WIDTH, HEIGHT )
    local x1 = self.t * 2
    local x2 = self.t * 5
    love.graphics.draw( self.h1, x1-1024, self.height1 )
    love.graphics.draw( self.h1, x1, self.height1 )
    love.graphics.draw( self.h2, x2-1024, self.height2 )
    love.graphics.draw( self.h2, x2, self.height2 )
  end,

  update = function(self, dt)
    self.t = self.t + dt
  end,

  drawOverlay = function(self)
    local alpha = 100 
    if self.owner and self.owner.time then
      alpha = self.owner.time * 100
    end
    love.graphics.setColor( self:average(1), self:average(2), self:average(3), alpha )
    love.graphics.rectangle( 'fill', 0, 0, WIDTH, HEIGHT )
  end,
}

