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

  getPosition = function( self )
    local x, y = self.body:getPosition()
    if (not x) or x <= 20 or x >= WIDTH - 100 then
      x = WIDTH / 2
    end
    if (not y) or y <= 20 or y >= WIDTH - 100 then
      y = WIDTH / 2
    end
    return x, y
  end,

  drawPoly = function( self, poly, lineWidth ) 
    love.graphics.polygon( 'fill', poly:getPoints() )
    if self.colorLine then
      love.graphics.setLineWidth( (lineWidth or 1) * SIZE )
      love.graphics.setColor( unpack( self.colorLine ) )
      love.graphics.polygon( 'line', poly:getPoints() )
    end
    if self.tutorial then
      love.graphics.setLineWidth( 4 * SIZE )
      love.graphics.setColor( 255, 0, 0, 0 )
      love.graphics.polygon( 'line', poly:getPoints() )
    end
  end,

  loadPolys = function( self, polys )
    self.polys = {}
    for i,poly in ipairs(polys) do
      local p = love.physics.newPolygonShape( self.body, unpack(poly) )
      p:setData(self)
      if self.sensor then p:setSensor(true) end
      if self.restitution then p:setRestitution(self.restitution) end
      table.insert(self.polys, p)
    end
  end
}
