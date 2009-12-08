isA = function(object, class)
  if object == nil then return false end
  if object == class or object.class == class then return true end
  return isA(object.super,class)
end

kindOf = function(object, attrib)
  if object == nil then return false end
  if object.isA(attrib) then return true end
  if object.mixins then
    for k,v in ipairs(object.mixins) do
      if v == attrib then return true end
    end
  end
  if object.attributes == nil then return false end
  return object.attributes[attrib] ~= nil
end

printall = function(object, name)
  print(name .. ": " .. tostring(object))
  for k,v in pairs(object) do
    print(name .. ": " .. tostring(k) .. ": " .. tostring(v))
  end
end

mixin = function(destination, source)
  destination.mixins = destination.mixins or {}
  table.insert(destination.mixins, source)
  destination.isA = function (self, thing) return isA(self, thing) end
  destination.kindOf = function (self, thing) return kindOf(self, thing) end
  for k,v in pairs(source) do
    if k == "attributes" then
      if destination.attributes == nil then destination.attributes = {} end
      for ak, av in pairs(v) do
        if not destination.attributes[ak] then destination.attributes[ak] = av end
      end
    else
      if not destination[k] then destination[k] = v end
    end
  end
end

