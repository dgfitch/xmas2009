states.menu = {
  draw = function(s)
    love.graphics.setFont(100)
    p("HAIRY XMAS!", HEIGHT / 3)
    love.graphics.setFont(28)
    p("Click to begin", HEIGHT * 3 / 4)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) then
      states.game:initialize()
      changeState( states.game )
    end
  end,
}

mixin( states.menu, states.base )
