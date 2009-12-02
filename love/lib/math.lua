function math.clamp( num, min, max )
	if num < min then
		return min
	end
	if num > max then
		return max
	end
	return num
end

