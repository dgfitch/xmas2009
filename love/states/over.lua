states.over = {
  draw = function(s)
    local score = states.game.score
    love.graphics.print("SANTA HAS DEPARTED", WIDTH / 3, 220)
    love.graphics.print("You and the elves have shipped:", WIDTH / 3, 300)
    love.graphics.print(score.good .. " pounds of good presents", WIDTH / 3, 340)
    love.graphics.print(score.duds .. " pounds of duds", WIDTH / 3, 380)
    love.graphics.print(score.coal .. " pounds of coal", WIDTH / 3, 420)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) then
      changeState( states.menu )
    end
  end,
}

mixin( states.over, states.base )
