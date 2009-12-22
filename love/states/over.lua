states.over = {
  draw = function(s)
    local score = states.game.score
    love.graphics.setFont(36)
    p("SANTA HAS DEPARTED", 220)
    love.graphics.setFont(12)
    p("This year, you and the elves have shipped:", 300)
    p(string.format("%g pounds of good presents", score.good), 340)
    p(string.format("%g pounds of broken presents", score.duds), 370)
    p(string.format("%g pounds of coal", score.coal), 400)
    local bad = score.duds + score.coal
    local total = score.good + bad
    local ratio = score.good / score.produced
    local percent = score.good / total
    p(string.format("ratio %g total %g good %g bad %g", ratio, total, score.good, bad), 20)

    local amount = "Bone-tired, the elves begin muttering complaints about how inefficient you were."
    if ratio > 0.95 then
      amount = "Mrs. Claus and the elves throw you a huge party! No presents were wasted."
    elseif ratio > 0.9 then
      amount = "The elf foreman tells you he's never seen such packing prowess! Almost no presents went wasted."
    elseif ratio > 0.8 then
      amount = "The elf workers are giddy and give you a huge hug. The majority of good presents reached their targets!"
    elseif ratio > 0.7 then
      amount = "The elves are surprised by how much you packed in, but some presents were left behind."
    elseif ratio > 0.6 then
      amount = "The elves are impressed with how much you crammed into the sleigh, but you can do better..."
    elseif ratio > 0.5 then
      amount = "Around the year-end eggnog, the elves say you did a passable job of packing, but they think next year will be better"
    elseif ratio > 0.25 then
      amount = "The overworked elves are confused by how few of their toys made it to the kids."
    end
    p(amount, 440)

    local happy = "Some" 
    local sad = "some" 
    if percent >= 1.0 then
      happy = "All of the"
      sad = "and nothing went wrong... Unbelievable job!"
    elseif percent > 0.95 then
      happy = "Almost every single one of the"
      sad = "and only a few were left out. Incredible skill!"
    elseif percent > 0.9 then
      happy = "Almost all of the good"
      sad = "and only a handful were disappointed. Amazing work!"
    elseif percent > 0.8 then
      happy = "Almost all of the good"
      sad = "and only a few kids are still sad. Good work!"
    elseif percent > 0.7 then
      happy = "Most"
      sad = "but some say that Santa is losing his touch. Passable packing!"
    elseif percent > 0.5 then
      happy = "Over half of the"
      sad = "but the others had a terrible Christmas. Maybe next year..."
    elseif percent > 0.25 then
      happy = "Some"
      sad = "but many lose their faith in Santa."
    elseif percent > 0.1 then
      happy = "Few of the good"
      sad = "because you ruined Christmas for a lot of poor children."
    else
      happy = "None of the poor"
      sad = "and the world stops believing in Santa Claus."
    end
       
    local summary = string.format("%s children are happy this year, %s", happy, sad)
    p(summary, 480)

    p("Press both mouse buttons to continue or ESC to quit", 520)
  end,

  update = function(s)
    if love.mouse.isDown( 'l' ) and love.mouse.isDown( 'r' ) then
      states.game:nextLevel()
      changeState( states.game )
    end
  end,
}

mixin( states.over, State )
