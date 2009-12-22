Tutorial = {
  display = 5.0,
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
    love.graphics.printf(self.text, x, y, WIDTH / 2, "left")
    p(x, 200)
  end,

  stop = function(self)
    return self.time > self.display
  end,
}

