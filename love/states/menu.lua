states.menu = {
  draw = function(s)
    love.graphics.print("HAIRY!!!!", 400, 300)
    love.graphics.print("Press space to begin", 400, 340)
  end,
}

mixin(states.menu, states.base)
