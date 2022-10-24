local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

assert(
	type(futil.version) == "number" and futil.version >= os.time({year = 2022, month = 10, day = 24}),
	"please update futil"
)

inventory_ores = {
	author = "flux",
	license = "AGPL_v3",
	version = os.time({year = 2022, month = 10, day = 12}),
	fork = "flux",

	modname = modname,
	modpath = modpath,
	S = S,

	has = {
		unified_inventory = minetest.get_modpath("unified_inventory"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

inventory_ores.dofile("api")

if inventory_ores.has.unified_inventory then
	inventory_ores.dofile("unified_inventory")
end
