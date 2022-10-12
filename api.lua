-- luacheck: globals minetest

local api = {}

api.registered_on_register_ores = {}

function api.register_on_register_ore(func)
	table.insert(api.registered_on_register_ores, func)
end

local old_register_ore = minetest.register_ore

function minetest.register_ore(def)
	inventory_ores.log("action", "mt.reg(%s)", dump(def))
	local rv = old_register_ore(def)
	for _, func in ipairs(api.registered_on_register_ores) do
		func(table.copy(def))
	end
	return rv
end

api.registered_on_clear_registered_ores = {}

function api.register_on_clear_registered_ores(func)
	table.insert(api.registered_on_clear_registered_ores, func)
end

local old_clear_registered_ores = minetest.clear_registered_ores

function minetest.clear_registered_ores()
	for _, func in ipairs(api.registered_on_clear_registered_ores) do
		func()
	end

	return old_clear_registered_ores()
end

inventory_ores.api = api
