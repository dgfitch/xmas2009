require "objects/DrawablePoly.lua"

Present = {
  load = function( world, x, y )
    local self = {}
    mixin( self, Present )
    mixin( self, DrawablePoly )
    mixin( self, Destroyable )
    mixin( self, Grabbable )
    self.body = love.physics.newBody( world, x, y, 0, 0.1 )
    self.body:setAngularDamping(0.1)

    self.width = (math.random(60) + 30) * SIZE
    self.height = (math.random(60) + 30) * SIZE

    local saturation = 0
    if math.random() < 0.5 then
      self.broken = true
      saturation = math.random(80,160)
    end

    self.colorLine = { 0, 0, 0 }
    if math.random() < 0.5 then
      self.color = { math.random(100,255), saturation, saturation }
    else
      self.color = { saturation, math.random(100,255), saturation }
    end

    local r = math.random()
    if r < 0.4 then
      self.colorRibbon = { 255, 255, math.random(230,250) }
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
    self.poly:setRestitution(0.5)
    self.body:setMassFromShapes()
    return self
  end,

  setRandomAngle = function (s)
    s.body:setAngle( math.random() * math.twopi )
  end,

  draw = function(self)
    local x, y = self.body:getPosition()
    local theta = self.body:getAngle()

    local chx = math.cos(theta + math.halfpi) * self.height / 2
    local chy = math.sin(theta + math.halfpi) * self.height / 2

    local bowx = chx * 0.8
    local bowy = chy * 0.8

    local cwx = math.cos(theta) * self.width / 2
    local cwy = math.sin(theta) * self.width / 2

    local bowax = cwx * 0.2
    local boway = cwy * 0.2

    -- bow behind package
    love.graphics.setColor( unpack( self.colorRibbon ) )
    love.graphics.setLineWidth( (self.width + self.height) / 18.0 )
    if not self.broken then
      love.graphics.circle( 'line', x + bowx + bowax, y + bowy + boway, self.width / 5, 11 )
      love.graphics.circle( 'line', x + bowx - bowax, y + bowy - boway, self.width / 5, 13 )
    end
    
    DrawablePoly.draw(self)

    -- ribbons over package
    love.graphics.setColor( unpack( self.colorRibbon ) )
    love.graphics.setLineWidth( (self.width + self.height) / 20.0 )
    love.graphics.line( x - chx, y - chy, x + chx, y + chy )
    if not self.broken then
      love.graphics.line( x - cwx, y - cwy, x + cwx, y + cwy )
    elseif self.ribbonTrail then
      local r = self.ribbonTrail
      for v = 1, #r-3, 2 do
        love.graphics.line(chx + r[v], chy + r[v+1], chx + r[v+2], chy + r[v+3])
      end
    end
  end,

  update = function(self, dt)
    if self.broken then
      local r = self.ribbonTrail or {}
      local x,y = self.body:getPosition()
      if #r < 20 then 
        table.insert(r, x)
        table.insert(r, y)
      else
        for v = 1, 20, 2 do
          r[v] = r[v+2] 
          r[v+1] = r[v+3] 
        end
        r[19] = x
        r[20] = y
      end
      self.ribbonTrail = r
    end
  end,
}
