DrawablePoly = {
  draw = function( self )
    love.graphics.setColor( unpack( self.color ) )
    love.graphics.polygon( 'fill', self.poly:getPoints() )
    if self.colorLine then
      love.graphics.setLineWidth( 1 )
      love.graphics.setColor( unpack( self.colorLine ) )
      love.graphics.polygon( 'line', self.poly:getPoints() )
    end
    love.graphics.setColor( 0, 0, 0 )
  end
}
