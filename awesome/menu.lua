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
