unified_inventory.register_craft_type("inventory_ores:ore_spawns", {
	description = "Ore spawns",
	width = 1,
	height = 1,
	uses_crafting_grid = false,
})

local function register_ore(def)
	if type(def.wherein) == "table" then
		for _, wherein in ipairs(def.wherein) do
			local d2 = table.copy(def)
			d2.wherein = wherein
			register_ore(d2)
		end
		return
	end

	local wherein = ItemStack(def.wherein)
	if wherein:is_empty() then
		wherein = ItemStack("mapgen_stone")
	end

	local description = {futil.get_safe_short_description(wherein)}
	if def.ore_type then
		table.insert(description, ("ore_type = %q"):format(def.ore_type))
	end
	if def.clust_scarcity then
		table.insert(description, ("clust_scarcity = %i"):format(def.clust_scarcity))
	end
	if def.clust_num_ores then
		table.insert(description, ("clust_num_ores = %i"):format(def.clust_num_ores))
	end
	if def.clust_size then
		table.insert(description, ("clust_size = %i"):format(def.clust_size))
	end
	if def.y_min then
		table.insert(description, ("y_min = %i"):format(def.y_min))
	end
	if def.y_max then
		table.insert(description, ("y_max = %i"):format(def.y_max))
	end

	local meta = wherein:get_meta()
	meta:set_string("description", table.concat(description, "\n"))

	unified_inventory.register_craft({
		output = def.ore,
		type = "inventory_ores:ore_spawns",
		items = {wherein:to_string()},
		width = 1,
	})
end

local i = 0
for _, def in pairs(minetest.registered_ores) do
	register_ore(def)
	i = i + 1
end

inventory_ores.api.register_on_register_ore(register_ore)
