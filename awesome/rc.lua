--Testing rc settings using xephyr (xorg-server-xephyr)
--Xephyr :1 -ac -br -noreset -screen 1152x720 &
--DISPLAY=:1.0 awesome -c /etc/xdg/awesome/rc.lua.new
--then you can just reload awesome within that window after
--you make changes to the rc.lua.new file

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Load vicious widgets
vicious = require("vicious")


---------------------------------ERROR HANDLING
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-----------------------------END ERROR HANDLING

--------------------------------------VARIABLES
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/dusty/.config/awesome/themes/rollhax/theme.lua")

rbracket = widget({type = "textbox" })
rbracket.text = "]"
lbracket = widget({type = "textbox" })
lbracket.text = "["
separator = widget({ type = "textbox" })
separator.text = "|"
space = widget({ type = "textbox" })
space.text = ""
space2 = widget({ type = "textbox" })
space2.text = " "

-- colors
lighterblue = "#FFFFFF"
lightblue   = "#00FFFF"
medblue     = "#0000FF"
darkblue    = "#0000A0"

gradient1 = lighterblue
gradient2 = lightblue
gradient3 = medblue
gradient4 = darkblue

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
--editor = os.getenv("EDITOR") or "nano"
editor = "subl"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
----------------------------------END VARIABLES

----------------------------------------LAYOUTS
layouts =
{
    awful.layout.suit.floating,            -- 1
    awful.layout.suit.tile,                -- 2
    awful.layout.suit.tile.left,           -- 3
    awful.layout.suit.tile.bottom,         -- 4
    awful.layout.suit.tile.top,            -- 5
    awful.layout.suit.fair,                -- 6
    awful.layout.suit.fair.horizontal,     -- 7
    awful.layout.suit.max                  -- 8
}
------------------------------------END LAYOUTS

-------------------------------------------TAGS
-- Define a tag table which hold all screen tags.
tags = {
        names =  { "1:main",   "2:www",    "3:games",  "4:htpc",     "5:rdp",    "6:toaster", "7:cafe" },
        layout = { layouts[8], layouts[8], layouts[1], layouts[8],   layouts[8], layouts[2],  layouts[2] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
---------------------------------------END TAGS

-------------------------------------------MENU
-- Create a laucher widget and a main menu
myawesomemenu = {
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}

mygamesmenu = {
    { "hon", "/home/dusty/bin/hon" },
    --{ "ftl", "/home/dusty/bin/ftl" },
    { "minecraft", "java -jar /home/dusty/Games/minecraft/minecraft.jar"},
    { "shadowbane", "/home/dusty/bin/shadowbane" },
    --{ "steam", "/home/dusty/bin/steam" },
    { "ur-quan masters", "uqm" }
}

myofficemenu = {
  { "sublime text", "subl" }
}

myplacesmenu = {
  { "starwars (ssh)", "urxvt -e ssh dusty@starwars" },
  { "starwars (sftp)", "urxvt -e sftp dusty@starwars" }
}

myprogsmenu = {
  { "htop", "urxvt -e htop"}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
                                    { "games", mygamesmenu },
                                    { "office", myofficemenu },
                                    { "places", myplacesmenu },
                                    { "progs", myprogsmenu },
                                    { "chrome", "google-chrome" },
                                  }
                        })
                        
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
---------------------------------------END MENU

----------------------------------------WIDGETS
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- CPU Icon
--cpuicon = widget({ type = "imagebox" })
--cpuicon.image = image(beautiful.widget_icon_cpu)
cpuicon = widget({ type = "textbox" })
cpuicon.text = "cpu"
-- CPU Widget
cpubar = awful.widget.progressbar()
cpubar:set_width(50)
cpubar:set_height(6)
cpubar:set_vertical(false)
cpubar:set_background_color("#434343")
cpubar:set_gradient_colors({ gradient1, gradient2, gradient3, gradient4, beautiful.bar })
vicious.register(cpubar, vicious.widgets.cpu, "$1", 7)
awful.widget.layout.margins[cpubar.widget] = { top = 6 }

-- MEM icon
--memicon = widget ({type = "imagebox" })
--memicon.image = image(beautiful.widget_icon_ram)
memicon = widget({ type = "textbox" })
memicon.text = "ram"
-- Initialize MEMBar widget
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
membar:set_vertical(false)
membar:set_background_color("#434343")
membar:set_border_color(nil)
membar:set_gradient_colors({ gradient1, gradient2, gradient3, gradient4, beautiful.bar })
awful.widget.layout.margins[membar.widget] = { top = 6 }
vicious.register(membar, vicious.widgets.mem, "$1", 13)

-- -- BATT Icon
-- --baticon = widget({ type = "imagebox" })
-- --baticon.image = image(beautiful.widget_icon_bat)
-- baticon = widget({type = "textbox" })
-- baticon.text = "bat"
-- -- Initialize BATT widget
-- batbar = awful.widget.progressbar()
-- batbar:set_width(50)
-- batbar:set_height(6)
-- batbar:set_vertical(false)
-- batbar:set_background_color("#434343")
-- batbar:set_border_color(nil)
-- batbar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
-- batbar:set_gradient_colors({ gradient1, gradient2, gradient3, gradient4, beautiful.bar })
-- awful.widget.layout.margins[batbar.widget] = { top = 6 }
-- vicious.register(batbar, vicious.widgets.bat, "$2", 120, "BAT1")

-- -- WIFI icon
-- wifiicon = widget({ type = "textbox" })
-- wifiicon.text = "wifi"
-- -- WIWI bar widget
-- wifibar = awful.widget.progressbar()
-- wifibar:set_width(50)
-- wifibar:set_height(6)
-- wifibar:set_vertical(false)
-- wifibar:set_background_color("#434343")
-- wifibar:set_border_color(nil)
-- -- wifibar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
-- wifibar:set_gradient_colors({ gradient1, gradient2, gradient3, gradient4, beautiful.bar })
-- awful.widget.layout.margins[wifibar.widget] = { top = 6 }
-- vicious.register(wifibar, vicious.widgets.wifi, "~ ${link}%", 5, "wlan0")

-- Vol Icon
--volicon = widget({ type = "imagebox" })
--volicon.image = image(beautiful.widget_icon_vol)
volicon = widget({ type = "textbox" })
volicon.text = "vol"
-- Vol bar Widget
volbar = awful.widget.progressbar()
volbar:set_width(50)
volbar:set_height(6)
volbar:set_vertical(false)
volbar:set_background_color("#434343")
volbar:set_border_color(nil)
volbar:set_gradient_colors({ gradient1, gradient2, gradient3, gradient4, beautiful.bar })
awful.widget.layout.margins[volbar.widget] = { top = 6 }
vicious.register(volbar, vicious.widgets.volume,  "$1",  1, "Master")
------------------------------------END WIDGETS

------------------------------------------WIBOX
-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    --mywibox[s] = awful.wibox({ position = "top", screen = s })
    mywibox[s] = awful.wibox({ position = "top", height = "18", screen = s })

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mylayoutbox[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        --mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })


    mybottomwibox[s].widgets = {
        {
            lbracket, space2, cpuicon, space2, cpubar, space2, rbracket,
            space2,
            lbracket, space2, memicon, space2, membar, space2, rbracket,
            space2,
            -- lbracket, space2, baticon, space2, batbar, space2, rbracket,
            -- space2,
            -- lbracket, space2, wifiicon, space2, wifibar, space2, rbracket,
            -- space2,
            lbracket, space2, volicon, space2, volbar, space2, rbracket,
            layout = awful.widget.layout.horizontal.leftright
        },
        layout = awful.widget.layout.horizontal.rightleft
    }
end
--------------------------------------END WIBOX

-----------------------------------KEY BINDINGS
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = awful.util.table.join(
    awful.key({ }, "XF86AudioRaiseVolume", function ()
    awful.util.spawn("amixer set Master 9%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
    awful.util.spawn("amixer set Master 9%-") end),
    awful.key({ }, "XF86AudioMute", function ()
    awful.util.spawn("amixer sset Master toggle") end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-------------------------------END KEY BINDINGS

------------------------------------------RULES
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
--------------------------------------END RULES

----------------------------------------SIGNALS
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
------------------------------------END SIGNALS

os.execute("sh /home/dusty/bin/backslash")
