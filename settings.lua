data:extend(
    {
        {
            type = "double-setting",
            name = "electric_pole_light_size_factor",
            setting_type = "startup",
            default_value = 1, -- default size = 40 equal to a a small lamp on medium pole
            minimum_value = 0, -- 0 = don't scale, use small light everywhere
            maximum_value = 100,
            order = "1000"
          },
          {
            type = "int-setting",
            name = "electric_pole_light_max_size",
            setting_type = "startup",
            default_value = 75, -- game engine max light radius = 75
            minimum_value = 1,
            order = "1001"
          },
          {
            type = "double-setting",
            name = "electric_pole_light_brightness",
            setting_type = "startup",
            default_value = 0.9,
            minimum_value = 0,
            maximum_value = 1,
            order = "1002"
          },
    }
)
