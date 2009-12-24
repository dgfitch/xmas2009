Tutorial = {
  display = 3.0,
  time = 0,
  text = "UNDEFINED",

  load = function(opts)
    local self = {}
    mixin( self, Tutorial, opts )
    return self
  end,

  trigger = function(self)
    return true
  end,

  activate = function(self, object)
    local ox, oy = object:getPosition()
    object.tutorial = self
    self.x = WIDTH / 2
    self.y = HEIGHT / 2
    self.object = object
    self:rubberband(0.9)
    self.active = true
  end,

  rubberband = function(self, amount)
    local ox, oy = self.object:getPosition()
    local dx = math.abs(ox - self.x)
    local dy = math.abs(oy - self.y) 
    if dx < 40 and dy < 40 then
      amount = amount / 1000
    elseif dx < 60 and dy < 60 then
      amount = amount / 100
    elseif dx < 80 and dy < 80 then
      amount = amount / 10
    end
    self.x = self.x + ((ox - self.x) * amount)
    self.y = self.y + ((oy - self.y) * amount)
  end,

  update = function(self, dt)
    if self.object.dead then
      self.active = false
    else
      self:rubberband(0.1)
    end
    if self.active then
      self.time = self.time + dt
    end
    if self:stop() then 
      self.active = false
      self.object.tutorial = nil
      self.completed = true
    end
  end,

  draw = function(self)
    love.graphics.setFont(14)
    love.graphics.setColor( 0, 0, 0, 255 )
    love.graphics.printf(self.text, self.x, self.y, WIDTH / 4, "center")
  end,

  stop = function(self)
    return self.time > self.display
  end,
}

