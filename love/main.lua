require "load.lua"
require "lib/oo.lua"
require "lib/math.lua"
require "start.lua"
requireDir "objects/"

function love.draw()
  love.graphics.setCaption( 'Hairy Xmas! | FPS: ' .. love.timer.getFPS() )
  S:draw()
end

function love.update(dt)
	if love.keyboard.isDown( 'escape' ) then
    love.event.push('q')
	end
  S:update(dt)
end

function love.keypressed(k)
  if S.keypressed then S:keypressed(k) end
end

function love.keyreleased(k)
  if S.keyreleased then S:keyreleased(k) end
end

function love.mousepressed(x,y,b)
  if S.mousepressed then S:mousepressed(x,y,b) end
end

function love.mousereleased(x,y,b)
  if S.mousereleased then S:mousereleased(x,y,b) end
end
