Tutorial = {
  display = 5.0,
  time = 0,
  text = "UNDEFINED",

  load = function(opts)
    local self = {}
    mixin( self, Tutorial )
    mixin( self, opts )
    return self
  end,

  trigger = function(self)
    return true
  end,

  update = function(self, dt)
    self.time = self.time + dt
  end,

  stop = function(self)
    return self.time > self.display
  end,
}

