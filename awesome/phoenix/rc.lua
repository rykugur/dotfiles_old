------------------------------------------------
--              Awesome rc.lua                --    
--           by TheImmortalPhoenix            --
-- http://theimmortalphoenix.deviantart.com/  --
------------------------------------------------


-- {{{ Required Libraries

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")

-- Theme handling library
beautiful = require("beautiful")
require("revelation")

-- Notification library
require("naughty")
vicious = require("vicious")

-- }}}

-- {{{ Autostart

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
 end

  -- run_once("compton -cCG -fF -o 0.38 -O 20 -I 20 -t 0.02 -l 0.02 -r 3.2 -D2")
  run_once("xcompmgr -fF -l -O -D1")
  -- run_once("devilspie")
  -- run_once("urxvtd -q -f -o")
  -- run_once("sudo netcfg wireless")
  run_once("sudo ./.scripts/connect")
  run_once("sudo ./.scripts/killkde")
  -- run_once("sudo ./.scripts/starttorsleep")
  -- run_once("parcellite")
  -- run_once("conky -c ~/.conky/process")
  -- run_once("sudo powerdown")
  run_once("dropbox start")

-- }}}

-- {{{ Error Handling

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

-- }}}

-- {{{ Variable Definitions

-- Themes define colours, icons, and wallpapers
beautiful.init("/home/luca/.config/awesome/themes/blue/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
gui_editor = "geany"
browser = "firefox"
fileman = "spacefm /home/luca/"
cli_fileman = terminal .. " -title Ranger -e ranger "
music = terminal .. " -title Music -e ncmpcpp "
chat = terminal .. " -title Chat -e weechat-curses "
tasks = terminal .. " -e sudo htop "

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,             -- 1
    awful.layout.suit.tile,                 -- 2
    awful.layout.suit.tile.left,            -- 3
    awful.layout.suit.tile.bottom,          -- 4
    awful.layout.suit.tile.top,             -- 5
    awful.layout.suit.fair,                 -- 6
    -- awful.layout.suit.fair.horizontal,      -- 7
    -- awful.layout.suit.spiral,               -- 8
    -- awful.layout.suit.spiral.dwindle,       -- 9
    -- awful.layout.suit.max,                  -- 10
    --awful.layout.suit.max.fullscreen,     -- 11
    --awful.layout.suit.magnifier           -- 12
}
-- }}}

-- {{{ Tags

tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ "¹", "´", "²", "©", "ê", "Ç" }, s,
    -- tags[s] = awful.tag({ "term", "web", "files", "chat", "media", "work" }, s,
  		       { layouts[6], layouts[6], layouts[6],
 			  layouts[6], layouts[6], layouts[6]
 		       })
    
end

-- }}}

-- {{{ Wibox

-- Create a textclock widget

clockicon = widget({ type = "imagebox"})
clockicon.image = image(beautiful.widget_clock)

mytextclock = awful.widget.textclock({ align = "right" })

-- Calendar widget to attach to the textclock
require('calendar2')
calendar2.addCalendarToWidget(mytextclock)

-- System

sysicon = widget({ type = "imagebox"})
sysicon.image = image(beautiful.widget_sys)

syswidget = widget({ type = "textbox" })
vicious.register( syswidget, vicious.widgets.os, "$2")
-- vicious.register( syswidget, vicious.widgets.os, "<span color='" .. beautiful.fg_white.. "'>$2</span>") -- example to use custom colors

-- Uptime icon
uptimeicon = widget({ type = "imagebox" })
uptimeicon.image = image(beautiful.widget_uptime)

-- Uptime
uptimewidget = widget({ type = "textbox" })
-- vicious.register( uptimewidget, vicious.widgets.uptime, "<span color='" .. beautiful.fg_green.. "'>uptime</span> $2.$3'")
vicious.register( uptimewidget, vicious.widgets.uptime, "$2.$3'")


-- Temp Icon
tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)

-- Temp Widget
tempwidget = widget({ type = "textbox" })
-- vicious.register(tempwidget, vicious.widgets.thermal, "<span color='" .. beautiful.fg_green.. "'>temp</span> $1°C", 9, "thermal_zone0")
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 9, "thermal_zone0")
tempicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvt -e sudo powertop", false) end)
    -- awful.button({ }, 3, function () awful.util.spawn("sudo irqbalance", false) end)
))

local function disptemp()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

	f = io.popen("sensors && sudo hddtemp /dev/sda && sudo aticonfig --od-gettemperature")
	infos = f:read("*all")
	f:close()

	showtempinfo = naughty.notify( {
		text	= infos,
		timeout	= 0,
        position = "bottom_right",
        margin = 10,
        height = 180,
        width = 350,
        border_color = '#404040',
        border_width = 1,
        opacity = 0.94,
		screen	= capi.mouse.screen })
end

tempwidget:add_signal('mouse::enter', function () disptemp(path) end)
tempwidget:add_signal('mouse::leave', function () naughty.destroy(showtempinfo) end)


-- Gmail Widget
mygmail = widget({ type = "textbox" })
vicious.register(mygmail, vicious.widgets.gmail,
                function (widget, args)
                    return args["{count}"]
                 end, 2) 
                 --the '120' here means check every 2 minutes.


mygmailimg = widget({ type = "imagebox" })
mygmailimg.image = image(beautiful.widget_gmail)
mygmailimg:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvt -title Mail -e mutt", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvt -title Feed -e newsbeuter", false) end)
))

-- Hard Drives

-- Disk Icon
diskicon = widget({ type = "imagebox" })
diskicon.image = image(beautiful.widget_disk)

-- Diskette Icon
disketteicon = widget({ type = "imagebox" })
disketteicon.image = image(beautiful.widget_diskette)

fswidgetp = widget({ type = "textbox" })
vicious.register(fswidgetp, vicious.widgets.fs, "${/ used_p}%", 1)
-- fswidget = widget({ type = "textbox" })
-- vicious.register(fswidget, vicious.widgets.fs, "(${/ used_gb}GB)", 180)

datawidgetp = widget({ type = "textbox" })
vicious.register(datawidgetp, vicious.widgets.fs, "${/media/Data used_p}%", 1)
-- datawidget = widget({ type = "textbox" })
-- vicious.register(datawidget, vicious.widgets.fs, "(${/media/Data used_gb}GB)", 180)

-- winwidgetp = widget({ type = "textbox" })
-- vicious.register(winwidgetp, vicious.widgets.fs, "<span color='" .. beautiful.fg_blu.. "'>w</span> ${/media/Winzoz used_p}%", 180)
-- winwidget = widget({ type = "textbox" })
-- vicious.register(winwidget, vicious.widgets.fs, "(${/media/Winzoz used_gb}GB)", 180)

-- riswidgetp = widget({ type = "textbox" })
-- vicious.register(riswidgetp, vicious.widgets.fs, "<span color='" .. beautiful.fg_blu.. "'>r</span> ${/media/Riserva used_p}%", 180)
-- riswidget = widget({ type = "textbox" })
-- vicious.register(riswidget, vicious.widgets.fs, "(${/media/Riserva used_gb}GB)", 180)

local function dispdisk()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

	f = io.popen("dfc -d")
	infos = f:read("*all")
	f:close()

	showdiskinfo = naughty.notify( {
        text	= infos,
		timeout	= 0,
        position = "bottom_right",
        margin = 10,
        height = 143,
        width = 535,
        border_color = '#404040',
        border_width = 1,
        opacity = 0.94,
		screen	= capi.mouse.screen })
end

fswidgetp:add_signal('mouse::enter', function () dispdisk(path) end)
fswidgetp:add_signal('mouse::leave', function () naughty.destroy(showdiskinfo) end)

-- CPU Icon
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)

-- Cpu usage
cpuwidget = widget({ type = "textbox" })
-- vicious.register( cpuwidget, vicious.widgets.cpu, "<span color='" .. beautiful.fg_green.. "'>cpu</span> $1%", 3)
vicious.register( cpuwidget, vicious.widgets.cpu, "$1%", 3)
cpuicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvt -geometry 80x18 -e saidar -c", false) end)
))


-- Bat Icon
baticon = widget ({type = "imagebox" })
baticon.image = image(beautiful.widget_batt)

-- Battery usage
require("precious.battery")

-- batmenu = awful.menu({items = {
			     -- { "Ondemand" , function () awful.util.spawn("sudo cpufreq-set -r -g ondemand", false) end },
			     -- { "Performance" , function () awful.util.spawn("sudo cpufreq-set -r -g performance", false) end },
			     -- { "Powersave" , function () awful.util.spawn("sudo cpufreq-set -r -g powersave", false) end }
			  -- }
		       -- })

-- bat = widget({type = "textbox" })
-- bat.text = "<span color=\"#828a8c\">bat</span>"

-- batwidget = widget({ type = "textbox" })
-- vicious.register( batwidget, vicious.widgets.bat, "$1 $2%", 1, "BAT0" )

-- bat:buttons(awful.util.table.join(
					 -- awful.button({ }, 1, function () batmenu:toggle() end )
			   -- ))

local function dispinfos()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

	f = io.popen("acpi -abi")
	infos = f:read("*all")
	f:close()

	showbatinfo = naughty.notify( {
		text	= infos,
		position = "bottom_right",
        margin = 10,
        height = 55,
        width = 453,
		timeout	= 0,
        border_color = '#404040',
        border_width = 1,
        opacity = 0.94,
        screen	= capi.mouse.screen })
end

batinfo:add_signal('mouse::enter', function () dispinfos(path) end)
batinfo:add_signal('mouse::leave', function () clearinfo(showbatinfos) end)

-- Vol Icon
volicon = widget ({type = "imagebox" })
volicon.image = image(beautiful.widget_vol)

-- Sound volume
volumewidget = widget ({ type = "textbox" })
-- vicious.register( volumewidget, vicious.widgets.volume, "<span color='" .. beautiful.fg_green.. "'>vol</span> $1%", 1, "Master" )
vicious.register( volumewidget, vicious.widgets.volume, "$1%", 1, "Master" )
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvt -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))

-- Net Widget

netdownicon = widget ({ type = "imagebox" })
netdownicon.image = image(beautiful.widget_netdown)
netdownicon.align = "middle"

netdowninfo = widget({ type = "textbox" })
-- vicious.register(netdowninfo, vicious.widgets.net, "<span color='" .. beautiful.fg_green.. "'>down</span> ${wlan0 down_kb}", 1)
vicious.register(netdowninfo, vicious.widgets.net, "${wlan0 down_kb}", 1)

netupicon = widget ({ type = "imagebox" })
netupicon.image = image(beautiful.widget_netup)
netupicon.align = "middle"

netupinfo = widget({ type = "textbox" })
-- vicious.register(netupinfo, vicious.widgets.net, "<span color='" .. beautiful.fg_green.. "'>up</span> ${wlan0 up_kb}", 1)
vicious.register(netupinfo, vicious.widgets.net, "${wlan0 up_kb}", 1)
-- netmenu = awful.menu({items = {
			     -- { "Restart Wifi" , function () awful.util.spawn("sh ./.scripts/restartwifi", false) end },
			     -- { "Set Normal DNS" , function () awful.util.spawn("sudo ./.scripts/setdns", false) end },
			     -- { "Set Tor DNS" , function () awful.util.spawn("sudo ./.scripts/setdnstor", false) end },
			     -- { "Start Tor" , function () awful.util.spawn("urxvt -e sudo sh ./.scripts/starttor", false) end },
			     -- { "Stop Tor" , function () awful.util.spawn("urxvt -e sudo sh ./.scripts/stoptor", false) end },
			     -- { "Switch Identity" , function () awful.util.spawn("urxvt -e sudo sh ./.scripts/restarttor", false) end }
			  -- }
		       -- })

-- netupinfo:buttons(awful.util.table.join(
					 -- awful.button({ }, 1, function () netmenu:toggle() end )
				   -- ))
local function dispip()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

	f = io.popen("sh /home/luca/.scripts/ip")
	infos = f:read("*all")
	f:close()

	showip = naughty.notify( {
		text	= infos,
		timeout	= 0,
        position = "bottom_right",
        margin = 10,
        height = 30,
        width = 100,
        border_color = '#404040',
        border_width = 1,
        opacity = 0.94,
		screen	= capi.mouse.screen })
end

netdowninfo:add_signal('mouse::enter', function () dispip(path) end)
netdowninfo:add_signal('mouse::leave', function () naughty.destroy(showip) end)

-- TOR Widget

tor = widget({type = "textbox" })
tor.text = "<span color=\"#ecedee\">TOR</span>"

toricon = widget ({type = "imagebox" })
toricon.image = image(beautiful.widget_tor)

local function disptor()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

    f = io.popen("sh /home/luca/.scripts/daemon-status-1 | grep tor")
	infos = f:read("*all")
	f:close()
 	showtorinfo = naughty.notify( {
		text	= infos,
        position = "bottom_right",
        margin = 10,
        height = 32,
        width = 135,
		timeout	= 0,
        border_color = '#404040',
        border_width = 1,
        opacity = 0.94,
		screen	= capi.mouse.screen })
end


toricon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("sudo sh /home/luca/.scripts/starttor", false) end),
    awful.button({ }, 3, function () awful.util.spawn("sudo sh /home/luca/.scripts/stoptor", false) end)
))

tor:add_signal('mouse::enter', function () disptor(path) end)
tor:add_signal('mouse::leave', function () naughty.destroy(showtorinfo) end)


-- MEM icon
memicon = widget ({type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

-- Memory usage
memwidget = widget({ type = "textbox" })
-- vicious.register(memwidget, vicious.widgets.mem, "<span color='" .. beautiful.fg_green.. "'>ram</span> $1%", 1)
vicious.register(memwidget, vicious.widgets.mem, "$2 MB", 1)
memicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("urxvt -e sudo htop", false) end)
))


-- Spacers

rbracket = widget({type = "textbox" })
rbracket.text = "<span color=\"#6b8ba3\">]</span>"
lbracket = widget({type = "textbox" })
lbracket.text = "<span color=\"#6b8ba3\">[</span>"
line = widget({type = "textbox" })
line.text = "<span color=\"#404040\">│</span>"
funny = widget({type = "textbox" })
funny.text = "<span color=\"#6b8ba3\">┌∩┐(◣_◢)┌∩┐ </span>"
-- Space
space = widget({ type = "textbox" })
space.text = " "


-- MPD Widget

useMpd = true

if useMpd then

  music_play = awful.widget.launcher({
    image = beautiful.widget_play,
    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_pause = awful.widget.launcher({
    image = beautiful.widget_pause,
    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })
  music_pause.visible = false

  music_stop = awful.widget.launcher({
    image = beautiful.widget_stop,
    command = "ncmpcpp stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_prev = awful.widget.launcher({
    image = beautiful.widget_prev,
    command = "ncmpcpp prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_next = awful.widget.launcher({
    image = beautiful.widget_next,
    command = "ncmpcpp next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })



mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
function(widget, args)

local string = "<span color='" .. beautiful.fg_white .. "'>" .. args["{Title}"] .. "</span> <span color='" .. beautiful.fg_green .. "'>● </span> <span color='" .. beautiful.fg_yellow .. "'>" .. args["{Artist}"] .. "</span> <span color='" .. beautiful.fg_green .. "'>●  </span><span color='" .. beautiful.fg_magenta .. "'>" .. args["{Album}"] .. "</span>"

-- play
if (args["{state}"] == "Play") then
-- lbracket.visible = true
-- rbracket.visible = true
-- music_play.visible = true
-- music_pause.visible = true
-- music_next.visible = true
-- music_prev.visible = true
-- music_stop.visible = true
mpdwidget.visible = true
return string

-- pause
elseif (args["{state}"] == "Pause") then
-- lbracket.visible = true
-- rbracket.visible = true
-- music_play.visible = true
-- music_pause.visible = false
-- music_next.visible = true
-- music_prev.visible = true
-- music_stop.visible = true
mpdwidget.visible = true
return "<span color='" .. beautiful.fg_green.."'>mpd</span> <span color='" .. beautiful.fg_cyan.."'>paused</span><span color='" .. beautiful.fg_green.."'></span>"

-- stop
elseif (args["{state}"] == "Stop") then
-- lbracket.visible = true
-- rbracket.visible = true
-- music_play.visible = true
-- music_pause.visible = false
-- music_next.visible = true
-- music_prev.visible = true
-- music_stop.visible = true
mpdwidget.visible = true
return "<span color='" .. beautiful.fg_green.."'>mpd</span> <span color='" .. beautiful.fg_cyan.."'>stopped</span><span color='" .. beautiful.fg_green.."'></span>"

-- not running
else
-- lbracket.visible = false
-- rbracket.visible = false
-- music_play.visible = false
-- music_pause.visible = false
-- music_next.visible = false
-- music_prev.visible = false
-- music_stop.visible = false
mpdwidget.visible = true
return "<span color='" .. beautiful.fg_green.."'>mpd</span> <span color='" .. beautiful.fg_cyan.."'>off</span><span color='" .. beautiful.fg_green.."'></span>"
end

end, 1)

end

-- Close Button
close = widget ({type = "imagebox" })
close.image = image(beautiful.widget_close)
close:buttons(awful.util.table.join(
    awful.button({ }, 1, function () client.focus:kill() end)
        ))

-- Maximize Button
max = widget ({type = "imagebox" })
max.image = image(beautiful.widget_max)
max:buttons(awful.util.table.join(
    awful.button({ }, 1, function () client.focus.maximized_horizontal = not client.focus.maximized_horizontal client.focus.maximized_vertical = not client.focus.maximized_vertical end)
        ))

-- Minimize Button
minimize = widget ({type = "imagebox" })
minimize.image = image(beautiful.widget_min)
minimize:buttons(awful.util.table.join(
    awful.button({ }, 1, function () client.focus.minimized = not client.focus.minimized end)
        ))

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mystatusbar = {}
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
-- mytasklist = {}
-- mytasklist.buttons = awful.util.table.join(
                     -- awful.button({ }, 1, function (c)
                                              -- if c == client.focus then
                                                  -- c.minimized = true
                                              -- else
                                                  -- if not c:isvisible() then
                                                      -- awful.tag.viewonly(c:tags()[1])
                                                  -- end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  -- client.focus = c
                                                  -- c:raise()
                                              -- end
                                          -- end),
                     -- awful.button({ }, 2, function ()
                                              -- if instance then
                                                  -- instance:hide()
                                                  -- instance = nil
                                              -- else
                                                  -- instance = awful.menu.clients({ width=250 })
                                              -- end
                                          -- end),
                     -- awful.button({ }, 3, function ()
                                              -- awful.client.focus.byidx(1)
                                              -- if client.focus then client.focus:kill() end
                                          -- end),
                     -- awful.button({ }, 4, function ()
                                              -- awful.client.focus.byidx(1)
                                              -- if client.focus then client.focus:raise() end
                                          -- end),
                     -- awful.button({ }, 5, function ()
                                              -- awful.client.focus.byidx(-1)
                                              -- if client.focus then client.focus:raise() end
                                          -- end))

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
    -- mytasklist[s] = awful.widget.tasklist(function(c)
    --                                           return awful.widget.tasklist.label.currenttags(c, s)
    --                                       end, mytasklist.buttons)

    -- Create the upper wibox
    -- mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 15, fg = beautiful.fg_normal, bg = beautiful.bg_normal, border_color = beautiful.border_focus, border_width = beautiful.border_width })
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, opacity = 0.94, height = 15 })

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            -- mytaglist[s], space, space, mylayoutbox[s], space, space, lbracket, music_prev, music_stop, music_play, music_next, rbracket, space, space, mpdwidget, space, space, space, mypromptbox[s],
            mytaglist[s], space, space, mpdwidget, space, space, space, mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and mysystray or nil,
        -- space, mytextclock, clockicon, space, space, syswidget, sysicon, space, space, datawidgetp, diskicon, space, space, fswidgetp, disketteicon, space, uptimewidget, uptimeicon, space, space, tempwidget, tempicon, space, space, volumewidget, volicon, space, space, cpuwidget, cpuicon, space, space, memwidget, memicon, space, space, batinfo, space, space, tor, toricon, space, space, mygmail, mygmailimg, space, space, netupinfo, netupicon, space, netdowninfo, netdownicon,
        close, max, minimize, space, space, mytextclock, clockicon, space, space, syswidget, sysicon, space, space, datawidgetp, diskicon, space, space, fswidgetp, disketteicon, space, uptimewidget, uptimeicon, space, space, tempwidget, tempicon, space, space, volumewidget, volicon, space, space, cpuwidget, cpuicon, space, space, memwidget, memicon, space, space, batinfo, space, space, mygmail, mygmailimg, space, space, netupinfo, netupicon, space, netdowninfo, netdownicon,
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Space for conky
    -- mybottomwibox = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 1, height = 16 })
     
     -- mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 15, fg = beautiful.fg_normal, bg = beautiful.bg_normal, border_color = beautiful.border_focus, border_width = beautiful.border_width })
     -- mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 15 })

     -- mybottomwibox[s].widgets = {
     -- {
        -- space,
        -- mpdicon, space, music_prev, music_stop, music_pause, music_play, music_next, space, line, space, space, mpdwidget, space, space, line,
        -- space, mpdwidget, space, space, line,
        -- space, space,
        -- mytasklist,
        -- layout = awful.widget.layout.horizontal.leftright
     -- },
        -- mylayoutbox[s],
        -- s == 1 and mysystray or nil,
        -- line,
        -- layout = awful.widget.layout.horizontal.rightleft
      -- }
   end

-- }}}

-- {{{ Mouse Bindings

root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- }}}

-- {{{ Key Bindings

globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Control" }, "Escape", awful.tag.history.restore),

    awful.key({modkey}, "d", revelation),

    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),
    -- awful.key({ modkey, altkey }, "b", function ()
    -- mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    -- mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible end),
    -- awful.key({ altkey }, "b", function ()
    -- mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible end),
    
    -- Layout manipulation
    awful.key({ modkey, altkey }, "Left", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, altkey }, "Right", function () awful.client.swap.byidx( -1)    end),
    
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, altkey    }, "Return", function () awful.util.spawn( "sudo urxvt" ) end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    
    -- Volume control
    awful.key({ altkey }, "plus", function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.key({ altkey }, "minus", function () awful.util.spawn("amixer -q sset Master 1dB-", false) end),
    
    -- Music control
    
    -- awful.key({ altkey,           }, "Up",      function () awful.util.spawn( "sh /home/luca/.scripts/play", false ) end),
    -- awful.key({ altkey,           }, "Down",    function () awful.util.spawn( "sh /home/luca/.scripts/stop", false ) end ),
    
    awful.key({ altkey,           }, "Up",      function () awful.util.spawn( "mpc toggle", false ) end),
    awful.key({ altkey,           }, "Down",    function () awful.util.spawn( "mpc stop", false ) end ),
    awful.key({ altkey,           }, "Left",    function () awful.util.spawn( "mpc prev", false ) end ),
    awful.key({ altkey,           }, "Right",   function () awful.util.spawn( "mpc next", false ) end ),
    
    awful.key({ "Control",        }, "Up",      function () awful.util.spawn( "sudo systemctl start mpd", false ) end),
    awful.key({ "Control",        }, "Down",    function () awful.util.spawn( "sudo systemctl stop mpd", false ) end),

    -- Control Brightness
    awful.key({ "Control" }, "9",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness0", false ) end),
    awful.key({ "Control" }, "1",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness1", false ) end),
    awful.key({ "Control" }, "2",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness2", false ) end),
    awful.key({ "Control" }, "3",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness3", false ) end),
    awful.key({ "Control" }, "4",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness4", false ) end),
    awful.key({ "Control" }, "5",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness5", false ) end),
    awful.key({ "Control" }, "6",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness6", false ) end),
    awful.key({ "Control" }, "7",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness7", false ) end),
    awful.key({ "Control" }, "8",      function () awful.util.spawn( "sudo ./.scripts/Brightness/brightness8", false ) end),

    -- Applications
    awful.key({ modkey,        }, "i",      function () awful.util.spawn(browser) end),
    awful.key({ modkey,        }, "j",      function () awful.util.spawn( "sudo sh /home/luca/.scripts/starttor", false ) end),
    awful.key({ modkey, altkey }, "j",      function () awful.util.spawn( "sudo sh /home/luca/.scripts/stoptor", false ) end),
    awful.key({ modkey,        }, "w",      function () awful.util.spawn( "midori", false ) end),
    awful.key({ modkey,        }, "e",      function () awful.util.spawn( "urxvt -title Elinks -e elinks", false ) end),
    awful.key({ modkey,        }, "n",      function () awful.util.spawn(music) end),
    awful.key({ modkey, altkey }, "c",      function () awful.util.spawn(chat) end),
    awful.key({ modkey,        }, "h",      function () awful.util.spawn(tasks) end),
    awful.key({ modkey,        }, "t",      function () awful.util.spawn( "urxvt -title Mail -e mutt", false ) end),
    awful.key({ modkey,        }, "m",      function () awful.util.spawn( "motion", false ) end),
    awful.key({ modkey, altkey }, "m",      function () awful.util.spawn( "sh ./.scripts/stop-motion", false ) end),
    awful.key({ modkey,        }, "y",      function () awful.util.spawn( "urxvt -title Youtube -e youtube-viewer -m -C", false ) end),
    awful.key({ modkey,        }, "p",      function () awful.util.spawn( "spacefm", false ) end),
    awful.key({ modkey, altkey }, "p",      function () awful.util.spawn( "sudo spacefm /root", false ) end),
    awful.key({ modkey,        }, "r",      function () awful.util.spawn( "sh ./.scripts/restartwifi", false ) end),
    awful.key({ modkey,        }, "u",      function () awful.util.spawn( "mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -title Webcam -fps 25 -vf screenshot", false ) end),
    awful.key({ modkey, altkey }, "u",      function () awful.util.spawn( "wxcam", false ) end),
    awful.key({ modkey,        }, "g",      function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey, altkey }, "e",      function () awful.util.spawn(editor_cmd) end),
    awful.key({ modkey,        }, "f",      function () awful.util.spawn(cli_fileman) end),
    awful.key({ modkey, altkey }, "f",      function () awful.util.spawn( "urxvt -title Ranger -e sudo ranger" ) end),
    awful.key({ modkey,        }, "k",      function () awful.util.spawn( "nowvideo", false ) end),
    awful.key({ modkey,        }, "s",      function () awful.util.spawn( "nitrogen", false ) end),

    -- Take A Screenshot
    awful.key({ }, "Print", function () awful.util.spawn( "scrot -c", false ) end),

    -- Shutdown
    -- awful.key({ }, "XF86PowerOff",          function () awful.util.spawn( "sudo sh /home/luca/.scripts/poweroff", false ) end),
    -- awful.key({ }, "Help",                  function () awful.util.spawn( "sudo sh /home/luca/.scripts/reboot", false ) end),
    awful.key({ modkey,        }, "l",      function () awful.util.spawn( "xset dpms force off", false ) end),
    awful.key({ modkey,        }, "x",      function () awful.util.spawn( "xkill", false ) end),
    awful.key({ modkey,        }, "q",      function () awful.util.spawn( "sh /home/luca/.scripts/switchtokde", false ) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ }, "XF86HomePage", awesome.quit),

    -- Prompt
    awful.key({ altkey }, "r",      function () mypromptbox[mouse.screen]:run() end),
    awful.key({ altkey }, "m",      function () awful.util.spawn( " dmenu_run -nb '#070707' -nf '#ecedee' -sf '#6b8ba3' -sb '#070707' -fn '-misc-termsyn-medium-r-normal--*-*-*-*-*-*-*-*' -f -h 15 -p 'Run application'", false ) end),
    awful.key({ altkey }, "n",      function () awful.util.spawn( " sudo dmenu_run -nb '#070707' -nf '#ecedee' -sf '#6b8ba3' -sb '#070707' -fn '-misc-termsyn-medium-r-normal--*-*-*-*-*-*-*-*' -f -h 15 -p 'Run application (root)'", false ) end),
    awful.key({ altkey }, "c",      function () awful.util.spawn( " dnetcfg -nb '#070707' -nf '#ecedee' -sf '#6b8ba3' -sb '#070707' -fn '-misc-termsyn-medium-r-normal--*-*-*-*-*-*-*-*' -f -h 15", false ) end),
    awful.key({ altkey }, "q",      function () awful.util.spawn( " dpm -nb '#070707' -nf '#ecedee' -sf '#6b8ba3' -sb '#070707' -fn '-misc-termsyn-medium-r-normal--*-*-*-*-*-*-*-*' -f -h 15", false ) end),
    
    awful.key({ altkey }, "w", function ()
        awful.prompt.run({ prompt = "search "}, mypromptbox[mouse.screen].widget,
	        function (command)
                awful.util.spawn("firefox 'https://duckduckgo.com/?q=!"..command.."'", false)
		        -- if tags[mouse.screen][2] then awful.tag.viewonly(tags[mouse.screen][2]) end
	        end)
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ altkey            }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ "Control"         }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ "Control"         }, ",",      function (c) c.minimized = not c.minimized    end),
    awful.key({ "Control"         }, "m",
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

-- }}}

-- {{{ Rules

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     maximized_vertical = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons,
	                 size_hints_honor = false
                    }
   },
    { rule = { class = "Vlc" },
      properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { class = "Vlc", name = "Playlist" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true } },

    { rule = { class = "Gsharkdown.py" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true } },

    { rule = { class = "Gimp" },
      properties = { tag = tags[1][6] } },

    { rule = { class = "Xfburn" },
      properties = { tag = tags[1][6] } },

    { rule = { instance = "plugin-container" },
      properties = { floating = true } },

    { rule = { class = "Amule" },
      properties = { tag = tags[1][2] } },

    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "Firefox" , instance = "DTA" },
      properties = { tag = tags[1][2], floating = true } },

    { rule = { class = "Firefox" , instance = "Toplevel" },
      properties = { tag = tags[1][2], floating = true } },

    { rule = { class = "Firefox" , instance = "Browser" },
      properties = { tag = tags[1][2], floating = true } },

    { rule = { class = "Firefox" , instance = "Download" },
      properties = { tag = tags[1][2], floating = true } },

    { rule = { class = "Firefox" , name = "Install user style" },
      properties = { tag = tags[1][2], floating = true } },

    { rule = { class = "Midori" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "URxvt" },
      properties = { tag = tags[1][1], switchtotag = true, opacity = 0.94 }, callback = awful.client.setslave },

    { rule = { class = "URxvt", name = "saidar" },
      properties = { tag = tags[1][6], switchtotag = true, floating = true } },

    { rule = { class = "URxvt", name = "Music" },
      properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { class = "URxvt", name = "Mail" },
      properties = { tag = tags[1][4], switchtotag = true } },

    { rule = { class = "URxvt", name = "Chat" },
      properties = { tag = tags[1][4], switchtotag = true } },

    { rule = { class = "URxvt", name = "Feed" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "URxvt", name = "Ranger" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "URxvt", name = "ranger:~" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "URxvt", name = "Youtube" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "URxvt", name = "Elinks" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "URxvt", name = "http://duckduckgo.com/lite DuckDuckGo - ELinks" },
      properties = { tag = tags[1][2], switchtotag = true } },

    { rule = { class = "Display" },
      properties = { tag = tags[1][1], floating = true } },

    { rule = { class = "Gajim" },
      properties = { tag = tags[1][4], floating = true, switchtotag = true } },
 
     { rule = { class = "Hotot" },
      properties = { tag = tags[1][4] } },

    { rule = { class = "Skype" },
      properties = { tag = tags[1][4], floating = true, switchtotag = true } },

    { rule = { class = "Viewnior" },
      properties = { tag = tags[1][5], switchtotag = true } },
    
    { rule = { class = "feh" },
      properties = { tag = tags[1][3], floating = true, switchtotag = true } },

    { rule = { class = "Qalculate-gtk" },
      properties = { tag = tags[1][6], switchtotag = true } },
    
    { rule = { class = "Convertall.py" },
      properties = { tag = tags[1][6], switchtotag = true } },
    
    { rule = { class = "Spacefm" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "Gucharmap" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "Nitrogen" },
      properties = { tag = tags[1][3], switchtotag = true, floating = true } },

    { rule = { class = "Geany" },
      properties = { tag = tags[1][3], switchtotag = true } },
    
    { rule = { class = "Zathura" },
      properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { class = "llpp" },
      properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { instance = "VCLSalFrame", class = "libreoffice-writer" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "libreoffice-impress" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "libreoffice-math" },
      properties = { tag = tags[1][3], floating = true, switchtotag = true } },

    { rule = { class = "libreoffice-calc" },
      properties = { tag = tags[1][3], switchtotag = true } },

    -- { rule = { class = "Abiword" },
      -- properties = { tag = tags[1][3], switchtotag = true } },
    
    -- { rule = { class = "Gnumeric" },
      -- properties = { tag = tags[1][3], switchtotag = true } },

    -- { rule = { class = "GWepCrackGui" },
      -- properties = { tag = tags[1][2], floating = true } },



    { rule = { class = "Torrent-search" },
      properties = { tag = tags[1][2], switchtotag = true } },
    
    -- { rule = { class = "Xfburn" },
      -- properties = { tag = tags[1][5], switchtotag = true } },
    
    { rule = { class = "mplayer2" },
      properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { class = "mplayer2", name = "Webcam" },
      properties = { tag = tags[1][5], switchtotag = true, floating = true } },
    
    { rule = { class = "Wxcam" },
      properties = { tag = tags[1][5], switchtotag = true, floating = true } },

    { rule = { class = "Acidrip" },
      properties = { tag = tags[1][5] } },

    { rule = { class = "Unetbootin.elf" },
      properties = { tag = tags[1][6], switchtotag = true } },
    
    -- { rule = { class = "Wxcam" },
      -- properties = { tag = tags[1][5], switchtotag = true } },

    { rule = { class = "Bleachbit" },
      properties = { tag = tags[1][3], switchtotag = true } },

    { rule = { class = "Amdcccle" },
      properties = { tag = tags[1][6] } },
    
    -- { rule = { class = "Palimpsest" },
      -- properties = { tag = tags[1][3], switchtotag = true } },

    -- { rule = { class = "Hardinfo" },
      -- properties = { tag = tags[1][3] } },
    
    { rule = { class = "Gpartedbin" },
      properties = { tag = tags[1][3], switchtotag = true } },
}

-- }}}

-- {{{ Signals

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

-- menu.add_signal("focus", function(c)
--                              c.border_color = beautiful.border_focus
--                              c.opacity = 1
--                           end)
-- menu.add_signal("unfocus", function(c)
--                                c.border_color = beautiful.border_normal
--                                c.opacity = 1
--                             end)

-- }}}

-- {{{ Functions to help launch run commands in a terminal using ":" keyword 

function check_for_terminal (command)
   if command:sub(1,1) == ":" then
      command = terminal .. ' -e "' .. command:sub(2) .. '"'
   end
   awful.util.spawn(command)
end
   
function clean_for_completion (command, cur_pos, ncomp, shell)
   local term = false
   if command:sub(1,1) == ":" then
      term = true
      command = command:sub(2)
      cur_pos = cur_pos - 1
   end
   command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
   if term == true then
      command = ':' .. command
      cur_pos = cur_pos + 1
   end
   return command, cur_pos
end
-- }}}

-- {{{ Disable startup-notification globally

local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

-- }}}
