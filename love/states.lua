states = {}
states.base = {
  draw = function(s) end,
  update = function(s, dt) end,
  activate = function(s, dt) end,
  initialize = function(s, dt) end,
}

function changeState(i)
  S = i
  S:activate()
end

requireDir "states/"
changeState(states.menu)
