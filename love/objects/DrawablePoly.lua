DrawablePoly = {
  draw = function( self, lineWidth )
    if states.game.cursor.connected == self then
      lineWidth = 4
    elseif states.game.cursor.touching == self then
      lineWidth = 2
    end

    love.graphics.setColor( unpack( self.color ) )
    if self.poly then
      self:drawPoly(self.poly, lineWidth)
    elseif self.polys then
      for i,poly in ipairs(self.polys) do
        self:drawPoly(poly, lineWidth)
      end
    end
    love.graphics.setColor( 0, 0, 0 )
  end,

  drawPoly = function( self, poly, lineWidth ) 
    love.graphics.polygon( 'fill', poly:getPoints() )
    if self.colorLine then
      love.graphics.setLineWidth( (lineWidth or 1) * SIZE )
      love.graphics.setColor( unpack( self.colorLine ) )
      love.graphics.polygon( 'line', poly:getPoints() )
    end
  end
}
