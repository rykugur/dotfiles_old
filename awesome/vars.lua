beautiful.init("/home/dusty/dotfiles/awesome/themes/rollhax/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
terminale = "urxvtc -e tmux -2"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- colors
blue        = "#1047A9"
blue2       = "#2C7E82"
green       = "#1DD300"
orange      = "#FF5300"
lightorange = "#FF9140"
darkorange  = "#A64600"
black       = "#000000"
white       = "#FFFFFF"

-- widiget colors
bgcol1 = "#FF4000"
bgcol2 = "#8D94BA"
bgcol3 = "#454F8C"
bgcol4 = "#C3D0E0"
bgcol5 = "#FF7F17"
bgcol6 = "#E0FF17"
bgcol7 = "#FFC517"

-- "arch" colors
arch_blue      = "#3C63A6"
arch_darkblue  = "#293069"
arch_lightblue = "#5D6CDE"
arch_darkgray  = "#6E6E6E"
arch_lightgray = "#D2D2D4"

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

if beautiful.wallpaper then for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
