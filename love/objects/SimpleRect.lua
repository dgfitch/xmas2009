SimpleRect = {
  load = function( world, x, y )
    local self = {}
    mixin( self, SimpleRect )
    self.body = love.physics.newBody( world, x, y, 0.5, 10 )
    self.rect = love.physics.newRectangleShape( self.body, 50, 50 )
    return self
  end,

  draw = function( self )
    love.graphics.setColor( 0, 255, 0 )
    love.graphics.polygon( 'line', self.rect:getPoints() )
    love.graphics.setColor( 0, 0, 0 )
  end
}
