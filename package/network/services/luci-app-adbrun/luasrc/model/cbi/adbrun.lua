m = Map("adbrun", translate("adb server."))

s = m:section(TypedSection, "adbrun", "", translate("Assistant for automatic control android devices."))

s:tab("adb_set", translate("basic"))

s.anonymous = false
s.addremove = true

adbclient=s:taboption("adb_set",Value, "adbclient", translate("adb client name"))
adbclient.rmempty = true
adbclient.datatype = "or(ipaddr, network)"

adbiplist=s:taboption("adb_set",Value, "adbiplist", translate("IP address")) 
adbiplist.rmempty = true
adbiplist.datatype = "ipaddr"
luci.sys.net.ipv4_hints(function(ip, name)
	adbiplist:value(ip, "%s (%s)" %{ ip, name })
end)

adbconnect=s:taboption("adb_set",Button,"adbconnect",translate("Connect client"))
adbconnect.rmempty = true
adbconnect.inputstyle = "apply"
function adbconnect.write(self, section)
	local adbconnectip = luci.util.exec("adb connect $(uci get adbrun."..section..".adbiplist)")
--	local testconnect = luci.util.exec("adb devices | grep -i "..section)
--	if testconnect == "" then
--		luci.util.exec("logger Connection failed: Please connect the computer with USB cable. ")
--		luci.util.exec("logger Run: adb tcpip 5555 ")
--	else
--		luci.util.exec("logger Successful: "..adbconnectip)
--	end
end

adbcommandlist = s:taboption("adb_set", ListValue, "adbcommandlist", translate("command list"), translate("adbrun command list"))
adbcommandlist.placeholder = "none"
adbcommandlist:value("none", translate("none"))
adbcommandlist:value("turn-offon-the-screen", translate("Turn off/on the screen"))
adbcommandlist:value("turn-on-the-screen", translate("Turn on screen"))
adbcommandlist:value("playback", translate("Playback audio"))
adbcommandlist:value("pause-playback", translate("Pause audio"))
adbcommandlist:value("mute", translate("Mute on/off"))
adbcommandlist:value("appactivity", translate("Get running APP"))
adbcommandlist:value("runxmlylite", translate("Run ximalaya lite version"))
adbcommandlist:value("pyxmlylite", translate("Automatically get gold coins from ximalaya lite version"))
adbcommandlist.default     = "none"
adbcommandlist.rempty      = false
adbplay=s:taboption("adb_set",Button, "adbplay", translate("Play")) 
adbplay.rmempty = true
adbplay.inputstyle = "apply"
function adbplay.write(self, section)
	luci.util.exec("cp /usr/adbrun/adbcommand.sh /tmp/adb_" ..section.. "_.sh")
	luci.util.exec("/tmp/adb_" ..section.. "_.sh")
end

return m
