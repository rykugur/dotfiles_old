-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")

--------------------------------------------------------- ERROR HANDLING
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
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
----------------------------------------------------- end ERROR HANDLING

--------------------------------------------------- VARIABLE DEFINITIONS
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/dusty/.config/awesome/themes/rollhax/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
terminale = "urxvtc -e tmux -2"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,                                     -- 1
    awful.layout.suit.tile,                                         -- 2
    awful.layout.suit.tile.left,                                    -- 3
    awful.layout.suit.tile.bottom,                                  -- 4
    awful.layout.suit.tile.top,                                     -- 5
    awful.layout.suit.fair,                                         -- 6
    awful.layout.suit.fair.horizontal,                              -- 7
    awful.layout.suit.max                                           -- 8
}

blue1   = "#6D87A6"
blue2   = "#476BD6"
blue3   = "#133AAC"
blue4   = "#062170"
orange1 = "#FF5300"
orange1 = "#FF5300"
fgcolor = "fgcolor='"
bgcolor = "bgcolor='"
apost   = "'"
span    = "<span"
spanend = ">"
spanoff = "</span>"

teststr = wibox.widget.textbox()
teststr:set_markup("<span fgcolor='"..blue3.."'>derp</span>")

rbracket = wibox.widget.textbox() 
rbracket:set_markup("]")
lbracket = wibox.widget.textbox()
lbracket:set_markup("[")
separator = wibox.widget.textbox()
separator:set_markup("|")
separator_colon = wibox.widget.textbox()
separator_colon:set_markup(":")
separator_colons = wibox.widget.textbox()
separator_colons:set_markup("::")
space = wibox.widget.textbox()
space:set_markup("")
space2 = wibox.widget.textbox()
space2:set_markup(" ")
arrowdown_empty = wibox.widget.textbox()
arrowdown_empty:set_markup("▿")
arrowup_empty = wibox.widget.textbox()
arrowup_empty:set_markup("▵")
arrowdown_fill = wibox.widget.textbox()
arrowdown_fill:set_markup("▾")
arrowup_fill = wibox.widget.textbox()
arrowup_fill:set_markup("▴")
lbracket_double = wibox.widget.textbox()
lbracket_double:set_markup("⟦")
rbracket_double = wibox.widget.textbox()
rbracket_double:set_markup("⟧")
larrow = wibox.widget.textbox()
larrow:set_markup("⟨")
rarrow = wibox.widget.textbox()
rarrow:set_markup("⟩")
larrow_double = wibox.widget.textbox()
larrow_double:set_markup("«")
rarrow_double = wibox.widget.textbox()
rarrow_double:set_markup("»")
downward_zigzag = wibox.widget.textbox()
downward_zigzag:set_markup("↯")
iron_cross = wibox.widget.textbox()
iron_cross:set_markup("✠")
tag_symbol = wibox.widget.textbox()
tag_symbol:set_markup("<span font='14'>❖</span>")
------------------------------------------------end VARIABLE DEFINITIONS

-------------------------------------------------------------- WALLPAPER
if beautiful.wallpaper then for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-----------------------------------------------------------end WALLPAPER

------------------------------------------------------------------- TAGS
-- Define a tag table which hold all screen tags.
tags = {
        names =  { "1:main",   "2:www",    "3:code",   "4:sonstig", "5:misc" },
        layout = { layouts[1], layouts[8], layouts[8], layouts[8],  layouts[8]  }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
----------------------------------------------------------------end TAGS

------------------------------------------------------------------- MENU
-- Create a laucher widget and a main menu

gamesmenu = {
    { "hon", "/home/dusty/HoN/hon.sh" }
}

mediamenu = {
    { "", "" }
}

officemenu = { 
    { "sublime text", "subl" }
}

placesmenu = {
  { "starwars (ssh)", "urxvt -e ssh dusty@starwars" },
  { "starwars (sftp)", "urxvt -e sftp dusty@starwars" }
}

mainmenu = awful.menu({
    items = {
        { "games", gamesmenu },
        { "media", mediamenu },
        { "office", officemenu },
        { "places", placesmenu },
        { "chrome", "chromium" }
    }
})


--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mainmenu })
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
----------------------------------------------------------------end MENU

------------------------------------------------------------------ WIBOX
-- Create a wibox for each screen and add it
mywibox = {}
bottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
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

-- Create a textclock widget
--mytextclock = awful.widget.textclock("%H:%M",60)

-- date widget
datewidget_text = wibox.widget.textbox()
vicious.register(datewidget_text, vicious.widgets.date, "<span color='#000000'> %R </span>", 61)
datewidget = wibox.widget.background()
datewidget:set_widget(datewidget_text)
datewidget:set_bg("#CCCCCC")

---- CPU widget
--cpuicon = wibox.widget.textbox()
--cpuicon:set_text("cpu")
--cpuicon:set_markup("<span color='#4E7CCC'>cpu</span>")
--cpuwidget = wibox.widget.textbox()
--vicious.register(cpuwidget, vicious.widgets.cpu, "$1% $2%", 3)
--
---- memory widget
--ramicon = wibox.widget.textbox()
--ramicon:set_text("ram")
--ramwidget = wibox.widget.textbox()
--vicious.register(ramwidget, vicious.widgets.mem, "$2", 1)
--
---- disk widget
--diskicon = wibox.widget.textbox()
--diskicon:set_text("disk")
--diskwidget = wibox.widget.textbox()
--vicious.register(diskwidget, vicious.widgets.fs, "${/home used_p}%", 1)
----vicious.register(diskwidget, vicious.widgets.fs, "${/home avail_p}%", 1)
--
---- battery widget
--baticon = wibox.widget.textbox()
--baticon:set_text("bat")
--batwidget = wibox.widget.textbox()
--vicious.register(batwidget, vicious.widgets.bat, "$2% $1", 1, "BAT0")
--
---- wifi widget
--wifiicon = wibox.widget.textbox()
--wifiicon:set_text("wifi")
--wifiicon_down = wibox.widget.textbox()
--wifiicon_down:set_text("▿")
--wifiicon_up = wibox.widget.textbox()
--wifiicon_up:set_text("▵")
--wifiwidget_down = wibox.widget.textbox()
--vicious.register(wifiwidget_down, vicious.widgets.net, "${wlp3s0 down_kb}", 1)
--wifiwidget_up = wibox.widget.textbox()
--vicious.register(wifiwidget_up, vicious.widgets.net, "${wlp3s0 up_kb}", 1)
--
---- volume widget
--volicon = wibox.widget.textbox()
--volicon:set_text("vol")
--volwidget = wibox.widget.textbox()
--vicious.register(volwidget, vicious.widgets.volume, "$1%", 1, "Master")

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    --bottomwibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(space2)
    left_layout:add(tag_symbol)
    left_layout:add(space2)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    --right_layout:add(cpuicon)
    --right_layout:add(space2)
    --right_layout:add(cpuwidget)

    --right_layout:add(space2)
    --right_layout:add(separator)
    --right_layout:add(space2)

    --right_layout:add(ramicon)
    --right_layout:add(space2)
    --right_layout:add(ramwidget)

    --right_layout:add(space2)
    --right_layout:add(separator)
    --right_layout:add(space2)

    --right_layout:add(diskicon)
    --right_layout:add(space2)
    --right_layout:add(diskwidget)

    --right_layout:add(space2)
    --right_layout:add(separator)
    --right_layout:add(space2)

    --right_layout:add(baticon)
    --right_layout:add(space2)
    --right_layout:add(batwidget)

    --right_layout:add(space2)
    --right_layout:add(separator)
    --right_layout:add(space2)

    --right_layout:add(wifiicon)
    --right_layout:add(space2)
    --right_layout:add(wifiicon_up)
    --right_layout:add(wifiwidget_up)
    --right_layout:add(space2)
    --right_layout:add(wifiicon_down)
    --right_layout:add(wifiwidget_down)

    --right_layout:add(space2)
    --right_layout:add(separator)
    --right_layout:add(space2)

    --right_layout:add(volicon)
    --right_layout:add(space2)
    --right_layout:add(volwidget)

    --right_layout:add(space2)
    --right_layout:add(separator)
    right_layout:add(datewidget)
    --right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
---------------------------------------------------------------end WIBOX

--------------------------------------------------------- MOUSE BINDINGS
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
------------------------------------------------------end MOUSE BINDINGS

----------------------------------------------------------- KEY BINDINGS
globalkeys = awful.util.table.join(
    awful.key({ }, "XF86AudioRaiseVolume", function ()
    awful.util.spawn("amixer set Master 9%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
    awful.util.spawn("amixer set Master 9%-") end),
    awful.key({ }, "XF86AudioMute", function ()
    awful.util.spawn("amixer sset Master toggle") end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "j",      awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, ";",      awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Control" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    --awful.key({ modkey,           }, "Tab",
    --    function ()
    --        awful.client.focus.history.previous()
    --        if client.focus then
    --            client.focus:raise()
    --        end
    --    end),

    -- Standard program
    awful.key({ modkey,            }, "Return", function () awful.util.spawn(terminale) end),
    awful.key({ modkey, "Control"  }, "Return", function () awful.util.spawn(terminal) end),
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
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
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
        end),
    awful.key({ modkey, "Shift"   }, ",",
        function (c)
           local curidx = awful.tag.getidx()
           if curidx == 1 then
               awful.client.movetotag(tags[client.focus.screen][7])
           else
               awful.client.movetotag(tags[client.focus.screen][curidx - 1])
           end
        end),
    awful.key({ modkey, "Shift"   }, ".",
        function (c)
           local curidx = awful.tag.getidx()
           if curidx == 7 then
               awful.client.movetotag(tags[client.focus.screen][1])
           else
               awful.client.movetotag(tags[client.focus.screen][curidx + 1])
           end
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
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
--------------------------------------------------------end KEY BINDINGS

------------------------------------------------------------------ RULES
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
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
---------------------------------------------------------------end RULES

---------------------------------------------------------------- SIGNALS
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
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

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-------------------------------------------------------------end SIGNALS
awful.util.spawn_with_shell("/home/dusty/bin/backslash")
awful.util.spawn_with_shell("run_once urxvtc -q -o -f")
awful.util.spawn_with_shell("run_once compton --config ~/.compton.conf -b")
