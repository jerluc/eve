function love.conf(t)
    -- Package settings
    t.identity = "eve"
    t.title = "eve"
    t.version = "0.10.1"

    -- Window/display settings
    t.window.width = 800
    t.window.height = 600
    t.window.fullscreen = true
    t.window.fullscreentype = "desktop"
    t.window.highdpi = false

    -- LOVE module exclusions
    t.modules.joystick = false
end
