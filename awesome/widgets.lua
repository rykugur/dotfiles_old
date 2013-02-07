-- Create a textclock widget
--mytextclock = awful.widget.textclock("%H:%M",60)

-- how to use fit 
--memwidget_text.fit = function(_, w, h)
--    return 80, h
--end
--memwidget_text:set_align("center")

-- separator widget
separatorwidget_text = wibox.widget.textbox()
separatorwidget_text:set_text("")
separatorwidget = wibox.widget.background()
separatorwidget.fit = function(_, w, h)
    return 1, h
end
separatorwidget:set_widget(separatorwidget_text)
separatorwidget:set_bg(arch_darkblue)

-- date widget
datewidget_text = wibox.widget.textbox()
vicious.register(datewidget_text, vicious.widgets.date, " <span color='"..arch_darkgray.."'>%R</span> ", 61)
datewidget = wibox.widget.background()
datewidget:set_widget(datewidget_text)
--datewidget:set_bg(bgcol5)

-- memory widget
memwidget_text = wibox.widget.textbox()
vicious.register(memwidget_text, vicious.widgets.mem, " <span color='"..arch_blue.."'>ram</span> <span color='"..arch_darkgray.."'>$2</span> ", 1)
memwidget = wibox.widget.background()
memwidget:set_widget(memwidget_text)
--memwidget:set_bg(bgcol2)

-- CPU widget
cpuwidget_text = wibox.widget.textbox()
vicious.register(cpuwidget_text, vicious.widgets.cpu, " <span color='"..arch_blue.."'>cpu</span> <span color='"..arch_darkgray.."'>$3%</span>", 3)
cpuwidget = wibox.widget.background()
cpuwidget.fit = function(_, w, h)
    return 52, h
end
cpuwidget:set_widget(cpuwidget_text)
--cpuwidget:set_bg(bgcol2)

-- disk widget
--diskwidget_text = wibox.widget.textbox()
--vicious.register(diskwidget_text, vicious.widgets.fs, " <span color='"..blue2.."'>disk</span> <span color='"..white.."'>${/home used_gb}gb <span color='"..blue2.."'>/</span> ${/home avail_gb}gb</span> ", 1)

-- battery widget
batwidget_text = wibox.widget.textbox()
vicious.register(batwidget_text, vicious.widgets.bat, " <span color='"..arch_blue.."'>bat</span> <span color='"..arch_darkgray.."'>$2%$1</span> ", 1, "BAT0")
batwidget = wibox.widget.background()
batwidget:set_widget(batwidget_text)
--batwidget:set_bg(bgcol1)

-- wifi widget
--wifiwidget_text = wibox.widget.textbox()
--vicious.register(wifiwidget_text, vicious.widgets.net, " <span color='"..blue2.."'>up</span> <span color='"..white.."'>${wlp3s0 up_kb}</span> <span color='"..blue2.."'>down</span> <span color='"..white.."'>${wlp3s0 down_kb}</span> ", 1)

-- volume widget
volwidget_text = wibox.widget.textbox()
vicious.register(volwidget_text, vicious.widgets.volume, " <span color='"..arch_blue.."'>vol</span> <span color='"..arch_darkgray.."'>$1%</span> ", 1, "Master")
volwidget = wibox.widget.background()
volwidget:set_widget(volwidget_text)
--volwidget:set_bg(bgcol7)
