states.menu = {
  draw = function(s)
    love.graphics.print("HAIRY!!!!", WIDTH / 2, 300)
    love.graphics.print("Click to begin", WIDTH / 2, 340)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) then
      states.game:initialize()
      changeState( states.game )
    end
  end,
}

mixin( states.menu, states.base )
