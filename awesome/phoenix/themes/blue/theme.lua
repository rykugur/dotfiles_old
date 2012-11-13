------------------------------------------------
--          Blue Awesome theme.lua            --    
--          by TheImmortalPhoenix             --
-- http://theimmortalphoenix.deviantart.com/  --
------------------------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main

theme                   = {}
theme.confdir           = awful.util.getdir("config") .. "/themes/blue"
-- theme.wallpaper_cmd     = { "awsetbg /media/Data/Pictures/Wallpapers/calm.jpg" }

-- }}}

-- {{{ Font

theme.font              = "Termsyn.Icons 8"

-- }}}

-- {{{ Colors

theme.fg_normal         = "#ecedee"
--theme.fg_focus        = "#3ca4d8"
theme.fg_focus          = "#6b8ba3"
theme.fg_urgent         = "#927d9e"
theme.bg_normal         = "#000000"
theme.bg_focus          = "#000000"
theme.bg_urgent         = "#000000"
theme.taglist_bg_focus  = "#000000"

-- }}}

-- {{{ Borders

theme.border_width      = "1"
theme.border_normal     = "#000000"
theme.border_focus      = "#404040"
-- theme.border_marked     = "#3ca4d8"
theme.border_marked     = "#6b8ba3"

-- }}}

-- {{{ Titlebars

-- theme.titlebar_bg_focus  = "#3F3F3F"
-- theme.titlebar_bg_normal = "#3F3F3F"

-- theme.titlebar_close_button_focus               =   theme.confdir .. "/titlebar/close_focus.png"
-- theme.titlebar_close_button_normal              =   theme.confdir .. "/titlebar/close_normal.png"

-- theme.titlebar_ontop_button_focus_active        =   theme.confdir .. "/titlebar/ontop_focus_active.png"
-- theme.titlebar_ontop_button_normal_active       =   theme.confdir .. "/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_inactive      =   theme.confdir .. "/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_inactive     =   theme.confdir .. "/titlebar/ontop_normal_inactive.png"

-- theme.titlebar_sticky_button_focus_active       =   theme.confdir .. "/titlebar/sticky_focus_active.png"
-- theme.titlebar_sticky_button_normal_active      =   theme.confdir .. "/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_inactive     =   theme.confdir .. "/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_inactive    =   theme.confdir .. "/titlebar/sticky_normal_inactive.png"

-- theme.titlebar_floating_button_focus_active     =   theme.confdir .. "/titlebar/floating_focus_active.png"
-- theme.titlebar_floating_button_normal_active    =   theme.confdir .. "/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_inactive   =   theme.confdir .. "/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_inactive  =   theme.confdir .. "/titlebar/floating_normal_inactive.png"

-- theme.titlebar_maximized_button_focus_active    =   theme.confdir .. "/titlebar/maximized_focus_active.png"
-- theme.titlebar_maximized_button_normal_active   =   theme.confdir .. "/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_inactive  =   theme.confdir .. "/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_inactive =   theme.confdir .. "/titlebar/maximized_normal_inactive.png"

-- }}}

-- {{{ Widgets

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- theme.fg_widget        = "#AECF96"
-- theme.fg_center_widget = "#88A175"
-- theme.fg_end_widget    = "#FF5656"
-- theme.bg_widget        = "#494B4F"
-- theme.border_widget    = "#3F3F3F"

-- Colors

theme.fg_black			= "#404040"
theme.fg_red	        = "#7791e0"
theme.fg_green			= "#828a8c"
theme.fg_yellow		 	= "#6b8ba3"
theme.fg_blue			= "#3955c4"
theme.fg_magenta		= "#927d9e"
theme.fg_cyan			= "#6e98b8"
theme.fg_white		 	= "#ecedee"
theme.fg_blu		 	= "#8ebdde"

-- Icons

-- theme.widget_sep     = theme.confdir .. "/widgets/seperator.png"
theme.widget_uptime     = theme.confdir .. "/widgets/ac_01.png"
theme.widget_cpu        = theme.confdir .. "/widgets/cpu.png"
theme.widget_temp       = theme.confdir .. "/widgets/temp.png"
theme.widget_mem        = theme.confdir .. "/widgets/mem.png"
theme.widget_disk       = theme.confdir .. "/widgets/usb.png"
theme.widget_diskette   = theme.confdir .. "/widgets/usb_02.png"
-- theme.widget_myip    = theme.confdir .. "/widgets/yellow/net_down_01.png"
-- theme.widget_spkr    = theme.confdir .. "/widgets/spkr.png"
-- theme.widget_head    = theme.confdir .. "/widgets/phones.png"
theme.widget_netdown    = theme.confdir .. "/widgets/net_down_02.png"
theme.widget_netup      = theme.confdir .. "/widgets/net_up_02.png"
theme.widget_gmail      = theme.confdir .. "/widgets/mail.png"
theme.widget_sys        = theme.confdir .. "/widgets/dish.png"
-- theme.widget_newmail = theme.confdir .. "/widgets/newmail.png"
theme.widget_pac        = theme.confdir .. "/widgets/pacman.png"
-- theme.widget_newpackage = theme.confdir .. "/widgets/newpackage.png"
theme.widget_batt       = theme.confdir .. "/widgets/bat_full_01.png"
-- theme.widget_batt_low = theme.confdir .. "/widgets/bat_low.png"
-- theme.widget_batt_empty = theme.confdir .. "/widgets/bat_empty.png"
theme.widget_clock      = theme.confdir .. "/widgets/clock.png"
theme.widget_mpd        = theme.confdir .. "/widgets/note.png"
theme.widget_play       = theme.confdir .. "/widgets/play.png"
theme.widget_pause      = theme.confdir .. "/widgets/pause.png"
theme.widget_stop       = theme.confdir .. "/widgets/stop.png"
theme.widget_prev       = theme.confdir .. "/widgets/prev.png"
theme.widget_next       = theme.confdir .. "/widgets/next.png"
theme.widget_vol        = theme.confdir .. "/widgets/spkr_01.png"

theme.widget_close      = theme.confdir .. "/close.png"
theme.widget_max        = theme.confdir .. "/maximize.png"
theme.widget_min        = theme.confdir .. "/minimize.png"

-- Apps

theme.widget_tor   = theme.confdir .. "/widgets/wifi_02.png"

-- }}}

-- {{{ Menu

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

-- theme.menu_border_width = "1"
-- theme.menu_border_color = "#afa72e"

theme.menu_height        = "8"
theme.menu_width         = "105"
theme.menu_border_width  = "0"
theme.menu_fg_normal     = "#ecedee"   --color txt pip
theme.menu_fg_focus      = "#6b8ba3"
theme.menu_bg_normal     = "#000000"   --background menu
theme.menu_bg_focus      = "#000000"

-- theme.menu_bg_normal  = "#000000bb"   --background menu
-- theme.menu_bg_focus   = "#000000bb"


-- }}}

-- {{{ Taglist

theme.taglist_squares_sel   = theme.confdir .. "/taglist/squaref_b.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/square_b.png"

--theme.taglist_squares_resize = "false"

-- }}}

-- {{{ Layout

-- theme.layout_tile           = theme.confdir .. "/layouts/tile.png"
-- theme.layout_tileleft       = theme.confdir .. "/layouts/tileleft.png"
-- theme.layout_tilebottom     = theme.confdir .. "/layouts/tilebottom.png"
-- theme.layout_tiletop        = theme.confdir .. "/layouts/tiletop.png"
-- theme.layout_fairv          = theme.confdir .. "/layouts/fairv.png"
-- theme.layout_fairh          = theme.confdir .. "/layouts/fairh.png"
-- theme.layout_spiral         = theme.confdir .. "/layouts/spiral.png"
-- theme.layout_dwindle        = theme.confdir .. "/layouts/dwindle.png"
-- theme.layout_max            = theme.confdir .. "/layouts/max.png"
-- theme.layout_fullscreen     = theme.confdir .. "/layouts/fullscreen.png"
-- theme.layout_magnifier      = theme.confdir .. "/layouts/magnifier.png"
-- theme.layout_floating       = theme.confdir .. "/layouts/floating.png"


theme.layout_floating   = "<span color='" .. theme.fg_green .. "'>float</span>"
theme.layout_tile       = "<span color='" .. theme.fg_green .. "'>right</span>"
theme.layout_tileleft   = "<span color='" .. theme.fg_green .. "'>left</span>"
theme.layout_tilebottom = "<span color='" .. theme.fg_green .. "'>bottom</span>"
theme.layout_tiletop    = "<span color='" .. theme.fg_green .. "'>top</span>"
theme.layout_fairv      = "<span color='" .. theme.fg_green .. "'>fair</span>"

-- theme.layout_spiral     = "<span color='" .. theme.fg_cyan .. "'>[spiral]</span>"
-- theme.layout_dwindle    = "<span color='" .. theme.fg_cyan .. "'>[dwindle]</span>"
-- theme.layout_max        = "<span color='" .. theme.fg_cyan .. "'>[max]</span>"
-- theme.layout_magnifier  = "<span color='" .. theme.fg_cyan .. "'>[magnifier]</span>"

-- }}}

-- {{{ Misc

theme.awesome_icon           = theme.confdir .. "/start-here-circle5.png"
theme.menu_submenu_icon      = theme.confdir .. "/submenu.png"
theme.tasklist_floating_icon = theme.confdir .. "/floating.png"

-- }}}

return theme
