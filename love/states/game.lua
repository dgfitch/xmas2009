states.game = {
  wallColor = {100,100,100},
  wallSize = SIZE * 10,
  title = "Unknown",
  levelCount = 0,

  levels = {
    function(s)
      s.title = "Tutorial"
      local h = HEIGHT * 2 / 3
      s:addWalls({ { WIDTH/2 - s.wallSize, h, WIDTH/2 + s.wallSize, h, WIDTH/2 + s.wallSize, HEIGHT, WIDTH/2 - s.wallSize, HEIGHT } })

      s.goal = Goal.load( s.world,
        {
          { WIDTH/2, 0, WIDTH, 0, WIDTH, HEIGHT, WIDTH/2, HEIGHT },
        } )

      local m = 30 * SIZE
      s:add( MachineGun.load( s.world, m, m, math.pi / 4, 4.0 ) )
    end,
    
    function(s)
      s.title = "Into the Sleigh"
      local h = HEIGHT * 3/5
      local w1 = WIDTH/3
      local w2 = WIDTH * 2/3
      s:addWalls({ 
        { 0, h, w1, h, w1, h + s.wallSize, 0, h + s.wallSize },
        { w2, h, WIDTH, h, WIDTH, h + s.wallSize, w2, h + s.wallSize },
      })

      s.goal = Goal.load( s.world,
        {
          { 0, HEIGHT*3/5, WIDTH, HEIGHT*3/5, WIDTH, HEIGHT, 0, HEIGHT },
        } )

      local mx = 30 * SIZE
      local my = 30 * SIZE
      s:add( MachineGun.load( s.world, mx, my, 0 ) )
      s:add( MachineGun.load( s.world, WIDTH - mx, my, math.pi * -1 ) )
    end,
    
    function(s)
      s.title = "The Squish Factory"

      s.goal = Goal.load( s.world,
        {
          { 0, HEIGHT*1/5, WIDTH, HEIGHT*1/5, WIDTH, HEIGHT, 0, HEIGHT },
        } )

      local mx = 30 * SIZE
      local my = HEIGHT - 30 * SIZE
      s:add( MachineGun.load( s.world, mx, my, math.halfpi * -1, 1.6, 10  ) )
      s:add( MachineGun.load( s.world, WIDTH - mx, my, math.halfpi * -1, 1.6, 10 ) )
    end,
    
    function(s)
      s.title = "Balancing Act"

      local h = HEIGHT * 4/5
      local w1 = WIDTH / 5
      local w2 = WIDTH * 4/5
      s:addWalls({ 
        { w1, h, w2, h, w2, h + s.wallSize, w1, h + s.wallSize },
      })

      s.goal = Goal.load( s.world,
        {
          { w1, 0, w2, 0, w2, h, w1, h },
        } )

      s:add( MachineGun.load( s.world, WIDTH / 4, 30 * SIZE, math.halfpi * -1, nil, 1 ) )
      s:add( MachineGun.load( s.world, WIDTH * 3/4, 30 * SIZE, math.halfpi * -1, nil, 1 ) )
    end,

    function(s)
      s.title = "Rapid Fire"

      local h = HEIGHT * 2/3
      local w1 = WIDTH / 3
      local w2 = WIDTH * 2/3
      s:addWalls({ 
        { w1 - s.wallSize, h, w1 + s.wallSize, h, w1 + s.wallSize, HEIGHT, w1 - s.wallSize, HEIGHT },
        { w2 - s.wallSize, h, w2 + s.wallSize, h, w2 + s.wallSize, HEIGHT, w2 - s.wallSize, HEIGHT } 
      })

      s.goal = Goal.load( s.world,
        {
          { 0, HEIGHT*3/5, WIDTH, HEIGHT*3/5, WIDTH, HEIGHT, 0, HEIGHT },
        } )

      -- present firing guns
      local mx = 30 * SIZE
      local my = 30 * SIZE
      s:add( MachineGun.load( s.world, mx, my, 0, 1.5, 120 ) )
      s:add( MachineGun.load( s.world, WIDTH - mx, my, math.pi * -1, 1.51, 120 ) )
    end,
  },

  nextLevel = function(s)
    local n = s.level + 1
    s.levelCount = s.levelCount + 1
    if n > #s.levels then
      n = 2
    end
    s:initialize(n)
  end,

  initialize = function(s, level)
    s.level = level or 1
    s.time = 0.0
    s.speed = 0.02
    s.gravity = 400
    s.produced = 0

    s.objects = {}

    s.world = love.physics.newWorld( -10, -10, WIDTH + 10, HEIGHT + 10, 0, s.gravity )
    s.world:setCallbacks( s.collisionAdd, nil, nil, nil )

    -- bounding
    s:addWalls({
      { -10, -10, WIDTH + 10, -10, WIDTH + 10, 0, -10, 0 },
      { -10, -10, 0, -10, 0, HEIGHT + 10, -10, HEIGHT + 10 },
      { WIDTH, -10, WIDTH + 10, -10, WIDTH + 10, HEIGHT + 10, WIDTH, HEIGHT + 10 },
      { -10, HEIGHT, WIDTH + 10, HEIGHT, WIDTH + 10, HEIGHT + 10, -10, HEIGHT + 10 },
    }, true)

    -- init level
    s.levels[s.level](s)
    
    s.cursor = Cursor.load( s.world )
    love.mouse.setVisible( false )

    s.background = Background.load( s )
  end,

  draw = function(s)
    s.background:draw()
    s.goal:draw()
    for k,v in pairs(s.objects) do
      if v.draw then v:draw() end
    end
    s.background:drawOverlay()
    love.graphics.setColor( 255, 0, 0, 255 )
    love.graphics.setFont(24)
    p(s.title, 30)
    T:draw()
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
    T:update(dt)
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
      produced = s.produced,
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
      s:nextLevel()
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
    if not r.broken then s.produced = s.produced + r.body:getMass() end
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

  addWalls = function(s, polys, bounding)
    local w = Wall.load( s.world, polys, bounding )
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

mixin( states.game, State )

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
