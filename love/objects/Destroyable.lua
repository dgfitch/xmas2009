Destroyable = {
  cleanup = function( self )
    if self.poly then
      self.poly:setData(nil)
      self.poly:destroy()
      self.poly = nil
    end
    self.body:destroy()
    self.body = nil
  end
}

