require "load.lua"
requireDir "lib/"
require "start.lua"

function love.draw()
  love.graphics.setCaption( 'Hairy Xmas! | FPS: ' .. love.timer.getFPS() )
  S:draw()
end

function love.update(dt)
  S:update(dt)
end
