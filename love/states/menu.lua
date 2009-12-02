states.menu = {
  draw = function(s)
    love.graphics.print("HAIRY!!!!", 400, 300)
    love.graphics.print("Click to begin", 400, 340)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) then
      states.game:initialize()
      changeState( states.game )
    end
  end,
}

mixin( states.menu, states.base )
