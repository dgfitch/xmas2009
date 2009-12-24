states = {}
State = {
  draw = function(s) end,
  update = function(s, dt) end,
  activate = function(s) end,
  initialize = function(s) end,
}

function changeState(i)
  background.owner = i
  S = i
  S:activate()
end

requireDir "states/"
states.menu:initialize()
changeState(states.menu)
