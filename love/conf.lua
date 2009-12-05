WIDTH=800
HEIGHT=600
SIZE=WIDTH/800.0
function love.conf(t)
  t.modules.joystick = false
  t.title = "Hairy Xmas"
  t.author = "Dan Fitch"
  t.screen.width = WIDTH
  t.screen.height = HEIGHT
  --t.screen.fullscreen = true
end
