-- Include awesome libraries, with lots of useful function!
require("awful")
require("beautiful")
require("naughty")

-- {{{ Variable definitions
-- This is a file path to a theme file which will defines colors.
theme_path = "/home/mihairu/.config/awesome/theme"
color_sep = "#ff0000"

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

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
    "fairh",
    "fairv",
    "magnifier",
    "max",
    "fullscreen",
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
    ["psi"] = true,
    ["skype"] = true,
    ["gimp"] = true,
    ["Wine"] = true,
    ["utorrent.exe"] = false,
    -- by instance
    ["mocp"] = true,
    ["rozvrh"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
     ["Firefox"] = { screen = 1, tag = 1 },
     ["psi"] = { screen = 1, tag = 4 },
     ["Skype"] = { screen = 1, tag = 4 },
     ["emacs"] = { screen = 1, tag = 3 },
     ["ted.TedMain"] = { screen = 1, tag = 5 },
     ["utorrent.exe"] = { screen = 1, tag = 5 },
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
tags[1][6] = tag({ name = "6:emul" })

for tagnumber = 1, 6 do 
    tags[1][tagnumber].mwfact = 0.618033988769
    tags[1][tagnumber].screen = 1 
end
tags[1][1].selected = true
-- }}}

-- {{{ Statusbar
-- Create a taglist widget
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }

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
vol_tb:buttons({ button({ }, 1, function () awful.spawn("exec amixer sset PCM 5%+ >/dev/null") end),
		button({ }, 2, function () awful.spawn("exec amixer sset PCM toggle >/dev/null") end),
		button({ }, 3, function () awful.spawn("exec amixer sset PCM 5%- >/dev/null") end)})
vol_tb.text = "vol: 0%|off"
-- Widget MPD   {{{
mpd_tb = widget({ type = "textbox", name = "mpd_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
mpd_tb.text = "mpd: []: not playing"
-- Widget Compilation
compil_tb = widget({ type = "textbox", name = "compil_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
compil_tb.text = "no compiling"
-- Widget Wifi   {{{
wifi_tb = widget({ type = "textbox", name = "wifi_tb", align = "left", fg = "#cccccc", shadow = "#111111", shadow_offset = "1" })
wifi_tb.text = "no connection"
-- }}}
-- Widget CPU   {{{
cpu_tb = widget({ type = "textbox", name = "cpu_tb", align = "right"})
cpu_tb.text = "cpu: 0%|0%"
-- }}}
-- Widget Memory+Swap   {{{
mem_tb = widget({ type = "textbox", name = "mem_tb", align = "right"})
mem_tb.text = "mem: 0%|0%"
-- }}}
-- Widget HDD   {{{
hdd_tb = widget({ type = "textbox", name = "hdd_tb", align = "right"})
hdd_tb.text = "hdd: 0%|0%|0%"
-- }}}
-- Widget Battery   {{{
bat_tb = widget({ type = "textbox", name = "bat_tb", align = "right"})
bat_tb.text = "bat: =|0%"
-- }}}
-- Widget Email   {{{
email_tb = widget({ type = "textbox", name = "email_tb", align = "right"})
email_tb.text = "no mail"
-- }}}
-- Widget Clock   {{{
clock_tb = widget({ type = "textbox", name = "clock_tb", align = "right"})
clock_tb.width = "130"
-- }}}
-- Create an iconbox widget
myiconbox = widget({ type = "textbox", name = "myiconbox", align = "left" })
myiconbox.text = "<bg image=\"/usr/share/awesome/icons/awesome16.png\" resize=\"true\"/>"


-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mylayoutbox = {}
mypromptbox = {}
mywibox = {}

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
    	sep_left,
        mytaglist,
	sep_left,

	sep_l_left,
        vol_tb,
	sep_b_left,
	mpd_tb,
	sep_b_left,
	wifi_tb,
	sep_b_left,
	compil_tb,
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
        s == 1 and mysystray or nil }
    mywibox[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
awesome.buttons({
    button({ }, 4, awful.tag.viewnext),
    button({ }, 5, awful.tag.viewprev)
})
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
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.movetotag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
    keybinding({ modkey, "Control", "Shift" }, i,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.toggletag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
end

keybinding({ modkey }, "Left", awful.tag.viewprev):add()
keybinding({ modkey }, "Right", awful.tag.viewnext):add()
keybinding({ modkey }, "Escape", awful.tag.history.restore):add()

-- Standard program
keybinding({ modkey }, "x", function () awful.util.spawn(terminal) end):add()
keybinding({ modkey }, "f", function () awful.util.spawn("firefox") end):add()
keybinding({ modkey }, "e", function () awful.util.spawn("emacs") end):add()

keybinding({ modkey, "Control" }, "r", function ()
                                           mypromptbox[mouse.screen].text =
                                               awful.util.escape(awful.util.restart())
                                        end):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()

-- Client manipulation
keybinding({ modkey }, "m", awful.client.maximize):add()
--keybinding({ modkey }, "f", function () client.focus.fullscreen = not client.focus.fullscreen end):add()
keybinding({ modkey, "Shift" }, "c", function () client.focus:kill() end):add()
keybinding({ modkey }, "j", function () awful.client.focus.byidx(1); client.focus:raise() end):add()
keybinding({ modkey }, "k", function () awful.client.focus.byidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end):add()
keybinding({ modkey, "Shift" }, "k", function () awful.client.swap(-1) end):add()
keybinding({ modkey, "Control" }, "j", function () awful.screen.focus(1) end):add()
keybinding({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end):add()
keybinding({ modkey, "Control" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Control" }, "Return", function () client.focus:swap(awful.client.getmaster()) end):add()
keybinding({ modkey }, "o", awful.client.movetoscreen):add()
keybinding({ modkey }, "Tab", awful.client.focus.history.previous):add()
keybinding({ modkey }, "u", awful.client.urgent.jumpto):add()
keybinding({ modkey, "Shift" }, "r", function () client.focus:redraw() end):add()

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
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox[mouse.screen], awful.util.spawn, awful.completion.bash,
                                                  awful.util.getdir("cache") .. "/history")
                             end):add()

keybinding({ modkey }, "s", function ()
        awful.prompt.run({ prompt = "ssh to: " },
        mypromptbox[mouse.screen],
        function(h)
                awful.util.spawn(terminal .. " -e ssh " .. h)
        end,
        function(cmd, cur_pos, ncomp)
                -- get the hosts
                local hosts = {}
                for host in io.open(os.getenv("HOME") .. "/.ssh/config"):read("*all"):gmatch("Host (%w+)") do
                        table.insert(hosts, host)
                end
                -- abort completion under certain circumstances
                if #cmd == 0 or (cur_pos ~= #cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " ") then
                        return cmd, cur_pos
                end
                -- match
                local matches = {}
                table.foreach(hosts, function(x)
                        if hosts[x]:find("^" .. cmd:sub(1,cur_pos)) then
                                table.insert(matches, hosts[x])
                        end
                end)
                -- if there are no matches
                if #matches == 0 then
                        return
                end
                -- cycle
                while ncomp > #matches do
                        ncomp = ncomp - #matches
                end
                -- return match and position
                return matches[ncomp], cur_pos
        end,
        awful.util.getdir("cache") .. "/ssh_history")
end):add()


keybinding({ modkey }, "F4", function ()
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox[mouse.screen], awful.util.eval, awful.prompt.bash,
                                                  awful.util.getdir("cache") .. "/history_eval")
                             end):add()

keybinding({ modkey, "Ctrl" }, "i", function ()
                                        local s = mouse.screen
                                        if mypromptbox[s].text then
                                            mypromptbox[s].text = nil
                                        elseif client.focus then
                                            mypromptbox[s].text = nil
                                            if client.focus.class then
                                                mypromptbox[s].text = "Class: " .. client.focus.class .. " "
                                            end
                                            if client.focus.instance then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Instance: ".. client.focus.instance .. " "
                                            end
                                            if client.focus.role then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Role: ".. client.focus.role
                                            end
                                        end
                                    end):add()

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()

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
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier"
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c)
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
        button({ modkey }, 1, function (c) c:mouse_move() end),
        button({ modkey }, 3, function (c) c:mouse_resize() end)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

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

    client.focus = c

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.honorsizehints = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    if client.focus then
        local c_c = client.focus:fullgeometry()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
end)

-- Hook called every second
loadfile(awful.util.getdir("config").."/functions.lua")()
-- init of functions
emailInfo()
wifiInfo()
compilInfo()
cpuInfo()
memInfo()
hddInfo()
batInfo()
mpdInfo()
clockInfo()
volInfo()


awful.hooks.timer.register(1, function ()
	clockInfo()
end)

awful.hooks.timer.register(5, function ()
	volInfo()
end)

awful.hooks.timer.register(10, function ()
	wifiInfo()
	compilInfo()
	cpuInfo()
	memInfo()
	hddInfo()
	batInfo()
	mpdInfo()
end)

awful.hooks.timer.register(120, function ()
	emailInfo()
end)
-- }}}
