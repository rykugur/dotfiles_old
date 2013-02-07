-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
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

-- Define a tag table which hold all screen tags.
tags = {
        names =  { "1.term",   "2.www",    "3.code",   "4.sonstig", "5.misc" },
        layout = { layouts[2], layouts[8], layouts[1], layouts[8],  layouts[2]  }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
