-- a machine gun that shoots presents
states.game = {
  wallColor = {100,100,100},

  initialize = function(s)
    s.time = 0.0
    s.speed = 0.02
    s.gravity = 250

    s.objects = {}

    s.world = love.physics.newWorld( -10, -10, WIDTH + 10, HEIGHT + 10, 0, s.gravity )
    s.world:setCallbacks( s.collisionAdd, nil, nil, nil )

    -- bounding
    s:addWall( WIDTH/2, -10, WIDTH + 10, 10 )
    s:addWall( -10, HEIGHT/2, 10, HEIGHT + 10 )
    s:addWall( WIDTH + 10, HEIGHT/2, 10, HEIGHT + 10 )
    s:addWall( WIDTH/2, HEIGHT + 10, WIDTH + 10, 10 )

    -- "level design" 
    s:addWall( WIDTH/6, HEIGHT*3/5, WIDTH/2.7, 10 * SIZE )
    s:addWall( WIDTH - WIDTH/6, HEIGHT*3/5, WIDTH/2.7, 10 * SIZE )

    s.goal = Goal.load( s.world,
      {
        { 0, HEIGHT*3/5, WIDTH, HEIGHT*3/5, WIDTH, HEIGHT, 0, HEIGHT },
        --{ WIDTH/6, HEIGHT*2/5, WIDTH - WIDTH/6, HEIGHT*2/5, WIDTH, HEIGHT, 0, HEIGHT },
      } )
    --s:addWall( WIDTH/3 + WIDTH/16, HEIGHT*2/3, WIDTH/7, 10 * SIZE, math.halfpi / 2 )
    --s:addWall( WIDTH - (WIDTH/3 + WIDTH/16), HEIGHT*2/3, WIDTH/7, 10 * SIZE, math.halfpi / -2 )

    -- present firing guns
    local mx = 30 * SIZE
    local my = 40 * SIZE
    s.gun1 = s:add( MachineGun.load( s.world, mx, my, 0 ) )
    s.gun2 = s:add( MachineGun.load( s.world, WIDTH - mx, my, math.pi * -1 ) )
    
    s.cursor = Cursor.load( s.world )
    love.mouse.setVisible( false )

    s.background = Background.load( s )
  end,

  draw = function(s)
    s.background:draw()
    s.goal:draw()
    love.graphics.setColor( 255, 0, 0 )
    love.graphics.print("HAHA GAME LOL", 100, 20)
    for k,v in pairs(s.objects) do
      if v.draw then v:draw() end
    end
    s.background:drawOverlay()
    s.cursor:draw()
  end,

  update = function(s, dt)
    s.cursor:update( dt )
    for i,v in ipairs( s.objects ) do
      if v.update then v:update( dt ) end
    end
    s.world:update( dt )
    s:updateTime( dt )
    s:cleanup()
  end,

  updateTime = function(s, dt)
    s.time = s.time + (dt * s.speed)
    if s.time >= 1.0 then 
      s:updateScore()
      changeState( states.over )
    end
  end,

  updateScore = function(s)
    local good = 0
    local duds = 0
    local coal = 0
    for i,v in ipairs(s.objects) do
      if s.goal:contains(v) then
        if v:kindOf(Coal) then 
          coal = coal + v.body:getMass()
        elseif v:kindOf(Present) then
          if v.broken then
            duds = duds + v.body:getMass()
          else
            good = good + v.body:getMass()
          end
        end
      end
    end
    s.score = {
      good = good,
      duds = duds,
      coal = coal,
    }
  end,

  cleanup = function(s)
    repeat
      local found = false
      local liveObjects = {}
      for i,v in pairs( s.objects ) do
        if v.dead then
          found = true
          if v.cleanup then v:cleanup() end
        else
          table.insert( liveObjects, v )
        end
      end
      s.objects = liveObjects
    until not found
  end,

  keypressed = function(s, k)
    --debugging yay
    if k == '1' then
      s.gun1:fire()
    elseif k == '2' then
      s.gun2:fire()
    end
  end,

  mousepressed = function(s, x, y, b)
    if b == 'r' then
      s.cursor:clickr( x, y )
    elseif b == 'l' then
      s.cursor:click( x, y )
    end
  end,

  mousereleased = function(s, x, y, b)
    if b == 'l' then
      s.cursor:disconnect()
    end
  end,

  addPresent = function(s, x, y)
    local r = Present.load( s.world, x, y )
    r:setRandomAngle()
    table.insert( s.objects, r )
    return r
  end,

  addCoal = function(s, x, y)
    local o = Coal.load( s.world, x, y )
    o:setRandomAngle()
    o.body:applyImpulse(math.random(-2,2), math.random(-2,2), x, y)
    table.insert( s.objects, o )
    return o
  end,

  add = function(s, o)
    table.insert( s.objects, o )
    return o
  end,

  addPoly = function(s, x, y)
    local r = PolyTest.load( s.world, x, y )
    table.insert( s.objects, r )
    return r
  end,

  addWall = function(s, x, y, w, h, a)
    local w = SimpleRect.load( s.world, x, y, w, h, s.wallColor, true )
    if a then w:setAngle(a) end
    table.insert( s.objects, w )
    return w
  end,

  collisionsAdd = {
    {
      function(a) return a == states.game.cursor end,
      function(b) return b ~= nil and not b.dead end,
      function(cursor, thing) cursor:touch(thing) end
    },
  },

  collisionAdd = function(a, b, c)
    for k,v in ipairs(states.game.collisionsAdd) do
      if try(a, b, c, v[1], v[2], v[3]) then return end
    end
  end,

  collisionsRemove = {
  },

  collisionRemove = function(a, b, c)
    for k,v in ipairs(states.game.collisionsRemove) do
      if try(a, b, c, v[1], v[2], v[3]) then return end
    end
  end,

}

mixin( states.game, states.base )

try = function(object1, object2, collisionPoint, predicate1, predicate2, interaction)
  if predicate1(object1) and predicate2(object2) then
    interaction(object1, object2, collisionPoint)
    return true
  elseif predicate1(object2) and predicate2(object1) then
    interaction(object2, object1, collisionPoint)
    return true
  end
  return false
end
