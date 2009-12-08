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

    local amount = "You hear rumors that the elves are threatening to strike."
    local happy = "Some" 
    local sad = "some" 
    if ratio > 0.5 then
      if total > 160 then
        amount = "Mrs. Claus and the elves throw you a huge party!"
      elseif total > 140 then
        amount = "The elf foreman tells you he's never seen such packing prowess!"
      elseif total > 130 then
        amount = "The elf workers are giddy and give you a huge hug."
      elseif total > 120 then
        amount = "The elves are surprised by how much you packed in."
      elseif total > 110 then
        amount = "The elves are impressed with how much you crammed into the sleigh."
      elseif total > 100 then
        amount = "Around the year-end eggnog, the elves say you did a passable job of packing."
      elseif total > 50 then
        amount = "Bone-tired, the elves begin muttering complaints about how inefficient you were."
      end
    end
    love.graphics.print(amount, WIDTH / 6, 440)

    if ratio >= 1.0 then
      happy = "All of the"
      sad = "there's always next year to screw up... Unbelievable job!"
    elseif ratio > 0.95 then
      happy = "Almost every single one of the"
      sad = "and only a few were left out. Incredible skill!"
    elseif ratio > 0.9 then
      happy = "Almost all of the good"
      sad = "and only a handful were disappointed. Amazing work!"
    elseif ratio > 0.8 then
      happy = "Almost all of the good"
      sad = "and only a few kids are still sad. Good work!"
    elseif ratio > 0.7 then
      happy = "Most"
      sad = "but some say that Santa is losing his touch. Passable packing!"
    elseif ratio > 0.5 then
      happy = "Over half of the"
      sad = "but the others had a terrible Christmas. It doesn't look great for next year..."
    elseif ratio > 0.25 then
      happy = "Some"
      sad = "but many lose their faith in Santa."
    elseif ratio > 0.1 then
      happy = "Few of the good"
      sad = "because you ruined Christmas for a lot of poor children."
    else
      happy = "None of the poor"
      sad = "and the world stops believing in Santa Claus."
    end
       
    local summary = string.format("%s children are happy this year, %s", happy, sad)
    love.graphics.print(summary, WIDTH / 6, 480)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) and love.mouse.isDown( 'r' ) then
      changeState( states.menu )
    end
  end,
}

mixin( states.over, states.base )
