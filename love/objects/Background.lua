require "objects/DrawablePoly.lua"

Background = {
  t = 0,
  c1 = {220, 240, 255},
  c2 = {120, 80, 160},
  h1 = love.graphics.newImage( "graphics/hills1.png" ),
  h2 = love.graphics.newImage( "graphics/hills2.png" ),
  height1 = HEIGHT / 3,
  height2 = HEIGHT / 3 + (SIZE * 45),
  flake8 = love.graphics.newImage( "graphics/flake8.png" ),

  load = function( )
    local self = {}
    mixin( self, Background )
    self.snow1 = love.graphics.newParticleSystem( self.flake8, 50 )
    self.initSnow(self.snow1, 30)
    self.snow2 = love.graphics.newParticleSystem( self.flake8, 50 )
    self.initSnow(self.snow2, 20)
    return self
  end,

  initSnow = function(p, gravity)
    p:setEmissionRate(6)
    p:setParticleLife(5)
    p:setDirection(math.pi / 2)
    p:setSpread(math.pi)
    p:setRotation(0,360)
    p:setSpin(0,360,1.0)
    p:setGravity(gravity or 10)
    p:setSize(1,0.9)
    p:setSpeed(80,120)
  end,

  average = function(self, i)
    return (self.c1[i] * (1 - self:ownertime()) + self.c2[i] * self.ownertime() )
  end,

  draw = function(self)
    love.graphics.setBackgroundColor( self:average(1), self:average(2), self:average(3) )
    --love.graphics.rectangle( "fill", 0, 0, WIDTH, HEIGHT )
    local x1 = self.t * 4
    while x1 > WIDTH do
      x1 = x1 - WIDTH  
    end
    local x2 = self.t * 9
    while x2 > WIDTH do
      x2 = x2 - WIDTH  
    end
    love.graphics.setBlendMode( "alpha" )
    love.graphics.setColor( 235, 235, 235, 160 )
    love.graphics.draw( self.h1, x1-1024, self.height1 )
    love.graphics.draw( self.h1, x1, self.height1 )
    love.graphics.setColor( 255, 255, 255 )
    love.graphics.draw( self.h2, x2-1024, self.height2 )
    love.graphics.draw( self.h2, x2, self.height2 )
    local sx1 = WIDTH / 2 + math.sin(x1 / 10) * 40
    local sx2 = WIDTH / 2 + math.sin(x2 / 10) * 40
    love.graphics.draw( self.snow1, sx1, -20)
    love.graphics.draw( self.snow2, sx2, -20)
  end,

  update = function(self, dt)
    self.t = self.t + dt
    local snowRate = dt / (5 - self:ownertime() * 2)
    self.snow1:update(snowRate)
    self.snow2:update(snowRate)
  end,

  ownertime = function(self)
    if S and S.time then
      return S.time
    else
      return 1.0
    end
  end,

  drawOverlay = function(self)
  end,
}

