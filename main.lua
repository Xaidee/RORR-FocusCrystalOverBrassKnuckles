mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto(true)

local PATH = _ENV["!plugins_mod_folder_path"]

local DEBUG = true

local debug_print = function(toPrint)
	if DEBUG then print("Debug:    "..toPrint) end
end

local init = function()
	local brassKnuckles = Item.find("ssr", "brassKnuckles")
	if brassKnuckles ~= nil then
		debug_print("Replacing item sprite for ssr-brassKnuckles")
		gm.sprite_replace(gm.sprite_find("ssr-BrassKnuckles"), path.combine(PATH, "focusCrystal.png"), 1, false, false, 16, 16)
		debug_print("Replacing sprite ssr-EfBrassKnuckles")
		gm.sprite_replace(gm.sprite_find("ssr-EfBrassKnuckles"), path.combine(PATH, "efFocusCrystal"), 4, false, false, 28, 24)

		brassKnuckles:onPostDraw(function(actor, stack)
			local radius = 30 + stack * 30
			local x, y = math.floor(actor.ghost_x+0.5), math.floor(actor.ghost_y+0.5)
			-- New: Filled in circle
			gm.draw_set_alpha(0.1)
			gm.draw_set_colour(Color(0xff88b5))
			gm.draw_circle(x, y, radius+1, false)
			-- Overlay: Brass Knuckles existing circles
			gm.draw_set_alpha(0.4)
			gm.draw_set_colour(Color(0xec6f7c))
			gm.draw_circle(x, y, radius+1, true)
			gm.draw_circle(x, y, radius-1, true)
			gm.draw_set_alpha(1)
		end)
	else
		print("Error: Could not find item 'brassKnuckles' in namespace 'ssr'.")
	end
end
Initialize(init)
