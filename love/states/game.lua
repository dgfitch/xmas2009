-- a machine gun that shoots presents
states.game = {
  wallColor = {100,100,100},

  initialize = function(s)
    s.objects = {}

    s.world = love.physics.newWorld( WIDTH, HEIGHT )
    s.world:setGravity( 0, 200 )

    s:addWall( WIDTH/2, HEIGHT - 100, WIDTH - 200, 20 )

    s.cursor = Cursor.load( s.world )
    love.mouse.setVisible(false)
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
      love.graphics.print("POOT", x, y)
    end
  end,

  update = function(s, dt)
    s.cursor:setPosition()
    s.world:update( dt )
  end,

  mousepressed = function(s, x, y, b)
    if b == 'r' then
      if math.random() < 0.2 then
        s:addPoly( x, y )
      else
        s:addRect( x, y )
      end
    elseif b == 'l' then
      s.cursor:connect( x, y )
    end
  end,

  mousereleased = function(s, x, y, b)
    if b == 'l' then
      s.cursor:disconnect()
    end
  end,


  addRect = function(s, x, y)
    local r = SimpleRect.load( s.world, x, y )
    r:setRandomAngle()
    table.insert( s.objects, r )
  end,

  addPoly = function(s, x, y)
    local r = PolyTest.load( s.world, x, y )
    table.insert( s.objects, r )
  end,

  addWall = function(s, x, y, w, h)
    local w = SimpleRect.load( s.world, x, y, w, h, s.wallColor, true )
    table.insert( s.objects, w )
  end,

}

mixin( states.game, states.base )

