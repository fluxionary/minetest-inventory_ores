std = "lua51+luajit+minetest+inventory_ores"
unused_args = false
max_line_length = 120

stds.minetest = {
	read_globals = {
		"DIR_DELIM",
		"minetest",
		"core",
		"dump",
		"vector",
		"nodeupdate",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		"table",
		"math",
		"string",
	}
}

stds.inventory_ores = {
	globals = {
		"inventory_ores",
	},
	read_globals = {
		"futil",
		"unified_inventory",
	},
}
