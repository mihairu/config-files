-- awesome 3 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("wicked")

-- Zakladni promenne    {{{
terminal = "urxvt"
modkey = "Mod4"
layouts = { "tile", "tilebottom", "max", "floating" }
font = "cure 8"
-- }}}
-- Barvy a fonty    {{{
awesome.font_set(font)
awesome.resizehints_set(false)
-- }}}
-- Nastaveni tagu   {{{ 
tags = {}
tags[1] =
{
    tag.new({ name = "1:web" }),
    tag.new({ name = "2:dev" }),
    tag.new({ name = "3:dev-2" }),
    tag.new({ name = "4:im" }),
    tag.new({ name = "5:other" })
}

--  Add tags to screen one by one
for index, tag in ipairs(tags[1]) do
    tag:add(1)
end
tags[1][1]:view(true)
-- }}}
-- {{{ Taglist
-- Create a taglist widget
mytaglist = widget.new({ type = "taglist", name = "mytaglist" })
mytaglist:mouse({}, 1, awful.tag.viewonly)
mytaglist:mouse({ modkey }, 1, awful.client.toggletag)
mytaglist:mouse({}, 3,
                function (tag)
                    tag:view(not tag:isselected())
                end)
mytaglist:mouse({ modkey }, 3, awful.client.toggletag)
mytaglist:mouse({ }, 4, awful.tag.viewnext)
mytaglist:mouse({ }, 5, awful.tag.viewprev)
mytaglist:set("text_focus", "<bg color=\"#555555\"/> <title/> ")
-- }}}
-- Layout image {{{
layoutimg = widget.new({ type = "iconbox", name = "myiconbox", align = "left" })
layoutimg:set("image", "/usr/share/awesome/icons/layouts/tile.png")
-- }}}
-- Widget Separator {{{
separator = widget.new({ type = "textbox", name = "separator", align = "left"})
separator:set("text", " ")

separatorr = widget.new({ type = "textbox", name = "separator", align = "right"})
separatorr:set("text", " ")
-- }}}
-- Widget Volume    {{{
vol_ib = widget.new({ type = "iconbox", name = "vol_ib", align = "left"})
vol_ib:set("image", "/home/mihairu/.awesome/transicons/vol.png")
vol_ib:set("resize", "false")
vol_ib:mouse({ }, 1, function () awful.spawn("exec amixer sset PCM 5%+ >/dev/null") end)
vol_ib:mouse({ }, 2, function () awful.spawn("exec amixer sset PCM toggle >/dev/null") end)
vol_ib:mouse({ }, 3, function () awful.spawn("exec amixer sset PCM 5%- >/dev/null") end)

vol_tb = widget.new({ type = "textbox", name = "vol_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
vol_tb:mouse({ }, 1, function () awful.spawn("exec amixer sset PCM 5%+ >/dev/null") end)
vol_tb:mouse({ }, 2, function () awful.spawn("exec amixer sset PCM toggle >/dev/null") end)
vol_tb:mouse({ }, 3, function () awful.spawn("exec amixer sset PCM 5%- >/dev/null") end)
vol_tb:set("text", "0%")

-- }}}
-- Widget MPD   {{{
mpd_ib = widget.new({ type = "iconbox", name = "mpd_ib", align = "left"})
mpd_ib:set("image", "/home/mihairu/.awesome/transicons/moc.png")
mpd_ib:set("resize", "false")

mpd_tb = widget.new({ type = "textbox", name = "mpd_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
mpd_tb:set("text", "[]: not playing")

-- nacteni mpd parseru
wicked.register(mpd_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/mpd.py'):read()
   end, 5)
-- }}}
-- Widget Wifi   {{{
wifi_ib = widget.new({ type = "iconbox", name = "wifi_ib", align = "left"})
wifi_ib:set("image", "/home/mihairu/.awesome/transicons/wifi.png")
wifi_ib:set("resize", "false")

wifi_tb = widget.new({ type = "textbox", name = "wifi_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
wifi_tb:set("text", "no connection")

-- nacteni wifi parseru
wicked.register(wifi_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/wifi.py'):read()
   end, 5)
-- }}}
-- Widget CPU   {{{
cpu_ib = widget.new({ type = "iconbox", name = "cpu_ib", align = "right"})
cpu_ib:set("image", "/home/mihairu/.awesome/transicons/cpu.png")
cpu_ib:set("resize", "false")

cpu_tb = widget.new({ type = "textbox", name = "cpu_tb", align = "right"})
cpu_tb:set("text", "0%|0%")

-- nacteni cpu parseru
wicked.register(cpu_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/cpuusage.py'):read()
   end, 5)
-- }}}
-- Widget Memory+Swap   {{{
mem_ib = widget.new({ type = "iconbox", name = "mem_ib", align = "right"})
mem_ib:set("image", "/home/mihairu/.awesome/transicons/mem.png")
mem_ib:set("resize", "false")

mem_tb = widget.new({ type = "textbox", name = "mem_tb", align = "right"})
mem_tb:set("text", "0%|0%")

-- nacteni mem parseru
wicked.register(mem_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/memswap.py'):read()
   end, 5)
-- }}}
-- Widget HDD   {{{
hdd_ib = widget.new({ type = "iconbox", name = "hdd_ib", align = "right"})
hdd_ib:set("image", "/home/mihairu/.awesome/transicons/disk2.png")
hdd_ib:set("resize", "false")

hdd_tb = widget.new({ type = "textbox", name = "hdd_tb", align = "right"})
hdd_tb:set("text", "0%|0%|0%|0%")

-- nacteni hdd parseru
wicked.register(hdd_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/filesystem.py'):read()
   end, 5)
-- }}}
-- Widget Battery   {{{
bat_ib = widget.new({ type = "iconbox", name = "bat_ib", align = "right"})
bat_ib:set("image", "/home/mihairu/.awesome/transicons/bat.png")
bat_ib:set("resize", "false")

bat_tb = widget.new({ type = "textbox", name = "bat_tb", align = "right"})
bat_tb:set("text", "0%")

-- nacteni parseru pro baterku
wicked.register(bat_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/bat.pl'):read()
   end, 1)
-- }}}
-- Widget Pacman   {{{
pac_ib = widget.new({ type = "iconbox", name = "pac_ib", align = "right"})
pac_ib:set("image", "/home/mihairu/.awesome/transicons/pacman2.png")
pac_ib:set("resize", "false")

pac_tb = widget.new({ type = "textbox", name = "pac_tb", align = "right"})
pac_tb:set("text", "up-to-date")

-- nacteni parseru pro pacman
wicked.register(pac_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/arch-updates/parser.py'):read()
   end, 3600)
-- }}}
-- Widget Email   {{{
email_ib = widget.new({ type = "iconbox", name = "email_ib", align = "right"})
email_ib:set("image", "/home/mihairu/.awesome/transicons/mail2.png")
email_ib:set("resize", "false")

email_tb = widget.new({ type = "textbox", name = "email_tb", align = "right"})
email_tb:set("text", "no mail")

-- nacteni email parseru
wicked.register(email_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/email.py'):read()
   end, 1)
-- }}}
-- Widget Clock   {{{
clock_tb = widget.new({ type = "textbox", name = "clock_tb", align = "right"})
clock_tb:set("width", "130")

-- nacteni parseru pro cas
wicked.register(clock_tb, 'function', function (widget, args)
       return io.popen('/home/mihairu/scripts/datetime.py'):read()
   end, 1)
-- }}}
-- Statusbar    {{{
sb_top = statusbar.new({ position = "top", name = "sb_top1" .. 1,
                                fg = "white", bg = "black" })
-- Add widgets to the statusbar - order matters
sb_top:widget_add(mytaglist)
sb_top:widget_add(separator)
sb_top:widget_add(layoutimg)

sb_top:widget_add(separator)
sb_top:widget_add(vol_ib)
sb_top:widget_add(separator)
sb_top:widget_add(vol_tb)

sb_top:widget_add(separator)
sb_top:widget_add(mpd_ib)
sb_top:widget_add(separator)
sb_top:widget_add(mpd_tb)

sb_top:widget_add(separator)
sb_top:widget_add(wifi_ib)
sb_top:widget_add(separator)
sb_top:widget_add(wifi_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(cpu_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(cpu_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(mem_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(mem_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(hdd_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(hdd_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(bat_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(bat_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(pac_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(pac_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(email_ib)
sb_top:widget_add(separatorr)
sb_top:widget_add(email_tb)

sb_top:widget_add(separatorr)
sb_top:widget_add(separatorr)
sb_top:widget_add(separatorr)
sb_top:widget_add(clock_tb)

sb_top:add(1) -- pridej pro screen 1
-- }}}
-- Bindovani mysky {{{
awesome.mouse({ }, 3, function () awful.spawn(terminal) end)
awesome.mouse({ }, 4, awful.tag.viewnext)
awesome.mouse({ }, 5, awful.tag.viewprev)
client.mouse({ modkey }, 1, mouse.client_move)
client.mouse({ modkey }, 3, mouse.client_resize)
-- }}}
-- {{{ Key bindings

-- Prepinani ploch
awesome.key({ modkey }, 1, function () awful.tag.viewonly(tags[1][1]) end )
awesome.key({ modkey }, 2, function () awful.tag.viewonly(tags[1][2]) end )
awesome.key({ modkey }, 3, function () awful.tag.viewonly(tags[1][3]) end )
awesome.key({ modkey }, 4, function () awful.tag.viewonly(tags[1][4]) end )
awesome.key({ modkey }, 5, function () awful.tag.viewonly(tags[1][5]) end )

awesome.key({ modkey }, "Left", awful.tag.viewprev)
awesome.key({ modkey }, "Right", awful.tag.viewnext)

-- Zapinani programu
awesome.key({ modkey }, "x", function () awful.spawn(terminal) end)
awesome.key({ modkey }, "f", function () awful.spawn("firefox") end)
awesome.key({ modkey }, "Return", function () awful.spawn("exec `dmenu_path | dmenu -b -nb black -sb '#333333' -sf white -nf white`") end)

-- Operace s awesome
awesome.key({ modkey, "Control" }, "r", awesome.restart)
awesome.key({ modkey, "Shift" }, "q", awesome.quit)


-- Client manipulation
awesome.key({ modkey, "Shift" }, "c", function () client.focus_get():kill() end)
awesome.key({ modkey }, "j", function () awful.client.focus(1) end)
awesome.key({ modkey }, "k", function () awful.client.focus(-1) end)
awesome.key({ modkey, "Shift" }, "j", function () awful.client.swap(1) end)
awesome.key({ modkey, "Shift" }, "k", function () awful.client.swap(-1) end)
awesome.key({ modkey, "Control" }, "j", function () awful.screen.focus(1) end)
awesome.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end)
awesome.key({ modkey, "Control" }, "space", function () awful.client.togglefloating() end)

-- Layout manipulation
awesome.key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end)
awesome.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end)
awesome.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1) end)
awesome.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end)
awesome.key({ modkey, "Control" }, "h", function () awful.tag.incncol(1) end)
awesome.key({ modkey, "Control" }, "l", function () awful.tag.incncol(1) end)
awesome.key({ modkey }, "space", function () awful.layout.inc(layouts, 1) end)
awesome.key({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end)
-- }}}
-- {{{ Hooks
-- Hook function to execute when focusing a client.
function hook_focus(c)
    c:border_set({ width = 1, color = "#999999" })
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    c:border_set({ width = 1, color = "black" })
end

-- Hook function to exeucte when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus
    c:focus_set()
end

-- Hook function to execute when a new client appears.
function hook_newclient(c)
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c:border_set({ width = 1, color = "black" })
    c:focus_set()
    local name = c:name_get()
    if name:lower():find("mplayer") then
        c:floating_set(true)
    end
    if name:lower():find("psi") then
        c:floating_set(true)
    end
end

-- Hook function to execute when arranging the screen
-- (tag switch, new client, etc)
function hook_arrange()
    local layout = awful.layout.get()    
    layoutimg:set("image", "~/.awesome/layouts/" .. layout .. "my.png")
end

-- Set up some hooks
hooks.focus(hook_focus)
hooks.unfocus(hook_unfocus)
hooks.newclient(hook_newclient)
hooks.mouseover(hook_mouseover)
hooks.arrange(hook_arrange)
-- }}}

-- Respect size hints
awesome.resizehints_set(true)
