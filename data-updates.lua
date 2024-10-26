local light_scale = settings.startup["electric_pole_light_size_factor"].value
local light_size_limit = settings.startup["electric_pole_light_max_size"].value

local hidden_lamps = {}

for _, pole in pairs(data.raw["electric-pole"]) do
    local hidden_lamp = table.deepcopy(data.raw["lamp"]["small-lamp"])
    --flib.copy_prototype(data.raw["lamp"]["small-lamp"], pole.name.."-lamp", true)
    hidden_lamp.name = pole.name.."-lamp";
    log(pole.name.."-lamp")
    hidden_lamp.icon = pole.icon
    hidden_lamp.localised_name = {"entity-name.hidden-lamp", {"entity-name." .. pole.name}}
    hidden_lamp.minable = nil
    hidden_lamp.next_upgrade = nil
    hidden_lamp.flags = {"not-blueprintable", "not-deconstructable", "placeable-off-grid", "not-on-map"}
    hidden_lamp.selectable_in_game = false

    hidden_lamp.collision_box = {{0, 0}, {0, 0}}
    hidden_lamp.selection_box = {{0, 0}, {0, 0}}
    hidden_lamp.picture_off = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }
    hidden_lamp.picture_on = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }

    -- Lighting
    local light_size = 40 -- Default
    if light_scale > 0 then
        light_size = math.floor(math.sqrt(pole.maximum_wire_distance) * (40 / math.sqrt(7.5)) * light_scale + 0.5) 
    end
    if light_size > light_size_limit then 
        light_size = light_size_limit 
    end
    
    hidden_lamp.light = {intensity = 0.9, size = light_size, color = {1, 1, 0.75}}
    hidden_lamp.energy_usage_per_tick = light_size * 10 .. "W"
    table.insert(hidden_lamps, hidden_lamp)
end

data:extend(hidden_lamps)
