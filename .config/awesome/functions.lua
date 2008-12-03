function emailInfo() 
	local f = io.popen('/home/mihairu/scripts/email.py')
	local l = f:read()
	f:close()
	email_tb.text = l
end

function cpuInfo()
	local f = io.popen('/home/mihairu/scripts/cpuusage.py')
       	local l = f:read()
        f:close()
	cpu_tb.text = l
end

function memInfo()
	local f = io.popen('/home/mihairu/scripts/memswap.py')
        local l = f:read()
	f:close()
	mem_tb.text = l
end

function batInfo()
	local f = io.popen('/home/mihairu/scripts/battery.py')
       	local l = f:read()
        f:close()
	bat_tb.text =  l
end

function hddInfo()
	local f = io.popen('/home/mihairu/scripts/filesystem.py')
	local l = f:read()
	f:close()
	hdd_tb.text = l
end

function volInfo()
	local f = io.popen('/home/mihairu/scripts/volume.py')
	local l = f:read()
	f:close()
	vol_tb.text = l
end

function mpdInfo()
	local f = io.popen('/home/mihairu/scripts/mpd.py')
	local l = f:read()
	f:close()
	mpd_tb.text= l

end

function compilInfo()
	local f = io.popen('sudo /usr/local/bin/eprogress2')
	local l = f:read()
	f:close()
	compil_tb.text = l
end

function wifiInfo()
	local f = io.popen('/home/mihairu/scripts/wifi.py')
	local l = f:read()
	f:close()
	wifi_tb.text = l
end

function clockInfo() 
	local f = io.popen('/home/mihairu/scripts/datetime.py')
	local l = f:read()
	f:close()
	clock_tb.text = l

end
