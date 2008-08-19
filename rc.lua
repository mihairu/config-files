io.stderr:write("===== Awesome Reloaded\r\n")
-- awesome 1 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("tabulous")
require("beautiful")
require("wicked")

-- {{{ Variable definitions
-- This is a file path to a theme file which will defines colors.
theme_path = "/home/mihairu/.config/awesome/theme"
color_sep = "#ff0000"

-- This is used later as the default terminal to run.
terminal = "urxvt"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    "tile",
    "tileleft",
    "tilebottom",
    "tiletop",
    "magnifier",
    "max",
    "spiral",
    "dwindle",
    "floating"
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["feh"] = true,
    ["wine"] = true,
    ["psi"] = true,
    ["skype"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
     ["Firefox"] = { screen = 1, tag = 1 },
     ["Psi"] = { screen = 1, tag = 4 },
     ["Skype"] = { screen = 1, tag = 4 },
    -- ["mocp"] = { screen = 2, tag = 4 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Initialization
-- Initialize theme (colors).
beautiful.init(theme_path)

-- Register theme in awful.
-- This allows to not pass plenty of arguments to each function
-- to inform it about colors we want it to draw.
awful.beautiful.register(beautiful)

-- Uncomment this to activate autotabbing
-- tabulous.autotab_start()
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
tags[1] = {}
tags[1][1] = tag({ name = "1:web" })
tags[1][2] = tag({ name = "2:dev" })
tags[1][3] = tag({ name = "3:dev-2" })
tags[1][4] = tag({ name = "4:im" })
tags[1][5] = tag({ name = "5:other" })

for tagnumber = 1, 5 do 
    tags[1][tagnumber].mwfact = 0.618033988769
    tags[1][tagnumber].screen = 1 
end
tags[1][1].selected = true
-- }}}

-- {{{ Statusbar
-- Create a taglist widget
mytaglist = widget({ type = "taglist", name = "mytaglist" })
mytaglist:mouse_add(mouse({}, 1, function (object, tag) awful.tag.viewonly(tag) end))
mytaglist:mouse_add(mouse({ modkey }, 1, function (object, tag) awful.client.movetotag(tag) end))
mytaglist:mouse_add(mouse({}, 3, function (object, tag) tag.selected = not tag.selected end))
mytaglist:mouse_add(mouse({ modkey }, 3, function (object, tag) awful.client.toggletag(tag) end))
mytaglist:mouse_add(mouse({ }, 4, awful.tag.viewnext))
mytaglist:mouse_add(mouse({ }, 5, awful.tag.viewprev))
mytaglist.label = awful.widget.taglist.label.all

-- Widget Separator {{{
sep_left = widget({ type = "textbox", name = "sep_left", align = "left"})
sep_left.text = " "

sep_right = widget({ type = "textbox", name = "sep_right", align = "right"})
sep_right.text = " "

sep_l_left = widget({ type = "textbox", name = "sep_l_left", align = "left"})
sep_l_left.text = "<span color=\"" .. color_sep .. "\">[</span>"

sep_b_left = widget({ type = "textbox", name = "sep_b_left", align = "left"})
sep_b_left.text = "<span color=\"" .. color_sep .. "\">][</span>"

sep_r_left = widget({ type = "textbox", name = "sep_r_left", align = "left"})
sep_r_left.text = "<span color=\"" .. color_sep .. "\">]</span>"

sep_l_right = widget({ type = "textbox", name = "sep_l_right", align = "right"})
sep_l_right.text = "<span color=\"" .. color_sep .. "\">[</span>"

sep_b_right = widget({ type = "textbox", name = "sep_b_right", align = "right"})
sep_b_right.text = "<span color=\"" .. color_sep .. "\">][</span>"

sep_r_right = widget({ type = "textbox", name = "sep_r_right", align = "right"})
sep_r_right.text = "<span color=\"" .. color_sep .. "\">]</span>"
-- }}}

-- Widget Volume    {{{
vol_tb = widget({ type = "textbox", name = "vol_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
vol_tb:mouse_add(mouse({ }, 1, function () awful.spawn("exec amixer sset PCM 5%+ >/dev/null") end))
vol_tb:mouse_add(mouse({ }, 2, function () awful.spawn("exec amixer sset PCM toggle >/dev/null") end))
vol_tb:mouse_add(mouse({ }, 3, function () awful.spawn("exec amixer sset PCM 5%- >/dev/null") end))
vol_tb.text = "0%"

wicked.register(vol_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/volume.py')
       local l = f:read()
       f:close()
       return l
   end, 2)
-- }}}

-- Widget MPD   {{{
mpd_tb = widget({ type = "textbox", name = "mpd_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
mpd_tb.text = "[]: not playing"

-- nacteni mpd parseru
--wicked.register(mpd_tb, 'function', function (widget, args)
--       local f = io.popen('/home/mihairu/scripts/mpd.py')
--      local l = f:read()
--       f:close()
--       return l
--   end, 5)
-- }}}
-- Widget Wifi   {{{
wifi_tb = widget({ type = "textbox", name = "wifi_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
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
cpu_tb = widget({ type = "textbox", name = "cpu_tb", align = "right"})
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
mem_tb = widget({ type = "textbox", name = "mem_tb", align = "right"})
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
hdd_tb = widget({ type = "textbox", name = "hdd_tb", align = "right"})
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
bat_tb = widget({ type = "textbox", name = "bat_tb", align = "right"})
bat_tb.text = "0%"

-- nacteni parseru pro baterku
wicked.register(bat_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/battery.py')
       local l = f:read()
       f:close()
       return l
   end, 1)
-- }}}
-- Widget Email   {{{
email_tb = widget({ type = "textbox", name = "email_tb", align = "right"})
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
clock_tb = widget({ type = "textbox", name = "clock_tb", align = "right"})
clock_tb.width = "120"

-- nacteni parseru pro cas
wicked.register(clock_tb, 'function', function (widget, args)
       local f = io.popen('/home/mihairu/scripts/datetime.py')
       local l = f:read()
       f:close()
       return l
   end, 1)
-- }}}

-- Create an prompt widget
mypromptbox = widget({ type = "textbox", name = "mypromptbox", align = "left" })

-- Create an iconbox widget
myiconbox = widget({ type = "textbox", name = "myiconbox", align = "left" })
myiconbox.text = "<bg image=\"/usr/share/awesome/icons/awesome16.png\" resize=\"true\"/>"

-- Create a systray
mysystray = widget({ type = "systray", name = "mysystray", align = "right" })

-- Create an iconbox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = widget({ type = "textbox", name = "mylayoutbox", align = "right" })
    mylayoutbox[s]:mouse_add(mouse({ }, 1, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 3, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 4, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 5, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s].text = "<bg image=\"/usr/share/awesome/icons/layouts/tilew.png\" resize=\"true\"/>"
end

-- Create a statusbar for each screen and add it
mystatusbar = {}
for s = 1, screen.count() do
    mystatusbar[s] = statusbar({ position = "top", name = "mystatusbar" .. s,
                                   fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    mystatusbar[s].widgets =
    {
    	sep_left,
        mytaglist,
	sep_left,
	
	sep_l_left,
        vol_tb,
	sep_b_left,
	mpd_tb,
	sep_b_left,
	wifi_tb,
	sep_r_left,

	sep_left,
        mypromptbox,
	sep_right,

	sep_l_right,
	cpu_tb,
	sep_b_right,
	mem_tb,
	sep_b_right,
	hdd_tb,
	sep_b_right,
	bat_tb,
	sep_b_right,
	email_tb,
	sep_r_right,

	sep_right,
	sep_right,
	sep_right,
	clock_tb,

        mylayoutbox[s],
        s == screen.count() and mysystray or nil
    }
    mystatusbar[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
awesome.mouse_add(mouse({ }, 3, function () awful.spawn(terminal) end))
awesome.mouse_add(mouse({ }, 4, awful.tag.viewnext))
awesome.mouse_add(mouse({ }, 5, awful.tag.viewprev))
-- }}}

-- {{{ Key bindings

-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    keybinding({ modkey }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding({ modkey, "Control" }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding({ modkey, "Shift" }, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.movetotag(tags[sel.screen][i])
                           end
                       end
                   end):add()
    keybinding({ modkey, "Control", "Shift" }, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.toggletag(tags[sel.screen][i])
                           end
                       end
                   end):add()
end

keybinding({ modkey }, "Left", awful.tag.viewprev):add()
keybinding({ modkey }, "Right", awful.tag.viewnext):add()
keybinding({ modkey }, "Escape", awful.tag.history.restore):add()

-- Standard program
keybinding({ modkey }, "x", function () awful.spawn(terminal) end):add()
keybinding({ modkey }, "f", function () awful.spawn("firefox") end):add()

keybinding({ modkey, "Control" }, "r", awesome.restart):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()

-- Client manipulation
keybinding({ modkey }, "m", awful.client.maximize):add()
keybinding({ modkey, "Shift" }, "c", function () client.focus:kill() end):add()
keybinding({ modkey }, "j", function () awful.client.focusbyidx(1); client.focus:raise() end):add()
keybinding({ modkey }, "k", function () awful.client.focusbyidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Shift" }, "j", function () awful.client.swap(1) end):add()
keybinding({ modkey, "Shift" }, "k", function () awful.client.swap(-1) end):add()
keybinding({ modkey, "Control" }, "j", function () awful.screen.focus(1) end):add()
keybinding({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end):add()
keybinding({ modkey, "Control" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Control" }, "Return", function () client.focus:swap(awful.client.master()) end):add()
keybinding({ modkey }, "o", awful.client.movetoscreen):add()
keybinding({ modkey }, "Tab", awful.client.focus.history.previous):add()

-- Layout manipulation
keybinding({ modkey }, "l", function () awful.tag.incmwfact(0.05) end):add()
keybinding({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end):add()
keybinding({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1) end):add()
keybinding({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end):add()
keybinding({ modkey, "Control" }, "h", function () awful.tag.incncol(1) end):add()
keybinding({ modkey, "Control" }, "l", function () awful.tag.incncol(-1) end):add()
keybinding({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()

-- Prompt
keybinding({ modkey }, "Return", function ()
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox, awful.spawn, awful.completion.bash,
os.getenv("HOME") .. "/.cache/awesome_history") end):add()
keybinding({ modkey }, "F4", function ()
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox, awful.eval, awful.prompt.bash,
os.getenv("HOME") .. "/.cache/awesome_history_eval") end):add()
keybinding({ modkey, "Ctrl" }, "i", function ()
                                        if mypromptbox.text then
                                            mypromptbox.text = nil
                                        else
                                            mypromptbox.text = "Class: " .. client.focus.class .. " Instance: ".. client.focus.instance
                                        end
                                    end):add()

--- Tabulous, tab manipulation
keybinding({ modkey, "Control" }, "y", function ()
    local tabbedview = tabulous.tabindex_get()
    local nextclient = awful.client.next(1)

    if not tabbedview then
        tabbedview = tabulous.tabindex_get(nextclient)

        if not tabbedview then
            tabbedview = tabulous.tab_create()
            tabulous.tab(tabbedview, nextclient)
        else
            tabulous.tab(tabbedview, client.focus)
        end
    else
        tabulous.tab(tabbedview, nextclient)
    end
end):add()

keybinding({ modkey, "Shift" }, "y", tabulous.untab):add()

keybinding({ modkey }, "y", function ()
   local tabbedview = tabulous.tabindex_get()

   if tabbedview then
       local n = tabulous.next(tabbedview)
       tabulous.display(tabbedview, n)
   end
end):add()

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()
keybinding({ modkey, 'Shift' }, "t", function ()
    local tabbedview = tabulous.tabindex_get()
    local clients = awful.client.getmarked()

    if not tabbedview then
        tabbedview = tabulous.tab_create(clients[1])
        table.remove(clients, 1)
    end

    for k,c in pairs(clients) do
        tabulous.tab(tabbedview, c)
    end

end):add()

for i = 1, keynumber do
    keybinding({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
function hook_focus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end

-- Hook function to execute when marking a client
function hook_marked(c)
    c.border_color = beautiful.border_marked
end

-- Hook function to execute when unmarking a client
function hook_unmarked(c)
    c.border_color = beautiful.border_focus
end

-- Hook function to execute when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier" then
        client.focus = c
    end
end

-- Hook function to execute when a new client appears.
function hook_manage(c)
    -- Set floating placement to be smart!
    c.floating_placement = "smart"
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:mouse_add(mouse({ }, 1, function (c) client.focus = c; c:raise() end))
    c:mouse_add(mouse({ modkey }, 1, function (c) c:mouse_move() end))
    c:mouse_add(mouse({ modkey }, 3, function (c) c:mouse_resize() end))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Honor size hints
    c.honorsizehints = false
end

-- Hook function to execute when arranging the screen
-- (tag switch, new client, etc)
function hook_arrange(screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].text =
            "<bg image=\"/usr/share/awesome/icons/layouts/" .. awful.layout.get(screen) .. "w.png\" resize=\"true\"/>"
        else
            mylayoutbox[screen].text = "No layout."
    end

    -- If no window has focus, give focus to the latest in history
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    local sel = client.focus
    if sel then
        local c_c = sel.coords
        local m_c = mouse.coords

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords = { x = c_c.x + 5, y = c_c.y + 5}
            end
        end
    end
    ]]
end

-- Set up some hooks
awful.hooks.focus.register(hook_focus)
awful.hooks.unfocus.register(hook_unfocus)
awful.hooks.marked.register(hook_marked)
awful.hooks.unmarked.register(hook_unmarked)
awful.hooks.manage.register(hook_manage)
awful.hooks.mouseover.register(hook_mouseover)
awful.hooks.arrange.register(hook_arrange)
-- }}}
