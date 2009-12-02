DrawablePoly = {
  draw = function( self )
    love.graphics.setColor( unpack( self.color ) )
    love.graphics.polygon( 'fill', self.poly:getPoints() )
    love.graphics.setColor( 0, 0, 0 )
  end
}
