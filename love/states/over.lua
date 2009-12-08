states.over = {
  draw = function(s)
    local score = states.game.score
    love.graphics.print("SANTA HAS DEPARTED", WIDTH / 3, 220)
    love.graphics.print("You and the elves have shipped:", WIDTH / 3, 300)
    love.graphics.print(string.format("%g pounds of good presents", score.good), WIDTH / 3, 340)
    love.graphics.print(string.format("%g pounds of broken presents", score.duds), WIDTH / 3, 370)
    love.graphics.print(string.format("%g pounds of coal", score.coal), WIDTH / 3, 400)
    local bad = score.duds + score.coal
    local total = score.good + bad
    local ratio = score.good / total
    love.graphics.print(string.format("ratio %g total %g good %g bad %g", ratio, total, score.good, bad), WIDTH / 3, 100)

    local amount = ""
    local happy = "Some" 
    local sad = "some" 
    if total > 200 then
      amount = "The elf foreman tells you he's never seen such packing prowess!"
    elseif total > 150 then
      amount = "The elves are impressed with how much you crammed into the sleigh."
    elseif total > 100 then
      amount = "Around the year-end eggnog, the elves say you did a passable job of packing."
    elseif total > 50 then
      amount = "Bone-tired, the elves begin muttering complaints about how inefficient you were."
    else
      amount = "You hear rumors that the elves are threatening to strike."
    end
    love.graphics.print(amount, WIDTH / 6, 440)

    if ratio >= 1.0 then
      happy = "All of the"
      sad = "there's always next year to screw up..."
    elseif ratio > 0.9 then
      happy = "Almost all of the good"
      sad = "but a handful were very sad."
    elseif ratio > 0.7 then
      happy = "Most"
      sad = "but some say that Santa is losing his touch."
    elseif ratio > 0.5 then
      happy = "Over half"
      sad = "but the others had a terrible Christmas."
    elseif ratio > 0.3 then
      happy = "Some"
      sad = "but many lose their faith in Santa."
    elseif ratio > 0.2 then
      happy = "Few"
      sad = "because you ruined Christmas for a lot of poor children."
    else
      happy = "No"
      sad = "and the world stops believing in Santa Claus."
    end
       
    local summary = string.format("%s children are happy this year, %s", happy, sad)
    love.graphics.print(summary, WIDTH / 6, 480)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) then
      changeState( states.menu )
    end
  end,
}

mixin( states.over, states.base )
