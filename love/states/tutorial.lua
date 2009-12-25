require "objects/Tutorial.lua"

local t = Tutorial.load


states.tutorial = {
  tutorials = {
    t({
      text = "This is a Present Gun. It fires presents!",
      trigger = function(object)
        return object:kindOf(MachineGun)
      end,
    }),
    t({
      text = "This is Coal. If you destroy good packages or blow up bad ones inside the Goal, you get lumps of it. Kids don't like coal!",
      display = 6.0,
      trigger = function(object)
        return object:kindOf(Coal)
      end,
    }),
    t({
      text = "This is is a Present. Click and drag to move it.",
      trigger = function(object)
        return object:kindOf(Present)
      end,
    }),
    t({
      text = "This is the Goal. Move good presents in here!",
      trigger = function(object)
        return object:kindOf(Goal)
      end,
    }),
    t({
      text = "Stop delivery of Bad Presents by right clicking to destroy them, or by moving them out of the goal area.",
      display = 5.0,
      trigger = function(object)
        return object:kindOf(Present) and object.broken
      end,
    }),
    t({
      text = "Help Santa send these Good Presents by moving them to the Goal.",
      trigger = function(object)
        return object:kindOf(Present) and not object.broken
      end,
    }),
    t({
      text = "This is a Wall. Uh, that should be self explanatory, right?",
      trigger = function(object)
        return object:kindOf(Wall) and not object.bounding
      end,
    }),
  },
  
  update = function(self, dt)
    if S ~= states.game then return end
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
    if S ~= states.game then return end
    for k,v in pairs(self.tutorials) do
      if v.active then v:draw() end
    end
  end
}

mixin( states.tutorial, State )

T = states.tutorial
