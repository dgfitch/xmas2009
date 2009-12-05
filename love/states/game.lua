-- a machine gun that shoots presents
states.game = {
  wallColor = {100,100,100},

  initialize = function(s)
    s.objects = {}

    s.world = love.physics.newWorld( -10, -10, WIDTH + 10, HEIGHT + 10, 0, 400 )
    s.world:setCallbacks( s.collision, nil, nil, nil )

    -- bounding
    s:addWall( WIDTH/2, -10, WIDTH + 10, 10 )
    s:addWall( -10, HEIGHT/2, 10, HEIGHT + 10 )
    s:addWall( WIDTH + 10, HEIGHT/2, 10, HEIGHT + 10 )
    s:addWall( WIDTH/2, HEIGHT + 10, WIDTH + 10, 10 )

    -- "level design" 
    s:addWall( WIDTH/6, HEIGHT*3/5, WIDTH/2.7, 10 * SIZE )
    s:addWall( WIDTH - WIDTH/6, HEIGHT*3/5, WIDTH/2.7, 10 * SIZE )
    s:addWall( WIDTH/3 + WIDTH/16, HEIGHT*2/3, WIDTH/7, 10 * SIZE, math.halfpi / 2 )
    s:addWall( WIDTH - (WIDTH/3 + WIDTH/16), HEIGHT*2/3, WIDTH/7, 10 * SIZE, math.halfpi / -2 )

    -- present firing guns
    local mx = 30 * SIZE
    local my = 40 * SIZE
    s.gun1 = s:add( MachineGun.load( s.world, mx, my, 0 ) )
    s.gun2 = s:add( MachineGun.load( s.world, WIDTH - mx, my, math.pi * -1 ) )
    
    s.cursor = Cursor.load( s.world )
    love.mouse.setVisible( false )

  end,

  draw = function(s)
    love.graphics.setColor( 255, 0, 0 )
    love.graphics.print("HAHA GAME LOL", 10, 20)
    for k,v in pairs(s.objects) do
      if v.draw then v:draw() end
    end
    s.cursor:draw()
    if s.cursor.connected then
      local x, y = s.cursor.joint:getTarget()
    end
  end,

  update = function(s, dt)
    s.cursor:update( dt )
    s.world:update( dt )
    for k,v in pairs(s.objects) do
      if v.update then v:update( dt ) end
    end
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
      s:addPresent( x, y )
    elseif b == 'l' then
      s.cursor:connect( x, y )
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

  collisions = {
    {
      function(a) return a == states.game.cursor end,
      function(b) return b ~= nil end,
      function(cursor, thing) cursor:touch(thing) end
    },
  },

  collision = function(a, b, c)
    for k,v in ipairs(states.game.collisions) do
      if tryCollide(a, b, c, v[1], v[2], v[3]) then return end
    end
  end

}

mixin( states.game, states.base )

tryCollide = function(object1, object2, collisionPoint, predicate1, predicate2, interaction)
  if predicate1(object1) and predicate2(object2) then
    interaction(object1, object2, collisionPoint)
    return true
  elseif predicate1(object2) and predicate2(object1) then
    interaction(object2, object1, collisionPoint)
    return true
  end
  return false
end
