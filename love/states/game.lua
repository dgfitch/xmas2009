states.game = {
  initialize = function(s)
    s.objects = {}

    s.world = love.physics.newWorld( WIDTH, HEIGHT )
    s.world:setGravity( 0, 200 )
  end,

  draw = function(s)
    love.graphics.setColor( 255, 0, 0 )
    love.graphics.print("HAHA GAME LOL", 400, 300)
    for k,v in pairs(s.objects) do
      if v.draw then v:draw() end
    end
  end,

  update = function(s, dt)
    s.world:update( dt )
    if love.mouse.isDown( 'l' ) then
      -- uh
      s:addRect( love.mouse.getX(), love.mouse.getY() )
    end
  end,

  addRect = function(s, x, y)
    local r = SimpleRect.load( s.world, x, y )
    table.insert( s.objects, r )
  end,
}

mixin( states.game, states.base )

