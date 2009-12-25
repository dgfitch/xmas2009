require "objects/Background.lua"

states.menu = {
  title = "Santa's BOXPLOSION!!",
  titleImage = love.graphics.newImage( "graphics/title.png" ),
  t = 0,
  time = 0.3,

  draw = function(s)
    local size = 0.7 * SIZE + (math.sin(s.t / 5) / 30) 
    love.graphics.draw( s.titleImage, WIDTH / 2, HEIGHT / 2, 0, size, size, 512, 256 )
  end,

  update = function(s, dt)
    s.t = s.t + dt
    if love.mouse.isDown( 'l' ) then
      states.game:initialize()
      changeState( states.game )
    end
  end,
}

mixin( states.menu, State )
