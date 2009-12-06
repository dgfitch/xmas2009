require "objects/DrawablePoly.lua"

Background = {
  load = function( game )
    local self = {}
    mixin( self, Background )
    self.game = game
    self.c1 = {200, 220, 255}
    self.c2 = {120, 80, 160}
    return self
  end,

  average = function(self, i)
    --return (self.c1[i] + self.c2[i]) / 2
    return (self.c1[i] * (1 - self.game.time) + self.c2[i] * self.game.time )
  end,

  draw = function(self)
    love.graphics.setBackgroundColor( self:average(1), self:average(2), self:average(3) )
  end,

  drawOverlay = function(self)
    love.graphics.setColor( self:average(1), self:average(2), self:average(3), self.game.time * 100 )
    love.graphics.rectangle( 'fill', 0, 0, WIDTH, HEIGHT )
  end,
}

