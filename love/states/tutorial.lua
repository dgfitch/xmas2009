require "objects/Tutorial.lua"

local t = Tutorial.load

-- Types of "tutorial":
  -- event based
  -- object based
  -- relation based (object to object)


states.tutorial = {
  tutorials = {
    t({
      text = "This is a Present Gun. It fires presents!",
      trigger = function(object)
        return object:kindOf(MachineGun)
      end,
    }),
    t({
      text = "Help Santa send these Good Presents by moving them to the Goal.",
      trigger = function(object)
        return object:kindOf(Present) and not object.broken
      end,
    }),
    t({
      text = "Stop delivery of Bad Presents by moving them out of the goal area, or right click to destroy them.",
      trigger = function(object)
        return object:kindOf(Present) and object.broken
      end,
    }),
    t({
      text = "This is Coal. It pops out of packages if you destroy good ones or even bad ones inside the Goal.",
      trigger = function(object)
        return object:kindOf(Coal)
      end,
    }),
    t({
      text = "This is a Wall. Uh, that should be self explanatory, right?",
      trigger = function(object)
        return object:kindOf(Wall)
      end,
    }),
  },
  
  update = function(self, dt)
    local anyActive = false
    for k,v in pairs(self.tutorials) do
      if v.active then
        v:update(dt)
        anyActive = true
      end
    end
    if not anyActive then
      -- If there are any available tute objects, test and activate one
      local chosen = nil
      for k,v in pairs(self.tutorials) do
        if not chosen and not v.active and not v.completed then
          chosen = findOne(states.game.objects, v.trigger)
          if chosen then
            v:activate(chosen)
          end
        end
      end
    end
  end,

  draw = function(self, dt)
    for k,v in pairs(self.tutorials) do
      if v.active then v:draw() end
    end
  end
}

mixin( states.tutorial, State )

T = states.tutorial
