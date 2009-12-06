Explosion = {
  life = 0,

  draw = function(self)
    local x, y = self.x, self.y
    
    love.graphics.setColorMode('modulate')
    love.graphics.draw(self.smoke,x,y)
    love.graphics.setBlendMode('additive')
    love.graphics.draw(self.fire,x,y)
    love.graphics.setColorMode('replace')
    love.graphics.setBlendMode('alpha')
  end,

  update = function(self, dt)
    self.life = self.life + dt
    if self.life * 10 > self.duration then
      self.dead = true
    else
      self.fire:update(dt)
      self.smoke:update(dt)
    end
  end,

  create = function(self, params)
    local result = {}
    mixin(result, params)
    mixin(result, Explosion)
    
    result.fire = love.graphics.newParticleSystem(result.brightImage, 300)
    local f = result.fire
    f:setDirection(0)
    f:setSpread(360)
    f:setRotation(0,360)
    f:setSpin(0,360,4.0)
    f:setGravity(0)
    f:setSize(2 * result.size, 0.2 * result.size, 0.1)
    f:setColor(unpack(result.fireColor))

    if result.slowdown then
      f:setEmissionRate(8)
      f:setSpeed(30 * result.size,35 * result.size)
      f:setLifetime(result.duration/90)
      f:setParticleLife(2,3)
      f:setRadialAcceleration(-10,-10)
    else
      f:setEmissionRate(60)
      f:setSpeed(75 * result.size,125 * result.size)
      f:setLifetime(result.duration/240)
      f:setParticleLife(0.25,0.4)
      f:setRadialAcceleration(-100,-100)
    end
    
    result.smoke = love.graphics.newParticleSystem(result.smokeImage, 300)
    local s = result.smoke
    s:setEmissionRate(12)
    s:setLifetime(result.duration/120)
    s:setParticleLife(2,3)
    s:setDirection(0)
    s:setRotation(0,360)
    s:setSpread(360)
    s:setSpeed(30*result.size)
    s:setGravity(0)
    s:setSize(2.0*result.size, 1.2*result.size, 2.0)
    s:setColor(unpack(result.smokeColor))
    
    s:start()
    f:start()
    return result
  end
}

FireyExplosion = {
  create = function(self, x, y, duration, size)
    return Explosion:create(
    {
      x = x,
      y = y,
      duration = duration,
      size = size,

      brightImage = love.graphics.newImage("graphics/spark.png"),
      fireColor = {255, 216, 192, 255, 220, 64, 0, 200},
      
      smokeImage = love.graphics.newImage("graphics/smoke.png"),
      smokeColor = {128,128,128,200,64,64,64,0},
    })
  end
}

DustExplosion = {
  create = function(self, x, y, duration, size)
    return Explosion:create(
    {
      x = x,
      y = y,
      duration = duration,
      size = size,

      brightImage = love.graphics.newImage("graphics/smoke.png"),
      fireColor = {128, 128, 128, 200, 128, 128, 128, 0},
      
      smokeImage = love.graphics.newImage("graphics/smoke.png"),
      smokeColor = {192,192,192,180,64,64,64,0},
    })
  end
}
