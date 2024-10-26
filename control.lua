-- control.lua

local tick_interval = 10  -- Update interval
storage.pole_lamps = storage.pole_lamps or {}

local function create_or_update_lamp(electric_pole)
    local position = electric_pole.position

    local light_size = 40 -- Default

    if not storage.pole_lamps[electric_pole.unit_number] then
        local lamp = electric_pole.surface.create_entity{
            name = electric_pole.name.."-lamp",
            position = position,
            force = electric_pole.force,
            create_build_effect_smoke = false
        }
        
        if lamp then
            storage.pole_lamps[electric_pole.unit_number] = lamp
            lamp.destructible = false
            lamp.minable = false
        else
            game.print("[EPL] Error creating lamp for pole "..tostring(pole.name).." on surface "..tostring(surface.name) )
        end
    end
end

local function pole_pemoved(event)
    local entity = event.entity
    if entity and entity.valid and entity.type == "electric-pole" then
        if storage.pole_lamps[entity.unit_number] then
            storage.pole_lamps[entity.unit_number].destroy()
            storage.pole_lamps[entity.unit_number] = nil
        end
    end
end

-- Update cycle
script.on_event(defines.events.on_tick, function(event)
    if event.tick % tick_interval == 0 then
        for _, surface in pairs(game.surfaces) do
            for _, electric_pole in pairs(surface.find_entities_filtered{ type = "electric-pole" }) do
                create_or_update_lamp(electric_pole)
            end
        end
    end
end)

script.on_configuration_changed(function(event)
    local electric_pole_prototypes = prototypes.get_entity_filtered({{filter="type", type="electric-pole"}})

    for _, surface in pairs(game.surfaces) do
        for _, pole_prototype in pairs(electric_pole_prototypes) do
            for _, lamp in pairs(surface.find_entities_filtered{ name = pole_prototype.name .. "-lamp" }) do
                lamp.destroy()
            end
        end
    end
    storage.pole_lamps = {}
end)

-- register removal events
script.on_event(defines.events.on_pre_player_mined_item, pole_pemoved)
script.on_event(defines.events.on_entity_died, pole_pemoved)
script.on_event(defines.events.on_robot_pre_mined, pole_pemoved)
script.on_event(defines.events.script_raised_destroy, pole_pemoved)
