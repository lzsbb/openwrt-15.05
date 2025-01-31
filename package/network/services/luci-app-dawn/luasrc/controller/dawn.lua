module("luci.controller.dawn", package.seeall)

function index()
    entry({ "admin", "dawn" }, firstchild(), "DAWN", 60).dependent = false

    entry({ "admin", "dawn", "view_network" }, cbi("dawn/dawn_network"), "View Network Overview", 1)
    entry({ "admin", "dawn", "view_hearing_map" }, cbi("dawn/dawn_hearing_map"), "View Hearing Map", 2)
end
