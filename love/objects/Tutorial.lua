Tutorial = {
  display = 10.0,
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
    self.object = object
    self.active = true
  end,

  update = function(self, dt)
    if self.object.dead then
      self.active = false
    end
    if self.active then
      self.time = self.time + dt
    end
    if self:stop() then 
      self.active = false
      self.completed = true
    end
  end,

  draw = function(self)
    local x,y = self.object.body:getPosition()
    love.graphics.setFont(14)
    love.graphics.setColor( 0, 0, 0, 255 )
    love.graphics.printf(self.text, x, y, WIDTH / 4, "center")
  end,

  stop = function(self)
    return self.time > self.display
  end,
}

