local object = {}
object.__index = object

function object:new()
	local list = {}

	setmetatable(list, object)

	function list:append(value)
	    list[#list + 1] = value
	end

	function list:remove(index)
		table.remove(list, index)
	end

	function list:size()
	    return #list
	end

	function list:foreach(func)
	    for _, v in ipairs(list) do
	        func(v)
	    end
	end

	function list:filter(func)
	    local new = object:new()

	    for _, v in ipairs(list) do
	        if func(v) then
	            new:append(v)
	        end
	    end

	    return new
	end

	function list:map(func)
	    local new = object:new()

	    for i, v in ipairs(list) do
	        new[i] = func(v)
	    end

	    return new
	end

	function list:copy()
	    local new = object:new()

	    for _, v in ipairs(list) do
            new:append(v)
	    end

	    return new
	end

	function list:sort(func)
	    local cp = list:copy()

	    table.sort(cp, func)

	    return cp
	end

	function list:slice(left, right)
		local new = object:new()

		if (right > list:size()) then
			right = list:size()
		else
			right = right or list:size()
		end

		if left > 0 and right <= list:size() then
			for i = left, right do
				new:append(list[i])
			end
		end

		return new
	end

	function list:front()
		return list[1]
	end

	function list:back()
		return list[#list]
	end

	function list:get(index)
		return list[index]
	end

	function list:clean()
		list = {}
	end

	return list
end

return object
