-- awesome 3 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("wicked")

-- Zakladni promenne    {{{
terminal = "urxvt"
modkey = "Mod4"
layouts = { "tile", "tilebottom", "max", "floating" }
-- }}}
-- Barvy a fonty    {{{
font = "cure 8"
border_width = 1

color_sep = "red"               -- separators
color_tag_focus_bg = "black"    -- taglist focus color - background
color_tag_focus_fg = "red"      -- taglist focus color - foreground

bg_normal = "#000000"
fg_normal = "#aaaaaa"
border_normal = "#000000"

bg_focus = "#535d6c"
fg_focus = "#ffffff"
border_focus = bg_focus
border_marked = "#91231C"


awesome.colors_set({ fg = fg_normal, bg = bg_normal })
awesome.font_set(font)
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
mytaglist:mouse_add(mouse.new({}, 1, function (object, tag) awful.tag.viewonly(tag) end))
mytaglist:mouse_add(mouse.new({ modkey }, 1, function (object, tag) awful.client.movetotag(tag) end))
mytaglist:mouse_add(mouse.new({}, 3, function (object, tag) tag:view(not tag:isselected()) end))
mytaglist:mouse_add(mouse.new({ modkey }, 3, function (object, tag) awful.client.toggletag(tag) end))
mytaglist:mouse_add(mouse.new({ }, 4, awful.tag.viewnext))
mytaglist:mouse_add(mouse.new({ }, 5, awful.tag.viewprev))
mytaglist.text_focus = "<span color=\"" .. color_tag_focus_fg .. "\"><bg color=\"" .. color_tag_focus_bg .. "\"/> <title/> </span>"
-- }}}
-- Layout image {{{
mylayoutbox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = widget.new({ type = "textbox", name = "mylayoutbox", align = "right" })
    mylayoutbox[s]:mouse_add(mouse.new({ }, 1, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse.new({ }, 3, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s]:mouse_add(mouse.new({ }, 4, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse.new({ }, 5, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s].text = "<bg image=\"/usr/share/awesome/icons/layouts/tilew.png\" resize=\"true\"/>"
end
-- }}}
-- MenuBox {{{
mymenubox = widget.new({ type = "textbox", name = "mytextbox", align = "left" })
-- }}}
-- Systray {{{
mysystray = widget.new({ type = "systray", name = "mysystray", align = "right" })
-- }}}
-- Widget Separator {{{
sep_left = widget.new({ type = "textbox", name = "sep_left", align = "left"})
sep_left.text = " "

sep_right = widget.new({ type = "textbox", name = "sep_right", align = "right"})
sep_right.text = " "

sep_l_left = widget.new({ type = "textbox", name = "sep_l_left", align = "left"})
sep_l_left.text = "<span color=\"" .. color_sep .. "\">[</span>"

sep_b_left = widget.new({ type = "textbox", name = "sep_b_left", align = "left"})
sep_b_left.text = "<span color=\"" .. color_sep .. "\">][</span>"

sep_r_left = widget.new({ type = "textbox", name = "sep_r_left", align = "left"})
sep_r_left.text = "<span color=\"" .. color_sep .. "\">]</span>"

sep_l_right = widget.new({ type = "textbox", name = "sep_l_right", align = "right"})
sep_l_right.text = "<span color=\"" .. color_sep .. "\">[</span>"

sep_b_right = widget.new({ type = "textbox", name = "sep_b_right", align = "right"})
sep_b_right.text = "<span color=\"" .. color_sep .. "\">][</span>"

sep_r_right = widget.new({ type = "textbox", name = "sep_r_right", align = "right"})
sep_r_right.text = "<span color=\"" .. color_sep .. "\">]</span>"
-- }}}
-- Arch Logo {{{
arch = widget.new({ type = "textbox", name = "arch", align = "left"})
arch.text = "<span font_desc='openlogos'>A</span>"

-- }}}
-- Widget Volume    {{{
vol_tb = widget.new({ type = "textbox", name = "vol_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
vol_tb:mouse_add(mouse.new({ }, 1, function () awful.spawn("exec amixer sset PCM 5%+ >/dev/null") end))
vol_tb:mouse_add(mouse.new({ }, 2, function () awful.spawn("exec amixer sset PCM toggle >/dev/null") end))
vol_tb:mouse_add(mouse.new({ }, 3, function () awful.spawn("exec amixer sset PCM 5%- >/dev/null") end))
vol_tb.text = "0%"

wicked.register(vol_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/volume.py')
       local l = f:read()
       f:close()
       return l
   end, 2)
-- }}}
-- Widget Layout {{{
lay_tb = widget.new({ type = "textbox", name = "lay_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
--lay_t:set('text', '❚❙')
lay_tb.text ="✖"
--lay_tb:set('text', '<span font_desc="cambria 8">✖❐▀</span>')
--lay_tb:set('text', '<sup>◰</sup>')
-- }}}
-- Widget MPD   {{{
mpd_tb = widget.new({ type = "textbox", name = "mpd_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
mpd_tb.text = "[]: not playing"

-- nacteni mpd parseru
wicked.register(mpd_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/mpd.py')
       local l = f:read()
       f:close()
       return l
   end, 5)
-- }}}
-- Widget Wifi   {{{
wifi_tb = widget.new({ type = "textbox", name = "wifi_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
wifi_tb.text = "no connection"

-- nacteni wifi parseru
wicked.register(wifi_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/wifi.py')
       local l = f:read()
       f:close()
       return l
   end, 5)
-- }}}
-- Widget CPU   {{{
cpu_tb = widget.new({ type = "textbox", name = "cpu_tb", align = "right"})
cpu_tb.text = "0%|0%"

-- nacteni cpu parseru
wicked.register(cpu_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/cpuusage.py')
       local l = f:read()
       f:close()
       return l
   end, 5)
-- }}}
-- Widget Memory+Swap   {{{
mem_tb = widget.new({ type = "textbox", name = "mem_tb", align = "right"})
mem_tb.text = "0%|0%"

-- nacteni mem parseru
wicked.register(mem_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/memswap.py')
       local l = f:read()
       f:close()
       return l
   end, 5)
-- }}}
-- Widget HDD   {{{
hdd_tb = widget.new({ type = "textbox", name = "hdd_tb", align = "right"})
hdd_tb.text = "0%|0%|0%|0%"

-- nacteni hdd parseru
wicked.register(hdd_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/filesystem.py')
       local l = f:read()
       f:close()
       return l
   end, 5)
-- }}}
-- Widget Battery   {{{
bat_tb = widget.new({ type = "textbox", name = "bat_tb", align = "right"})
bat_tb.text = "0%"

-- nacteni parseru pro baterku
wicked.register(bat_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/battery.py')
       local l = f:read()
       f:close()
       return l
   end, 1)
-- }}}
-- Widget Pacman   {{{
pac_tb = widget.new({ type = "textbox", name = "pac_tb", align = "right"})
pac_tb.text = "up-to-date"

-- nacteni parseru pro pacman
wicked.register(pac_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/arch-updates/parser.py')
       local l = f:read()
       f:close()
       return l
   end, 3600)
-- }}}
-- Widget Email   {{{
email_tb = widget.new({ type = "textbox", name = "email_tb", align = "right"})
email_tb.text = "no mail"

-- nacteni email parseru
wicked.register(email_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/email.py')
       local l = f:read()
       f:close()
       return l
   end, 1)
-- }}}
-- Widget Clock   {{{
clock_tb = widget.new({ type = "textbox", name = "clock_tb", align = "right"})
clock_tb.width = "140"

-- nacteni parseru pro cas
wicked.register(clock_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/datetime.py')
       local l = f:read()
       f:close()
       return l
   end, 1)
-- }}}
-- Statusbar    {{{ 
for s = 1, screen.count() do
    sb_top = statusbar.new({ position = "top", name = "sb_top" .. s, fg = "white", bg = "black", height = "10" })

    -- Add widgets to the statusbar - order matters
    sb_top:widget_add(sep_left)
    sb_top:widget_add(arch)
    sb_top:widget_add(sep_left)
    sb_top:widget_add(mytaglist)
    sb_top:widget_add(sep_left)

    --sb_top:widget_add(layoutbox[s])
    sb_top:widget_add(lay_tb)
    sb_top:widget_add(sep_left)

    sb_top:widget_add(sep_l_left)
    sb_top:widget_add(vol_tb)

    sb_top:widget_add(sep_b_left)
    sb_top:widget_add(mpd_tb)

    sb_top:widget_add(sep_b_left)
    sb_top:widget_add(wifi_tb)
    sb_top:widget_add(sep_r_left)

    sb_top:widget_add(sep_left)
    sb_top:widget_add(mymenubox)
    sb_top:widget_add(sep_right)
    
    sb_top:widget_add(sep_l_right)
    sb_top:widget_add(cpu_tb)

    sb_top:widget_add(sep_b_right)
    sb_top:widget_add(mem_tb)

    sb_top:widget_add(sep_b_right)
    sb_top:widget_add(hdd_tb)

    sb_top:widget_add(sep_b_right)
    sb_top:widget_add(bat_tb)

    sb_top:widget_add(sep_b_right)
    sb_top:widget_add(pac_tb)

    sb_top:widget_add(sep_b_right)
    sb_top:widget_add(email_tb)
    sb_top:widget_add(sep_r_right)

    sb_top:widget_add(sep_right)
    sb_top:widget_add(sep_right)
    sb_top:widget_add(sep_right)
    sb_top:widget_add(clock_tb)

--    sb_top:widget_add(mysystray)
    sb_top:add(s)
end
-- }}}
-- Bindovani mysky {{{
awesome.mouse_add(mouse.new({ }, 3, function () awful.spawn(terminal) end))
awesome.mouse_add(mouse.new({ }, 4, awful.tag.viewnext))
awesome.mouse_add(mouse.new({ }, 5, awful.tag.viewprev))
-- }}}
-- {{{ Key bindings 

-- Prepinani ploch 
keybinding.new({ modkey }, 1, function () awful.tag.viewonly(tags[1][1]) end ):add()
keybinding.new({ modkey }, 2, function () awful.tag.viewonly(tags[1][2]) end ):add()
keybinding.new({ modkey }, 3, function () awful.tag.viewonly(tags[1][3]) end ):add()
keybinding.new({ modkey }, 4, function () awful.tag.viewonly(tags[1][4]) end ):add()
keybinding.new({ modkey }, 5, function () awful.tag.viewonly(tags[1][5]) end ):add()

keybinding.new({ modkey }, "Left", awful.tag.viewprev):add()
keybinding.new({ modkey }, "Right", awful.tag.viewnext):add()

-- Zapinani programu
keybinding.new({ modkey }, "x", function () awful.spawn(terminal) end):add()
keybinding.new({ modkey }, "f", function () awful.spawn("firefox") end):add()
keybinding.new({ modkey }, "Return", function ()
                                     awful.prompt({ prompt = "Run: ", cursor_fg = 'red', cursor_bg = 'black' }, mymenubox, awful.spawn, awful.completion.bash)
                                 end):add()
--keybinding.new({ modkey }, "Return", function () awful.spawn("exec `dmenu_path | dmenu -b -nb black -sb '#333333' -sf white -nf white`") end):add()

-- Operace s awesome
keybinding.new({ modkey, "Control" }, "r", awesome.restart):add()
keybinding.new({ modkey, "Shift" }, "q", awesome.quit):add()


-- Client manipulation
keybinding.new({ modkey, "Shift" }, "c", function () client.focus_get():kill() end):add()
keybinding.new({ modkey }, "j", function () awful.client.focus(1) end):add()
keybinding.new({ modkey }, "k", function () awful.client.focus(-1) end):add()
keybinding.new({ modkey, "Shift" }, "j", function () awful.client.swap(1) end):add()
keybinding.new({ modkey, "Shift" }, "k", function () awful.client.swap(-1) end):add()
keybinding.new({ modkey, "Control" }, "j", function () awful.screen.focus(1) end):add()
keybinding.new({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end):add()
keybinding.new({ modkey, "Control" }, "space", function () awful.client.togglefloating() end):add()
 
-- Layout manipulation
keybinding.new({ modkey }, "l", function () awful.tag.incmwfact(0.05) end):add()
keybinding.new({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end):add()
keybinding.new({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1) end):add()
keybinding.new({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end):add()
keybinding.new({ modkey, "Control" }, "h", function () awful.tag.incncol(1) end):add()
keybinding.new({ modkey, "Control" }, "l", function () awful.tag.incncol(1) end):add()
keybinding.new({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding.new({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()
-- }}}
-- {{{ Hooks
-- Hook function to execute when focusing a client.
function hook_focus(c)
    c:border_set({ width = 1, color = "red" })
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    c:border_set({ width = 1, color = "black" })
end

-- Hook function to exeucte when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus
    if awful.layout.get(c:screen_get()) ~= "magnifier" then
        c:focus_set()
    end
end

-- Hook function to execute when a new client appears.
function hook_manage(c)
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c:mouse_add(mouse.new({ }, 1, function (c) c:focus_set(); c:raise() end))
    c:mouse_add(mouse.new({ modkey }, 1, function (c) c:mouse_move() end))
    c:mouse_add(mouse.new({ modkey }, 3, function (c) c:mouse_resize() end))
    c:border_set({ width = 1, color = "black" })
    c:focus_set()
    local name = c:name_get()
    if name:lower():find("gimp") 
        or name:lower():find("mplayer") 
        or name:lower():find("feh") 
        or name:lower():find("wine") 
        or name:lower():find("psi") 
        or name:lower():find("skype") 
    then    
        c:floating_set(true)
    end
    
    if name:lower():find("psi") then
        awful.client.movetotag(tags[1][4], c)
    end
    
    if name:lower():find("firefox") then
        awful.client.movetotag(tags[1][1], c)
    end

    c:honorsizehints_set(true)
end

-- Hook function to execute when arranging the screen
-- (tag switch, new client, etc)

function hook_arrange(screen)
    local layout = awful.layout.get(screen)
    mylayoutbox[screen]:set("image", "/usr/share/awesome/icons/layouts/" .. layout .. "w.png")
end

-- Set up some hooks
hooks.focus(hook_focus)
hooks.unfocus(hook_unfocus)
hooks.manage(hook_manage)
hooks.mouseover(hook_mouseover)
hooks.arrange(hook_arrange)
-- }}}
