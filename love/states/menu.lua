require "objects/Background.lua"

states.menu = {
  title = "Santa's BOXPLOSION!!",
  size = 100,

  draw = function(s)
    love.graphics.setFont(s.size)
    love.graphics.setColor( 255, 0, 0, 255 )
    p(s.title, HEIGHT / 3)
    love.graphics.setFont(28)
    p("Click to begin", HEIGHT * 3 / 4)
  end,

  update = function(s, dt)
    if love.mouse.isDown( 'l' ) then
      states.game:initialize()
      changeState( states.game )
    end
  end,
}

mixin( states.menu, State )
