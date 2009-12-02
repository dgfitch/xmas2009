require "load.lua"
require "lib/oo.lua"
require "lib/math.lua"
require "start.lua"
require "objects/SimpleRect.lua"
-- requireDir "objects/"

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
