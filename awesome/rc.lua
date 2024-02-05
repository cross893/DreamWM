-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

do
    local cmds =
    {
        "setxkbmap -layout \"us,ru\" -option \"grp:alt_shift_toggle\"",
    }

    for _,i in pairs(cmds) do
        awful.util.spawn(i)
    end
end

-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("vim") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart awesome", awesome.restart },
    { "quit awesome", function() awesome.quit() end },
    { "reboot", "reboot" },
    { "shutdown", "shutdown now" },
}
standartmenu = {
    { "chromium", "chromium" },
    { "firefox", "firefox" },
    { "explorer", "nemo" },
    { "ranger", terminal .. " -e ranger" },
}
optionsmenu = {
    { "wi-fi", terminal .. " -e iwctl" },
}
termmenu = {
    { "kitty", terminal },
    { "term (grey)", "xterm -bg black -fg grey bash" },
    { "term (red)", "xterm -bg black -fg red bash" },
    { "term (green)", "xterm -bg black -fg green bash" },
    { "term (yellow)", "xterm -bg black -fg yellow bash" },
    { "term (white)", "xterm -bg black -fg white bash" }
}

antiforensicmenu = {
  { "ropeadope", "kitty -e sh -c 'ropeadope ; bash'" },
  { "saruman", "kitty -e sh -c 'saruman ; bash'" },
  { "sdel", "kitty -e sh -c 'sdel -h ; bash'" },
  { "sfill", "kitty -e sh -c 'sfill -h ; bash'" },
  { "smem-secure-delete", "kitty -e sh -c 'smem-secure-delete -h ; bash'" },
  { "srm", "kitty -e sh -c 'srm -h ; bash'" },
  { "sswap", "kitty -e sh -c 'sswap -h ; bash'" },
  { "steghide", "kitty -e sh -c 'steghide --help ; bash'" },
  { "zsteg", "kitty -e sh -c 'zsteg -h ; bash'" },
  { "zsteg-mask", "kitty -e sh -c 'zsteg-mask ; bash'" },
  { "zsteg-reflow", "kitty -e sh -c 'zsteg-reflow ; bash'" },
}
automationmenu1 = {
  { "airgeddon", "kitty -e sh -c 'airgeddon ; bash'" },
  { "apt2", "kitty -e sh -c 'apt2 -h ; bash'" },
  { "armitage", "kitty -e sh -c 'armitage -h ; bash'" },
  { "teamserver", "kitty -e sh -c 'teamserver ; bash'" },
  { "armscgen", "kitty -e sh -c 'armscgen -h ; bash'" },
  { "atscan", "kitty -e sh -c 'atscan ; bash'" },
  { "automato", "kitty -e sh -c 'automato ; bash'" },
  { "autonessus", "kitty -e sh -c 'autonessus -h ; bash'" },
  { "autonse", "kitty -e sh -c 'autonse ; bash'" },
  { "autopwn", "kitty -e sh -c 'autopwn -h ; bash'" },
  { "autopwn-cli", "kitty -e sh -c 'autopwn-cli ; bash'" },
  { "autorecon", "kitty -e sh -c 'autorecon -h ; bash'" },
  { "autovpn", "kitty -e sh -c 'autovpn ; bash'" },
  { "avet", "kitty -e sh -c 'avet ; bash'" },
  { "awsbucketdump", "kitty -e sh -c 'awsbucketdump -h ; bash'" },
  { "backdoorme", "kitty -e sh -c 'backdoorme ; bash'" },
  { "barq", "kitty -e sh -c 'barq -h ; bash'" },
  { "binex", "kitty -e sh -c 'binex -h ; bash'" },
  { "blueranger", "kitty -e sh -c 'blueranger ; bash'" },
  { "brutespray", "kitty -e sh -c 'brutespray -h ; bash'" },
}
automationmenu2 = {
  { "brutex", "kitty -e sh -c 'brutex ; bash'" },
  { "brutex-masscan", "kitty -e sh -c 'brutex-masscan ; bash'" },
  { "byepass", "kitty -e sh -c 'byepass -h ; bash'" },
  { "passtime", "kitty -e sh -c 'passtime -h ; bash'" },
  { "cewl", "kitty -e sh -c 'cewl -h ; bash'" },
  { "cewl-fab", "kitty -e sh -c 'cewl-fab ; bash'" },
  { "checksec", "kitty -e sh -c 'checksec --help ; bash'" },
  { "cisco-snmp-enumeration", "kitty -e sh -c 'cisco-snmp-enumeration ; bash'" },
  { "acorn", "kitty -e sh -c 'acorn ; bash'" },
  { "uuid", "kitty -e sh -c 'uuid ; bash'" },
  { "zuul-es5.yml", "kitty -e sh -c 'zuul-es5.yml ; bash'" },
  { "zuul-es6.yml", "kitty -e sh -c 'zuul-es6.yml ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
  { "he", "kitty -e sh -c 'he ; bash'" },
  { "jsesc", "kitty -e sh -c 'jsesc ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
  { "_mocha", "kitty -e sh -c '_mocha ; bash'" },
  { "mocha", "kitty -e sh -c 'mocha ; bash'" },
  { "uuid", "kitty -e sh -c 'uuid ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
}
automationmenu3 = {
  { "uuid", "kitty -e sh -c 'uuid ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
  { "uuid", "kitty -e sh -c 'uuid ; bash'" },
  { "resolve", "kitty -e sh -c 'resolve ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
  { "uuid", "kitty -e sh -c 'uuid ; bash'" },
  { "vm2", "kitty -e sh -c 'vm2 ; bash'" },
  { "acorn", "kitty -e sh -c 'acorn ; bash'" },
  { "which", "kitty -e sh -c 'which ; bash'" },
  { "semver", "kitty -e sh -c 'semver ; bash'" },
  { "clusterd", "kitty -e sh -c 'clusterd -h ; bash'" },
  { "cmsmap", "kitty -e sh -c 'cmsmap -h ; bash'" },
  { "codeql", "kitty -e sh -c 'codeql ; bash'" },
  { "java", "kitty -e sh -c 'java ; bash'" },
  { "javac", "kitty -e sh -c 'javac ; bash'" },
  { "keytool", "kitty -e sh -c 'keytool ; bash'" },
  { "rmid", "kitty -e sh -c 'rmid ; bash'" },
  { "rmiregistry", "kitty -e sh -c 'rmiregistry ; bash'" },
  { "serialver", "kitty -e sh -c 'serialver ; bash'" },
  { "tsc", "kitty -e sh -c 'tsc ; bash'" },
}
automationmenu3 = {
  { "tsserver", "kitty -e sh -c 'tsserver ; bash'" },
  { "java", "kitty -e sh -c 'java ; bash'" },
  { "javac", "kitty -e sh -c 'javac ; bash'" },
  { "keytool", "kitty -e sh -c 'keytool ; bash'" },
  { "rmiregistry", "kitty -e sh -c 'rmiregistry ; bash'" },
  { "serialver", "kitty -e sh -c 'serialver ; bash'" },
  { "commix", "kitty -e sh -c 'commix ; bash'" },
  { "commonspeak", "kitty -e sh -c 'commonspeak -h ; bash'" },
  { "cook", "kitty -e sh -c 'cook -h ; bash'" },
  { "crunch", "kitty -e sh -c 'crunch -h ; bash'" },
  { "darkspiritz", "kitty -e sh -c 'darkspiritz -h ; bash'" },
  { "deathstar", "kitty -e sh -c 'deathstar -h ; bash'" },
  { "domained", "kitty -e sh -c 'domained -h ; bash'" },
  { "dorknet", "kitty -e sh -c 'dorknet -h ; bash'" },
  { "dorkscout", "kitty -e sh -c 'dorkscout -h ; bash'" },
  { "dracnmap", "kitty -e sh -c 'dracnmap ; bash'" },
  { "dracnmap-drac0s", "kitty -e sh -c 'dracnmap-drac0s ; bash'" },
  { "dumb0", "kitty -e sh -c 'dumb0 -h ; bash'" },
  { "easy-creds", "kitty -e sh -c 'easy-creds ; bash'" },
  { "easyda", "kitty -e sh -c 'easyda ; bash'" },
}
automationmenu4 = {
  { "emp3r0r", "kitty -e sh -c 'emp3r0r -h ; bash'" },
  { "empire-client", "kitty -e sh -c 'empire-client ; bash'" },
  { "empire-server", "kitty -e sh -c 'empire-server ; bash'" },
  { "faraday-manage", "kitty -e sh -c 'faraday-manage ; bash'" },
  { "faraday-server", "kitty -e sh -c 'faraday-server ; bash'" },
  { "firstorder", "kitty -e sh -c 'firstorder -h ; bash'" },
  { "fstealer", "kitty -e sh -c 'fstealer -h ; bash'" },
  { "gitdump", "kitty -e sh -c 'gitdump ; bash'" },
  { "githubcloner", "kitty -e sh -c 'githubcloner -h ; bash'" },
  { "glue", "kitty -e sh -c 'glue -h ; bash'" },
  { "goohak", "kitty -e sh -c 'goohak ; bash'" },
  { "gooscan", "kitty -e sh -c 'gooscan -h ; bash'" },
  { "harpoon", "kitty -e sh -c 'harpoon -h ; bash'" },
  { "hate-crack", "kitty -e sh -c 'hate-crack ; bash'" },
  { "iloscan", "kitty -e sh -c 'iloscan ; bash'" },
  { "intersect-create", "kitty -e sh -c 'intersect-create ; bash'" },
  { "inurlbr", "kitty -e sh -c 'inurlbr -h ; bash'" },
  { "ipmipwn", "kitty -e sh -c 'ipmipwn ; bash'" },
  { "jaidam", "kitty -e sh -c 'jaidam ; bash'" },
  { "unix-jboss-autopwn", "kitty -e sh -c 'unix-jboss-autopwn ; bash'" },
}
automationmenu5 = {
  { "win-jboss-autopwn", "kitty -e sh -c 'win-jboss-autopwn ; bash'" },
  { "kernelpop", "kitty -e sh -c 'kernelpop -h ; bash'" },
  { "killcast", "kitty -e sh -c 'killcast -h ; bash'" },
  { "koadic", "kitty -e sh -c 'koadic ; bash'" },
  { "dynwrapx.manifest", "kitty -e sh -c 'dynwrapx.manifest ; bash'" },
  { "lazydroid", "kitty -e sh -c 'lazydroid ; bash'" },
  { "ldapaddgroup", "kitty -e sh -c 'ldapaddgroup -h ; bash'" },
  { "ldapaddmachine", "kitty -e sh -c 'ldapaddmachine -h ; bash'" },
  { "ldapadduser", "kitty -e sh -c 'ldapadduser -h ; bash'" },
  { "ldapaddusertogroup", "kitty -e sh -c 'ldapaddusertogroup -h ; bash'" },
  { "ldapdeletegroup", "kitty -e sh -c 'ldapdeletegroup -h ; bash'" },
  { "ldapdeletemachine", "kitty -e sh -c 'ldapdeletemachine -h ; bash'" },
  { "ldapdeleteuser", "kitty -e sh -c 'ldapdeleteuser -h ; bash'" },
  { "ldapdeleteuserfromgroup", "kitty -e sh -c 'ldapdeleteuserfromgroup -h ; bash'" },
  { "ldapfinger", "kitty -e sh -c 'ldapfinger -h ; bash'" },
  { "ldapgid", "kitty -e sh -c 'ldapgid -h ; bash'" },
  { "ldapid", "kitty -e sh -c 'ldapid -h ; bash'" },
  { "ldapinit", "kitty -e sh -c 'ldapinit -h ; bash'" },
  { "ldapmodifygroup", "kitty -e sh -c 'ldapmodifygroup -h ; bash'" },
  { "ldapmodifymachine", "kitty -e sh -c 'ldapmodifymachine -h ; bash'" },
}
automationmenu6 = {
  { "ldapmodifyuser", "kitty -e sh -c 'ldapmodifyuser -h ; bash'" },
  { "ldaprenamegroup", "kitty -e sh -c 'ldaprenamegroup -h ; bash'" },
  { "ldaprenamemachine", "kitty -e sh -c 'ldaprenamemachine -h ; bash'" },
  { "ldaprenameuser", "kitty -e sh -c 'ldaprenameuser -h ; bash'" },
  { "lsldap", "kitty -e sh -c 'lsldap -h ; bash'" },
  { "legion", "kitty -e sh -c 'legion -h ; bash'" },
  { "linikatz", "kitty -e sh -c 'linikatz ; bash'" },
  { "linset", "kitty -e sh -c 'linset ; bash'" },
  { "lyricpass", "kitty -e sh -c 'lyricpass -h ; bash'" },
  { "maskprocessor", "kitty -e sh -c 'maskprocessor -h ; bash'" },
  { "massbleed", "kitty -e sh -c 'massbleed ; bash'" },
  { "masscan-automation", "kitty -e sh -c 'masscan-automation -h ; bash'" },
  { "massexpconsole", "kitty -e sh -c 'massexpconsole ; bash'" },
  { "mentalist", "kitty -e sh -c 'mentalist ; bash'" },
  { "merlin-server", "kitty -e sh -c 'merlin-server -h ; bash'" },
  { "mitmap-old", "kitty -e sh -c 'mitmap-old -h ; bash'" },
  { "morpheus", "kitty -e sh -c 'morpheus ; bash'" },
  { "etter.dns", "kitty -e sh -c 'etter.dns ; bash'" },
  { "http.lua", "kitty -e sh -c 'http.lua ; bash'" },
  { "warn.ogg", "kitty -e sh -c 'warn.ogg ; bash'" },
}
automationmenu7 = {
  { "msf-mpc", "kitty -e sh -c 'msf-mpc -h ; bash'" },
  { "msfenum", "kitty -e sh -c 'msfenum -h ; bash'" },
  { "multiscanner", "kitty -e sh -c 'multiscanner -h ; bash'" },
  { "multiscanner-api", "kitty -e sh -c 'multiscanner-api ; bash'" },
  { "multiscanner-web", "kitty -e sh -c 'multiscanner-web ; bash'" },
  { "mutator", "kitty -e sh -c 'mutator -h ; bash'" },
  { "nettacker", "kitty -e sh -c 'nettacker -h ; bash'" },
  { "nosqlattack", "kitty -e sh -c 'nosqlattack ; bash'" },
  { "nullscan", "kitty -e sh -c 'nullscan -H ; bash'" },
  { "autotailor", "kitty -e sh -c 'autotailor ; bash'" },
  { "oscap", "kitty -e sh -c 'oscap -h ; bash'" },
  { "oscap-chroot", "kitty -e sh -c 'oscap-chroot -h ; bash'" },
  { "oscap-docker", "kitty -e sh -c 'oscap-docker -h ; bash'" },
  { "oscap-podman", "kitty -e sh -c 'oscap-podman -h ; bash'" },
  { "oscap-remediate-offline", "kitty -e sh -c 'oscap-remediate-offline ; bash'" },
  { "oscap-run-sce-script", "kitty -e sh -c 'oscap-run-sce-script ; bash'" },
  { "oscap-vm", "kitty -e sh -c 'oscap-vm -h ; bash'" },
  { "scap-as-rpm", "kitty -e sh -c 'scap-as-rpm -h ; bash'" },
  { "osslsigncode", "kitty -e sh -c 'osslsigncode -h ; bash'" },
  { "owtf", "kitty -e sh -c 'owtf ; bash'" },
}
automationmenu8 = {
  { "panoptic", "kitty -e sh -c 'panoptic -h ; bash'" },
  { "pastejacker", "kitty -e sh -c 'pastejacker ; bash'" },
  { "pastemonitor", "kitty -e sh -c 'pastemonitor -h ; bash'" },
  { "pasv-agrsv", "kitty -e sh -c 'pasv-agrsv -h ; bash'" },
  { "penbox", "kitty -e sh -c 'penbox ; bash'" },
  { "pentestly", "kitty -e sh -c 'pentestly -h ; bash'" },
  { "pentmenu", "kitty -e sh -c 'pentmenu ; bash'" },
  { "phemail", "kitty -e sh -c 'phemail -h ; bash'" },
  { "pin", "kitty -e sh -c 'pin ; bash'" },
  { "pindb", "kitty -e sh -c 'pindb ; bash'" },
  { "pindb.sig", "kitty -e sh -c 'pindb.sig ; bash'" },
  { "pindb", "kitty -e sh -c 'pindb ; bash'" },
  { "pindb.sig", "kitty -e sh -c 'pindb.sig ; bash'" },
  { "pmcma", "kitty -e sh -c 'pmcma ; bash'" },
  { "portia", "kitty -e sh -c 'portia ; bash'" },
  { "ptf", "kitty -e sh -c 'ptf ; bash'" },
  { "pureblood", "kitty -e sh -c 'pureblood ; bash'" },
  { "pwndrop", "kitty -e sh -c 'pwndrop -h ; bash'" },
  { "pyfuscation", "kitty -e sh -c 'pyfuscation -h ; bash'" },
  { "arsenic-check-ie11", "kitty -e sh -c 'arsenic-check-ie11 ; bash'" },
}
automationmenu9 = {
  { "shodan", "kitty -e sh -c 'shodan ; bash'" },
  { "shodan2", "kitty -e sh -c 'shodan2 ; bash'" },
  { "recomposer", "kitty -e sh -c 'recomposer -h ; bash'" },
  { "rhodiola", "kitty -e sh -c 'rhodiola -h ; bash'" },
  { "rsmangler", "kitty -e sh -c 'rsmangler -h ; bash'" },
  { "sakis3g", "kitty -e sh -c 'sakis3g --help ; bash'" },
  { "sandmap", "kitty -e sh -c 'sandmap --help ; bash'" },
  { "sc-make", "kitty -e sh -c 'sc-make ; bash'" },
  { "scap-workbench", "kitty -e sh -c 'scap-workbench ; bash'" },
  { "search1337", "kitty -e sh -c 'search1337 ; bash'" },
  { "sharesniffer", "kitty -e sh -c 'sharesniffer -h ; bash'" },
  { "shellerator", "kitty -e sh -c 'shellerator -h ; bash'" },
  { "shellme", "kitty -e sh -c 'shellme -h ; bash'" },
  { "shellpop", "kitty -e sh -c 'shellpop -h ; bash'" },
  { "shellz", "kitty -e sh -c 'shellz -h ; bash'" },
  { "sign", "kitty -e sh -c 'sign ; bash'" },
  { "sipvicious-svcrack", "kitty -e sh -c 'sipvicious-svcrack -h ; bash'" },
  { "sipvicious-svmap", "kitty -e sh -c 'sipvicious-svmap -h ; bash'" },
  { "sipvicious-svreport", "kitty -e sh -c 'sipvicious-svreport -h ; bash'" },
  { "sipvicious-svwar", "kitty -e sh -c 'sipvicious-svwar -h ; bash'" },
}
automationmenu10 = {
  { "sn00p", "kitty -e sh -c 'sn00p ; bash'" },
  { "sn1per", "kitty -e sh -c 'sn1per ; bash'" },
  { "http-default-accounts-fingerprints-nndefaccts.lua", "kitty -e sh -c 'http-default-accounts-fingerprints-nndefaccts.lua ; bash'" },
  { "inurlbr.php", "kitty -e sh -c 'inurlbr.php ; bash'" },
  { "nmap-bootstrap.xsl", "kitty -e sh -c 'nmap-bootstrap.xsl ; bash'" },
  { "spookflare", "kitty -e sh -c 'spookflare ; bash'" },
  { "ssl-phuck3r", "kitty -e sh -c 'ssl-phuck3r -h ; bash'" },
  { "statsprocessor", "kitty -e sh -c 'statsprocessor --help ; bash'" },
  { "thefatrat", "kitty -e sh -c 'thefatrat cd /usr/share/thefatrat ; ls ; bash'" },
  { "tiger", "kitty -e sh -c 'tiger -h ; bash'" },
  { "tlssled", "kitty -e sh -c 'tlssled -h ; bash'" },
  { "torctl", "kitty -e sh -c 'torctl ; bash'" },
  { "traxss", "kitty -e sh -c 'traxss -h ; bash'" },
  { "ttpassgen", "kitty -e sh -c 'ttpassgen -h ; bash'" },
  { "unix-privsc-check", "kitty -e sh -c 'unix-privsc-check ; bash'" },
  { "username-anarchy", "kitty -e sh -c 'username-anarchy -h ; bash'" },
  { "usernamer", "kitty -e sh -c 'usernamer -h ; bash'" },
  { "valhalla-cli", "kitty -e sh -c 'valhalla-cli -h ; bash'" },
  { "vbsmin", "kitty -e sh -c 'vbsmin -h ; bash'" },
  { "veil", "kitty -e sh -c 'veil ; bash'" },
}
automationmenu11 = {
  { "vlan-hopping", "kitty -e sh -c 'vlan-hopping ; bash'" },
  { "voiphopper", "kitty -e sh -c 'voiphopper -h ; bash'" },
  { "wifi-autopwner", "kitty -e sh -c 'wifi-autopwner -h ; bash'" },
  { "wikigen", "kitty -e sh -c 'wikigen ; bash'" },
  { "wnmap", "kitty -e sh -c 'wnmap -h ; bash'" },
  { "xcat", "kitty -e sh -c 'xcat ; bash'" },
  { "yinjector", "kitty -e sh -c 'yinjector -h ; bash'" },
  { "zerapwn", "kitty -e sh -c 'zerapwn ; bash'" },
  { "zirikatu", "kitty -e sh -c 'zirikatu ; bash'" },
}
automationmenu = {
  { "1", automationmenu1 },
  { "2", automationmenu2 },
  { "3", automationmenu3 },
  { "4", automationmenu4 },
  { "5", automationmenu5 },
  { "6", automationmenu6 },
  { "7", automationmenu7 },
  { "8", automationmenu8 },
  { "9", automationmenu9 },
  { "10", automationmenu10 },
  { "11", automationmenu11 },
}
automobilemenu = {
  { "asc2log", "urxvt -e sh -c 'asc2log ; bash'" },
  { "bcmserver", "urxvt -e sh -c 'bcmserver ; bash'" },
  { "can-calc-bit-timing", "urxvt -e sh -c 'can-calc-bit-timing ; bash'" },
  { "canbusload", "urxvt -e sh -c 'canbusload ; bash'" },
  { "candump", "urxvt -e sh -c 'candump ; bash'" },
  { "canfdtest", "urxvt -e sh -c 'canfdtest ; bash'" },
  { "cangen", "urxvt -e sh -c 'cangen ; bash'" },
  { "cangw", "urxvt -e sh -c 'cangw ; bash'" },
  { "canlogserver", "urxvt -e sh -c 'canlogserver ; bash'" },
  { "cansend", "urxvt -e sh -c 'cansend ; bash'" },
  { "cansequence", "urxvt -e sh -c 'cansequence ; bash'" },
  { "cansniffer", "urxvt -e sh -c 'cansniffer ; bash'" },
  { "isotpdump", "urxvt -e sh -c 'isotpdump ; bash'" },
  { "isotpperf", "urxvt -e sh -c 'isotpperf ; bash'" },
  { "isotprecv", "urxvt -e sh -c 'isotprecv ; bash'" },
  { "isotptun", "urxvt -e sh -c 'isotptun ; bash'" },
  { "j1939acd", "urxvt -e sh -c 'j1939acd ; bash'" },
  { "j1939cat", "urxvt -e sh -c 'j1939cat ; bash'" },
  { "j1939sr", "urxvt -e sh -c 'j1939sr ; bash'" },
  { "log2asc", "urxvt -e sh -c 'log2asc ; bash'" },
  { "log2long", "urxvt -e sh -c 'log2long ; bash'" },
  { "mcp251xfd-dump", "urxvt -e sh -c 'mcp251xfd-dump ; bash'" },
  { "slcan_attach", "urxvt -e sh -c 'slcan_attach ; bash'" },
  { "slcand", "urxvt -e sh -c 'slcand ; bash'" },
  { "slcanpty", "urxvt -e sh -c 'slcanpty ; bash'" },
  { "testj1939", "urxvt -e sh -c 'testj1939 ; bash'" },
  { "canalyzat0r", "urxvt -e sh -c 'canalyzat0r ; bash'" },
  { "cantoolz", "urxvt -e sh -c 'cantoolz -h ; bash'" },
  { "udsim", "urxvt -e sh -c 'udsim -h ; bash'" },
}
backdoormenu1 = {
  { "arcane", "urxvt -e sh -c 'arcane -h ; bash'" },
  { "avet", "urxvt -e sh -c 'avet ; bash'" },
  { "backcookie", "urxvt -e sh -c 'backcookie -h ; bash'" },
  { "backdoor-factory", "urxvt -e sh -c 'backdoor-factory -h ; bash'" },
  { "backdoorme", "urxvt -e sh -c 'backdoorme ; bash'" },
  { "backdoorppt", "urxvt -e sh -c 'backdoorppt ; bash'" },
  { "barq", "urxvt -e sh -c 'barq -h ; bash'" },
  { "cymothoa-udp_server", "urxvt -e sh -c 'cymothoa-udp_server ; bash'" },
  { "demiguise", "urxvt -e sh -c 'demiguise -h ; bash'" },
  { "donut", "urxvt -e sh -c 'donut -h ; bash'" },
  { "dr0p1t", "urxvt -e sh -c 'dr0p1t -h ; bash'" },
  { "evil-winrm", "urxvt -e sh -c 'evil-winrm -h ; bash'" },
  { "evilpdf", "urxvt -e sh -c 'evilpdf -h ; bash'" },
  { "exe2image", "urxvt -e sh -c 'exe2image ; bash'" },
  { "gobd", "urxvt -e sh -c 'gobd -h ; bash'" },
  { "harness", "urxvt -e sh -c 'harness ; bash'" },
  { "hercules-payload", "urxvt -e sh -c 'hercules-payload ; bash'" },
  { "hotpatcher", "urxvt -e sh -c 'hotpatcher -h ; bash'" },
  { "iloscan", "urxvt -e sh -c 'iloscan ; bash'" },
  { "k55", "urxvt -e sh -c 'k55 -h ; bash'" },
}
backdoormenu2 = {
  { "kimi", "urxvt -e sh -c 'kimi -h ; bash'" },
  { "kwetza", "urxvt -e sh -c 'kwetza --help ; bash'" },
  { "interpatch", "urxvt -e sh -c 'interpatch -h ; bash'" },
  { "lfi-image-helper", "urxvt -e sh -c 'lfi-image-helper ; bash'" },
  { "linux-inject", "urxvt -e sh -c 'linux-inject -h ; bash'" },
  { "linux-inject-32", "urxvt -e sh -c 'linux-inject-32 -h ; bash'" },
  { "ms-sys", "urxvt -e sh -c 'ms-sys -h ; bash'" },
  { "msf-mpc", "urxvt -e sh -c 'msf-mpc -h ; bash'" },
  { "msvpwn", "urxvt -e sh -c 'msvpwn -h ; bash'" },
  { "nxcrypt", "urxvt -e sh -c 'nxcrypt -h ; bash'" },
  { "patchkit", "urxvt -e sh -c 'patchkit -h ; bash'" },
  { "pivotsuite", "urxvt -e sh -c 'pivotsuite -h ; bash'" },
  { "pixload-bmp", "urxvt -e sh -c 'pixload-bmp ; bash'" },
  { "pixload-gif", "urxvt -e sh -c 'pixload-gif ; bash'" },
  { "pixload-jpg", "urxvt -e sh -c 'pixload-jpg ; bash'" },
  { "pixload-webp", "urxvt -e sh -c 'pixload-webp ; bash'" },
  { "powerstager", "urxvt -e sh -c 'powerstager -h ; bash'" },
  { "pwncat", "urxvt -e sh -c 'pwncat cd /usr/share/windows/pwncat ; ls ; bash'" },
  { "pyrasite", "urxvt -e sh -c 'pyrasite -h ; bash'" },
  { "pyrasite-memory-viewer", "urxvt -e sh -c 'pyrasite-memory-viewer ; bash'" },
}
backdoormenu3 = {
  { "remot3d", "urxvt -e sh -c 'remot3d ; bash'" },
  { "rrs", "urxvt -e sh -c 'rrs -h ; bash'" },
  { "rspet-client", "urxvt -e sh -c 'rspet-client ; bash'" },
  { "rspet-server", "urxvt -e sh -c 'rspet-server ; bash'" },
  { "saruman", "urxvt -e sh -c 'saruman ; bash'" },
  { "sb0x", "urxvt -e sh -c 'sb0x -h ; bash'" },
  { "shellinaboxd", "urxvt -e sh -c 'shellinaboxd -h ; bash'" },
  { "shellter", "urxvt -e sh -c 'shellter ; bash'" },
  { "sherlocked", "urxvt -e sh -c 'sherlocked ; bash'" },
  { "stripx", "urxvt -e sh -c 'stripx ; bash'" },
  { "stub", "urxvt -e sh -c 'stub ; bash'" },
  { "shootback-master", "urxvt -e sh -c 'shootback-master -h ; bash'" },
  { "shootback-slaver", "urxvt -e sh -c 'shootback-slaver -h ; bash'" },
  { "silenttrinity", "urxvt -e sh -c 'silenttrinity -h ; bash'" },
  { "silenttrinity-teamserver", "urxvt -e sh -c 'silenttrinity-teamserver -h ; bash'" },
  { "trixd00r", "urxvt -e sh -c 'trixd00r -H ; bash'" },
  { "u3-pwn", "urxvt -e sh -c 'u3-pwn ; bash'" },
  { "webacoo", "urxvt -e sh -c 'webacoo -h ; bash'" },
  { "webspa", "urxvt -e sh -c 'webspa -help ; bash'" },
  { "weevely", "urxvt -e sh -c 'weevely -h ; bash'" },
}
backdoormenu = {
  { "1", backdoormenu1 },
  { "2", backdoormenu2 },
  { "3", backdoormenu3 },
}
binarymenu1 = {
  { "amber", "urxvt -e sh -c 'amber ; bash'" },
  { "amoco", "urxvt -e sh -c 'amoco ; bash'" },
  { "androarsc", "urxvt -e sh -c 'androarsc ; bash'" },
  { "androcg", "urxvt -e sh -c 'androcg ; bash'" },
  { "androdd", "urxvt -e sh -c 'androdd ; bash'" },
  { "androdis", "urxvt -e sh -c 'androdis ; bash'" },
  { "androguard", "urxvt -e sh -c 'androguard -h ; bash'" },
  { "androgui", "urxvt -e sh -c 'androgui ; bash'" },
  { "androlyze", "urxvt -e sh -c 'androlyze ; bash'" },
  { "androsign", "urxvt -e sh -c 'androsign ; bash'" },
  { "angr-management", "urxvt -e sh -c 'angr-management ; bash'" },
  { "avet", "urxvt -e sh -c 'avet ; bash'" },
  { "backdoor-factory", "urxvt -e sh -c 'backdoor-factory -h ; bash'" },
  { "bagbak", "urxvt -e sh -c 'bagbak -h ; bash'" },
  { "BARFcfg", "urxvt -e sh -c 'BARFcfg -h ; bash'" },
  { "BARFcg", "urxvt -e sh -c 'BARFcg -h ; bash'" },
  { "BARFgadgets", "urxvt -e sh -c 'BARFgadgets -h ; bash'" },
  { "bdfproxy", "urxvt -e sh -c 'bdfproxy -h ; bash'" },
  { "bgrep", "urxvt -e sh -c 'bgrep ; bash'" },
  { "binaryninja-demo", "urxvt -e sh -c 'binaryninja-demo ; bash'" },
}
binarymenu2 = {
  { "lldb", "urxvt -e sh -c 'lldb ; bash'" },
  { "lldb-argdumper", "urxvt -e sh -c 'lldb-argdumper ; bash'" },
  { "lldb-server", "urxvt -e sh -c 'lldb-server ; bash'" },
  { "bindead", "urxvt -e sh -c 'bindead ; bash'" },
  { "bindiff", "urxvt -e sh -c 'bindiff ; bash'" },
  { "binexport2dump", "urxvt -e sh -c 'binexport2dump ; bash'" },
  { "binflow", "urxvt -e sh -c 'binflow ; bash'" },
  { "binnavi", "urxvt -e sh -c 'binnavi ; bash'" },
  { "binwalk", "urxvt -e sh -c 'binwalk ; bash'" },
  { "binwally", "urxvt -e sh -c 'binwally -h ; bash'" },
  { "bsdiff", "urxvt -e sh -c 'bsdiff ; bash'" },
  { "bspatch", "urxvt -e sh -c 'bspatch ; bash'" },
  { "bmore", "urxvt -e sh -c 'bmore ; bash'" },
  { "bvedit", "urxvt -e sh -c 'bvedit -h ; bash'" },
  { "bvi", "urxvt -e sh -c 'bvi -h ; bash'" },
  { "bview", "urxvt -e sh -c 'bview -h ; bash'" },
  { "bytecode-viewer", "urxvt -e sh -c 'bytecode-viewer ; bash'" },
  { "cminer", "urxvt -e sh -c 'cminer ; bash'" },
  { "cpp2il", "urxvt -e sh -c 'cpp2il -h ; bash'" },
  { "damm", "urxvt -e sh -c 'damm -h ; bash'" },
}
binarymenu3 = {
  { "die", "urxvt -e sh -c 'die ; bash'" },
  { "diec", "urxvt -e sh -c 'diec ; bash'" },
  { "dexpatcher", "urxvt -e sh -c 'dexpatcher -h ; bash'" },
  { "dissector", "urxvt -e sh -c 'dissector -h ; bash'" },
  { "dutas", "urxvt -e sh -c 'dutas -h ; bash'" },
  { "dwarf", "urxvt -e sh -c 'dwarf --help ; bash'" },
  { "drinject", "urxvt -e sh -c 'drinject ; bash'" },
  { "drloader", "urxvt -e sh -c 'drloader ; bash'" },
  { "drrun", "urxvt -e sh -c 'drrun ; bash'" },
  { "nudgeunix", "urxvt -e sh -c 'nudgeunix ; bash'" },
  { "drltrace", "urxvt -e sh -c 'drltrace ; bash'" },
  { "drmemory", "urxvt -e sh -c 'drmemory ; bash'" },
  { "symquery", "urxvt -e sh -c 'symquery ; bash'" },
  { "ecfs", "urxvt -e sh -c 'ecfs ; bash'" },
  { "ecfs-handler", "urxvt -e sh -c 'ecfs-handler ; bash'" },
  { "et-flip", "urxvt -e sh -c 'et-flip ; bash'" },
  { "readecfs", "urxvt -e sh -c 'readecfs ; bash'" },
  { "ebfc", "urxvt -e sh -c 'ebfc -h ; bash'" },
  { "elfls", "urxvt -e sh -c 'elfls ; bash'" },
  { "elftoc", "urxvt -e sh -c 'elftoc --help ; bash'" },
}
binarymenu4 = {
  { "infect", "urxvt -e sh -c 'infect ; bash'" },
  { "objres", "urxvt -e sh -c 'objres --help ; bash'" },
  { "sstrip", "urxvt -e sh -c 'sstrip ; bash'" },
  { "ebfc", "urxvt -e sh -c 'ebfc -h ; bash'" },
  { "elfls", "urxvt -e sh -c 'elfls ; bash'" },
  { "elftoc", "urxvt -e sh -c 'elftoc --help ; bash'" },
  { "infect", "urxvt -e sh -c 'infect ; bash'" },
  { "objres", "urxvt -e sh -c 'objres --help ; bash'" },
  { "sstrip", "urxvt -e sh -c 'sstrip ; bash'" },
  { "elfparser-cli", "urxvt -e sh -c 'elfparser-cli --help ; bash'" },
  { "eu-addr2line", "urxvt -e sh -c 'eu-addr2line --help ; bash'" },
  { "eu-ar", "urxvt -e sh -c 'eu-ar --help ; bash'" },
  { "eu-elfcmp", "urxvt -e sh -c 'eu-elfcmp --help ; bash'" },
  { "eu-elfcompress", "urxvt -e sh -c 'eu-elfcompress --help ; bash'" },
  { "eu-elflint", "urxvt -e sh -c 'eu-elflint --help ; bash'" },
  { "eu-findtextrel", "urxvt -e sh -c 'eu-findtextrel --help ; bash'" },
  { "eu-make-debug-archive", "urxvt -e sh -c 'eu-make-debug-archive --help ; bash'" },
  { "eu-nm", "urxvt -e sh -c 'eu-nm --help ; bash'" },
  { "eu-objdump", "urxvt -e sh -c 'eu-objdump --help ; bash'" },
  { "eu-ranlib", "urxvt -e sh -c 'eu-ranlib --help ; bash'" },
}
binarymenu5 = {
  { "eu-readelf", "urxvt -e sh -c 'eu-readelf --help ; bash'" },
  { "eu-size", "urxvt -e sh -c 'eu-size --help ; bash'" },
  { "eu-stack", "urxvt -e sh -c 'eu-stack --help ; bash'" },
  { "eu-strings", "urxvt -e sh -c 'eu-strings --help ; bash'" },
  { "eu-strip", "urxvt -e sh -c 'eu-strip --help ; bash'" },
  { "eu-unstrip", "urxvt -e sh -c 'eu-unstrip --help ; bash'" },
  { "eu-addr2line", "urxvt -e sh -c 'eu-addr2line --help ; bash'" },
  { "eu-ar", "urxvt -e sh -c 'eu-ar --help ; bash'" },
  { "eu-elfcmp", "urxvt -e sh -c 'eu-elfcmp --help ; bash'" },
  { "eu-elfcompress", "urxvt -e sh -c 'eu-elfcompress --help ; bash'" },
  { "eu-elflint", "urxvt -e sh -c 'eu-elflint --help ; bash'" },
  { "eu-findtextrel", "urxvt -e sh -c 'eu-findtextrel --help ; bash'" },
  { "eu-make-debug-archive", "urxvt -e sh -c 'eu-make-debug-archive --help ; bash'" },
  { "eu-nm", "urxvt -e sh -c 'eu-nm --help ; bash'" },
  { "eu-objdump", "urxvt -e sh -c 'eu-objdump --help ; bash'" },
  { "eu-ranlib", "urxvt -e sh -c 'eu-ranlib --help ; bash'" },
  { "eu-readelf", "urxvt -e sh -c 'eu-readelf --help ; bash'" },
  { "eu-size", "urxvt -e sh -c 'eu-size --help ; bash'" },
  { "eu-stack", "urxvt -e sh -c 'eu-stack --help ; bash'" },
  { "eu-strings", "urxvt -e sh -c 'eu-strings --help ; bash'" },
}
binarymenu6 = {
  { "eu-strip", "urxvt -e sh -c 'eu-strip --help ; bash'" },
  { "eu-unstrip", "urxvt -e sh -c 'eu-unstrip --help ; bash'" },
  { "e2dbg32", "urxvt -e sh -c 'e2dbg32 ; bash'" },
  { "e2dbg64", "urxvt -e sh -c 'e2dbg64 ; bash'" },
  { "etrace32", "urxvt -e sh -c 'etrace32 ; bash'" },
  { "etrace64", "urxvt -e sh -c 'etrace64 ; bash'" },
  { "evarista32", "urxvt -e sh -c 'evarista32 ; bash'" },
  { "evarista64", "urxvt -e sh -c 'evarista64 ; bash'" },
  { "kedbg32", "urxvt -e sh -c 'kedbg32 ; bash'" },
  { "kedbg64", "urxvt -e sh -c 'kedbg64 ; bash'" },
  { "evilize", "urxvt -e sh -c 'evilize -h ; bash'" },
  { "exe2image", "urxvt -e sh -c 'exe2image ; bash'" },
  { "exescan", "urxvt -e sh -c 'exescan ; bash'" },
  { "expimp-lookup", "urxvt -e sh -c 'expimp-lookup ; bash'" },
  { "expose", "urxvt -e sh -c 'expose ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "compress", "urxvt -e sh -c 'compress ; bash'" },
  { "lint", "urxvt -e sh -c 'lint ; bash'" },
  { "release", "urxvt -e sh -c 'release ; bash'" },
  { "source-highlight", "urxvt -e sh -c 'source-highlight ; bash'" },
}
binarymenu7 = {
  { ".coverrc", "urxvt -e sh -c '.coverrc ; bash'" },
  { "cover", "urxvt -e sh -c 'cover ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "test262.whitelist", "urxvt -e sh -c 'test262.whitelist ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "compress", "urxvt -e sh -c 'compress ; bash'" },
  { "lint", "urxvt -e sh -c 'lint ; bash'" },
  { "release", "urxvt -e sh -c 'release ; bash'" },
  { "source-highlight", "urxvt -e sh -c 'source-highlight ; bash'" },
  { ".coverrc", "urxvt -e sh -c '.coverrc ; bash'" },
}
binarymenu8 = {
  { "cover", "urxvt -e sh -c 'cover ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "test262.whitelist", "urxvt -e sh -c 'test262.whitelist ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
}
binarymenu9 = {
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "frida-ios-dump", "urxvt -e sh -c 'frida-ios-dump -h ; bash'" },
  { "gadgetinspector", "urxvt -e sh -c 'gadgetinspector ; bash'" },
  { "gdbgui", "urxvt -e sh -c 'gdbgui -h ; bash'" },
  { "haystack-find-heap", "urxvt -e sh -c 'haystack-find-heap ; bash'" },
  { "haystack-live-dump", "urxvt -e sh -c 'haystack-live-dump ; bash'" },
  { "haystack-live-watch", "urxvt -e sh -c 'haystack-live-watch ; bash'" },
  { "haystack-rekall-dump", "urxvt -e sh -c 'haystack-rekall-dump ; bash'" },
  { "haystack-search", "urxvt -e sh -c 'haystack-search ; bash'" },
  { "haystack-volatility-dump", "urxvt -e sh -c 'haystack-volatility-dump ; bash'" },
  { "hercules-payload", "urxvt -e sh -c 'hercules-payload ; bash'" },
  { "hopper", "urxvt -e sh -c 'hopper ; bash'" },
  { "ida64", "urxvt -e sh -c 'ida64 ; bash'" },
  { "jpegdump", "urxvt -e sh -c 'jpegdump -h ; bash'" },
  { "jwscan", "urxvt -e sh -c 'jwscan -h ; bash'" },
  { "gen-bout", "urxvt -e sh -c 'gen-bout ; bash'" },
  { "gen-random-bout", "urxvt -e sh -c 'gen-random-bout ; bash'" },
}
binarymenu10 = {
  { "kleaver", "urxvt -e sh -c 'kleaver -h ; bash'" },
  { "klee", "urxvt -e sh -c 'klee -h ; bash'" },
  { "klee-stats", "urxvt -e sh -c 'klee-stats -h ; bash'" },
  { "ktest-tool", "urxvt -e sh -c 'ktest-tool -h ; bash'" },
  { "lazydroid", "urxvt -e sh -c 'lazydroid ; bash'" },
  { "interpatch", "urxvt -e sh -c 'interpatch -h ; bash'" },
  { "leena", "urxvt -e sh -c 'leena ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "cake", "urxvt -e sh -c 'cake ; bash'" },
  { "coffee", "urxvt -e sh -c 'coffee ; bash'" },
  { "grunt", "urxvt -e sh -c 'grunt ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "tsc", "urxvt -e sh -c 'tsc ; bash'" },
  { "tsserver", "urxvt -e sh -c 'tsserver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "handlebars", "urxvt -e sh -c 'handlebars ; bash'" },
  { "client", "urxvt -e sh -c 'client ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
}
binarymenu12 = {
  { "tsc", "urxvt -e sh -c 'tsc ; bash'" },
  { "tsserver", "urxvt -e sh -c 'tsserver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "without_eval", "urxvt -e sh -c 'without_eval ; bash'" },
  { "linux-inject", "urxvt -e sh -c 'linux-inject -h ; bash'" },
  { "linux-inject-32", "urxvt -e sh -c 'linux-inject-32 -h ; bash'" },
  { "mpclient", "urxvt -e sh -c 'mpclient ; bash'" },
  { "ltrace", "urxvt -e sh -c 'ltrace ; bash'" },
  { "malscan", "urxvt -e sh -c 'malscan ; bash'" },
  { "manticore", "urxvt -e sh -c 'manticore -h ; bash'" },
  { "manticore-verifier", "urxvt -e sh -c 'manticore-verifier ; bash'" },
  { "manul", "urxvt -e sh -c 'manul -h ; bash'" },
  { "pindb", "urxvt -e sh -c 'pindb ; bash'" },
  { "melkor", "urxvt -e sh -c 'melkor -h ; bash'" },
  { "metame", "urxvt -e sh -c 'metame -h ; bash'" },
  { "createnpk", "urxvt -e sh -c 'createnpk ; bash'" },
  { "dumpnpk", "urxvt -e sh -c 'dumpnpk ; bash'" },
  { "unpacknpk", "urxvt -e sh -c 'unpacknpk ; bash'" },
  { "ms-sys", "urxvt -e sh -c 'ms-sys -h ; bash'" },
}
binarymenu13 = {
  { "msvpwn", "urxvt -e sh -c 'msvpwn -h ; bash'" },
  { "objection", "urxvt -e sh -c 'objection --help ; bash'" },
  { "oledump", "urxvt -e sh -c 'oledump -h ; bash'" },
  { "osslsigncode", "urxvt -e sh -c 'osslsigncode -h ; bash'" },
  { "packer", "urxvt -e sh -c 'packer ; bash'" },
  { "packerid", "urxvt -e sh -c 'packerid -h ; bash'" },
  { "patchkit", "urxvt -e sh -c 'patchkit -h ; bash'" },
  { "peframe", "urxvt -e sh -c 'peframe ; bash'" },
  { "pepper", "urxvt -e sh -c 'pepper -h ; bash'" },
  { "pin", "urxvt -e sh -c 'pin ; bash'" },
  { "pindb", "urxvt -e sh -c 'pindb ; bash'" },
  { "pindb.sig", "urxvt -e sh -c 'pindb.sig ; bash'" },
  { "pindb", "urxvt -e sh -c 'pindb ; bash'" },
  { "pindb.sig", "urxvt -e sh -c 'pindb.sig ; bash'" },
  { "pintool", "urxvt -e sh -c 'pintool -h ; bash'" },
  { "pintool2", "urxvt -e sh -c 'pintool2 -h ; bash'" },
  { "pixd", "urxvt -e sh -c 'pixd -h ; bash'" },
  { "plasma-disasm", "urxvt -e sh -c 'plasma-disasm -h ; bash'" },
  { "powerstager", "urxvt -e sh -c 'powerstager -h ; bash'" },
  { "procdump", "urxvt -e sh -c 'procdump ; bash'" },
}
binarymenu14 = {
  { "proctal", "urxvt -e sh -c 'proctal -h ; bash'" },
  { "frida", "urxvt -e sh -c 'frida -h ; bash'" },
  { "frida-compile", "urxvt -e sh -c 'frida-compile ; bash'" },
  { "frida-create", "urxvt -e sh -c 'frida-create ; bash'" },
  { "frida-discover", "urxvt -e sh -c 'frida-discover -h ; bash'" },
  { "frida-join", "urxvt -e sh -c 'frida-join ; bash'" },
  { "frida-kill", "urxvt -e sh -c 'frida-kill -h ; bash'" },
  { "frida-ls", "urxvt -e sh -c 'frida-ls ; bash'" },
  { "frida-ls-devices", "urxvt -e sh -c 'frida-ls-devices -h ; bash'" },
  { "frida-pull", "urxvt -e sh -c 'frida-pull ; bash'" },
  { "frida-rm", "urxvt -e sh -c 'frida-rm ; bash'" },
  { "frida-trace", "urxvt -e sh -c 'frida-trace -h ; bash'" },
  { "ezhexviewer", "urxvt -e sh -c 'ezhexviewer ; bash'" },
  { "ftguess", "urxvt -e sh -c 'ftguess ; bash'" },
  { "mraptor", "urxvt -e sh -c 'mraptor ; bash'" },
  { "msodde", "urxvt -e sh -c 'msodde ; bash'" },
  { "olebrowse", "urxvt -e sh -c 'olebrowse ; bash'" },
  { "oledir", "urxvt -e sh -c 'oledir ; bash'" },
  { "olefile", "urxvt -e sh -c 'olefile ; bash'" },
  { "oleid", "urxvt -e sh -c 'oleid -h ; bash'" },
}
binarymenu15 = {
  { "olemap", "urxvt -e sh -c 'olemap ; bash'" },
  { "olemeta", "urxvt -e sh -c 'olemeta -h ; bash'" },
  { "oleobj", "urxvt -e sh -c 'oleobj ; bash'" },
  { "oletimes", "urxvt -e sh -c 'oletimes ; bash'" },
  { "olevba", "urxvt -e sh -c 'olevba ; bash'" },
  { "pyxswf", "urxvt -e sh -c 'pyxswf ; bash'" },
  { "rtfobj", "urxvt -e sh -c 'rtfobj ; bash'" },
  { "frida-compile2", "urxvt -e sh -c 'frida-compile2 ; bash'" },
  { "frida-create2", "urxvt -e sh -c 'frida-create2 ; bash'" },
  { "frida-discover2", "urxvt -e sh -c 'frida-discover2 ; bash'" },
  { "frida-join2", "urxvt -e sh -c 'frida-join2 ; bash'" },
  { "frida-kill2", "urxvt -e sh -c 'frida-kill2 ; bash'" },
  { "frida-ls-devices2", "urxvt -e sh -c 'frida-ls-devices2 ; bash'" },
  { "frida-ls2", "urxvt -e sh -c 'frida-ls2 ; bash'" },
  { "frida-pull2", "urxvt -e sh -c 'frida-pull2 ; bash'" },
  { "frida-rm2", "urxvt -e sh -c 'frida-rm2 ; bash'" },
  { "frida-trace2", "urxvt -e sh -c 'frida-trace2 ; bash'" },
  { "frida2", "urxvt -e sh -c 'frida2 ; bash'" },
  { "ezhexviewer2", "urxvt -e sh -c 'ezhexviewer2 ; bash'" },
  { "ftguess2", "urxvt -e sh -c 'ftguess2 ; bash'" },
}
binarymenu16 = {
  { "mraptor2", "urxvt -e sh -c 'mraptor2 ; bash'" },
  { "msodde2", "urxvt -e sh -c 'msodde2 ; bash'" },
  { "olebrowse2", "urxvt -e sh -c 'olebrowse2 ; bash'" },
  { "oledir2", "urxvt -e sh -c 'oledir2 ; bash'" },
  { "olefile2", "urxvt -e sh -c 'olefile2 ; bash'" },
  { "oleid2", "urxvt -e sh -c 'oleid2 ; bash'" },
  { "olemap2", "urxvt -e sh -c 'olemap2 ; bash'" },
  { "olemeta2", "urxvt -e sh -c 'olemeta2 ; bash'" },
  { "oleobj2", "urxvt -e sh -c 'oleobj2 ; bash'" },
  { "oletimes2", "urxvt -e sh -c 'oletimes2 ; bash'" },
  { "olevba2", "urxvt -e sh -c 'olevba2 ; bash'" },
  { "pyxswf2", "urxvt -e sh -c 'pyxswf2 ; bash'" },
  { "rtfobj2", "urxvt -e sh -c 'rtfobj2 ; bash'" },
  { "quickscope", "urxvt -e sh -c 'quickscope -h ; bash'" },
  { "rbasefind", "urxvt -e sh -c 'rbasefind -h ; bash'" },
  { "recomposer", "urxvt -e sh -c 'recomposer -h ; bash'" },
  { "redress", "urxvt -e sh -c 'redress -h ; bash'" },
  { "ropper", "urxvt -e sh -c 'ropper ; bash'" },
  { "rp-lin-x64", "urxvt -e sh -c 'rp-lin-x64 -h ; bash'" },
  { "saruman", "urxvt -e sh -c 'saruman ; bash'" },
}
binarymenu17 = {
  { "sea", "urxvt -e sh -c 'sea -h ; bash'" },
  { "sgn", "urxvt -e sh -c 'sgn ; bash'" },
  { "sherlocked", "urxvt -e sh -c 'sherlocked ; bash'" },
  { "stripx", "urxvt -e sh -c 'stripx ; bash'" },
  { "stub", "urxvt -e sh -c 'stub ; bash'" },
  { "smap", "urxvt -e sh -c 'smap -h ; bash'" },
  { "soot", "urxvt -e sh -c 'soot -h ; bash'" },
  { "strace", "urxvt -e sh -c 'strace ; bash'" },
  { "strace-log-merge", "urxvt -e sh -c 'strace-log-merge ; bash'" },
  { "strace", "urxvt -e sh -c 'strace ; bash'" },
  { "strace-log-merge", "urxvt -e sh -c 'strace-log-merge ; bash'" },
  { "flarestrings", "urxvt -e sh -c 'flarestrings -h ; bash'" },
  { "rank_strings", "urxvt -e sh -c 'rank_strings -h ; bash'" },
  { "as3compile", "urxvt -e sh -c 'as3compile ; bash'" },
  { "font2swf", "urxvt -e sh -c 'font2swf ; bash'" },
  { "gif2swf", "urxvt -e sh -c 'gif2swf ; bash'" },
  { "jpeg2swf", "urxvt -e sh -c 'jpeg2swf ; bash'" },
  { "pdf2swf", "urxvt -e sh -c 'pdf2swf ; bash'" },
  { "png2swf", "urxvt -e sh -c 'png2swf ; bash'" },
  { "swfbbox", "urxvt -e sh -c 'swfbbox ; bash'" },
}
binarymenu18 = {
  { "swfc", "urxvt -e sh -c 'swfc ; bash'" },
  { "swfdump", "urxvt -e sh -c 'swfdump ; bash'" },
  { "swfextract", "urxvt -e sh -c 'swfextract ; bash'" },
  { "swfrender", "urxvt -e sh -c 'swfrender ; bash'" },
  { "swfstrings", "urxvt -e sh -c 'swfstrings ; bash'" },
  { "wav2swf", "urxvt -e sh -c 'wav2swf ; bash'" },
  { "trid", "urxvt -e sh -c 'trid -h ; bash'" },
  { "truegaze", "urxvt -e sh -c 'truegaze -h ; bash'" },
  { "unifuzzer", "urxvt -e sh -c 'unifuzzer ; bash'" },
  { "unstrip", "urxvt -e sh -c 'unstrip ; bash'" },
  { "upx", "urxvt -e sh -c 'upx -h ; bash'" },
  { "callgrind_annotate", "urxvt -e sh -c 'callgrind_annotate ; bash'" },
  { "callgrind_control", "urxvt -e sh -c 'callgrind_control ; bash'" },
  { "cg_annotate", "urxvt -e sh -c 'cg_annotate ; bash'" },
  { "cg_diff", "urxvt -e sh -c 'cg_diff ; bash'" },
  { "cg_merge", "urxvt -e sh -c 'cg_merge ; bash'" },
  { "ms_print", "urxvt -e sh -c 'ms_print ; bash'" },
  { "valgrind", "urxvt -e sh -c 'valgrind ; bash'" },
  { "valgrind-di-server", "urxvt -e sh -c 'valgrind-di-server ; bash'" },
  { "valgrind-listener", "urxvt -e sh -c 'valgrind-listener ; bash'" },
}
binarymenu19 = {
  { "vgdb", "urxvt -e sh -c 'vgdb ; bash'" },
  { "callgrind_annotate", "urxvt -e sh -c 'callgrind_annotate ; bash'" },
  { "callgrind_control", "urxvt -e sh -c 'callgrind_control ; bash'" },
  { "cg_annotate", "urxvt -e sh -c 'cg_annotate ; bash'" },
  { "cg_diff", "urxvt -e sh -c 'cg_diff ; bash'" },
  { "cg_merge", "urxvt -e sh -c 'cg_merge ; bash'" },
  { "ms_print", "urxvt -e sh -c 'ms_print ; bash'" },
  { "valgrind", "urxvt -e sh -c 'valgrind ; bash'" },
  { "valgrind-di-server", "urxvt -e sh -c 'valgrind-di-server ; bash'" },
  { "valgrind-listener", "urxvt -e sh -c 'valgrind-listener ; bash'" },
  { "vgdb", "urxvt -e sh -c 'vgdb ; bash'" },
  { "veles", "urxvt -e sh -c 'veles ; bash'" },
  { "viper", "urxvt -e sh -c 'viper -h ; bash'" },
  { "volafox", "urxvt -e sh -c 'volafox -h ; bash'" },
  { "wcc", "urxvt -e sh -c 'wcc -h ; bash'" },
  { "wcch", "urxvt -e sh -c 'wcch -h ; bash'" },
  { "wld", "urxvt -e sh -c 'wld -h ; bash'" },
  { "wxHexEditor", "urxvt -e sh -c 'wxHexEditor ; bash'" },
  { "zelos", "urxvt -e sh -c 'zelos -h ; bash'" },
}
binarymenu = {
  { "1", binarymenu1 },
  { "2", binarymenu2 },
  { "3", binarymenu3 },
  { "4", binarymenu4 },
  { "5", binarymenu5 },
  { "6", binarymenu6 },
  { "7", binarymenu7 },
  { "8", binarymenu8 },
  { "9", binarymenu9 },
  { "10", binarymenu10 },
  { "11", binarymenu11 },
  { "12", binarymenu12 },
  { "13", binarymenu13 },
  { "14", binarymenu14 },
  { "15", binarymenu15 },
  { "16", binarymenu16 },
  { "17", binarymenu17 },
  { "18", binarymenu18 },
  { "19", binarymenu19 },
}
bluetoothmenu1 = {
  { "bleah", "urxvt -e sh -c 'bleah -h ; bash'" },
  { "blue-hydra", "urxvt -e sh -c 'blue-hydra -h ; bash'" },
  { "blue_hydra", "urxvt -e sh -c 'blue_hydra ; bash'" },
  { "rfkill-reset", "urxvt -e sh -c 'rfkill-reset ; bash'" },
  { "test-discovery", "urxvt -e sh -c 'test-discovery ; bash'" },
  { "bluebugger", "urxvt -e sh -c 'bluebugger -h ; bash'" },
  { "attest", "urxvt -e sh -c 'attest ; bash'" },
  { "bluediving-bdaddr", "urxvt -e sh -c 'bluediving-bdaddr ; bash'" },
  { "btftp", "urxvt -e sh -c 'btftp ; bash'" },
  { "btobex", "urxvt -e sh -c 'btobex ; bash'" },
  { "hstest", "urxvt -e sh -c 'hstest ; bash'" },
  { "l2cap-packet", "urxvt -e sh -c 'l2cap-packet ; bash'" },
  { "bluefog", "urxvt -e sh -c 'bluefog ; bash'" },
  { "bluelog", "urxvt -e sh -c 'bluelog -h ; bash'" },
  { "bluepot", "urxvt -e sh -c 'bluepot ; bash'" },
  { "blueprint", "urxvt -e sh -c 'blueprint -h ; bash'" },
  { "blueranger", "urxvt -e sh -c 'blueranger ; bash'" },
  { "bluescan", "urxvt -e sh -c 'bluescan ; bash'" },
  { "bluesnarfer", "urxvt -e sh -c 'bluesnarfer -h ; bash'" },
  { "braces", "urxvt -e sh -c 'braces -h ; bash'" },
}
bluetoothmenu2 = {
  { "bss", "urxvt -e sh -c 'bss -h ; bash'" },
  { "psm_scan", "urxvt -e sh -c 'psm_scan -h ; bash'" },
  { "rfcomm_scan", "urxvt -e sh -c 'rfcomm_scan -h ; bash'" },
  { "btlejack", "urxvt -e sh -c 'btlejack ; bash'" },
  { "btproxy-mitm", "urxvt -e sh -c 'btproxy-mitm -h ; bash'" },
  { "btscanner", "urxvt -e sh -c 'btscanner --help ; bash'" },
  { "carwhisperer", "urxvt -e sh -c 'carwhisperer -h ; bash'" },
  { "crackle", "urxvt -e sh -c 'crackle ; bash'" },
  { "fl0p", "urxvt -e sh -c 'fl0p -h ; bash'" },
  { "ghettotooth", "urxvt -e sh -c 'ghettotooth ; bash'" },
  { "hidattack", "urxvt -e sh -c 'hidattack -h ; bash'" },
  { "obexstress", "urxvt -e sh -c 'obexstress -h ; bash'" },
  { "redfang", "urxvt -e sh -c 'redfang --help ; bash'" },
  { "spooftooph", "urxvt -e sh -c 'spooftooph -h ; bash'" },
  { "tanya", "urxvt -e sh -c 'tanya ; bash'" },
  { "tbear", "urxvt -e sh -c 'tbear -h ; bash'" },
  { "tbsearch", "urxvt -e sh -c 'tbsearch ; bash'" },
  { "ubertooth-afh", "urxvt -e sh -c 'ubertooth-afh ; bash'" },
  { "ubertooth-btbr", "urxvt -e sh -c 'ubertooth-btbr ; bash'" },
  { "ubertooth-btle", "urxvt -e sh -c 'ubertooth-btle -h ; bash'" },
}
bluetoothmenu3 = {
  { "ubertooth-debug", "urxvt -e sh -c 'ubertooth-debug ; bash'" },
  { "ubertooth-dfu", "urxvt -e sh -c 'ubertooth-dfu ; bash'" },
  { "ubertooth-ducky", "urxvt -e sh -c 'ubertooth-ducky ; bash'" },
  { "ubertooth-dump", "urxvt -e sh -c 'ubertooth-dump -h ; bash'" },
  { "ubertooth-ego", "urxvt -e sh -c 'ubertooth-ego ; bash'" },
  { "ubertooth-follow", "urxvt -e sh -c 'ubertooth-follow -h ; bash'" },
  { "ubertooth-rx", "urxvt -e sh -c 'ubertooth-rx ; bash'" },
  { "ubertooth-scan", "urxvt -e sh -c 'ubertooth-scan ; bash'" },
  { "ubertooth-specan", "urxvt -e sh -c 'ubertooth-specan -h ; bash'" },
  { "ubertooth-specan-ui", "urxvt -e sh -c 'ubertooth-specan-ui ; bash'" },
  { "ubertooth-tx", "urxvt -e sh -c 'ubertooth-tx ; bash'" },
  { "ubertooth-util", "urxvt -e sh -c 'ubertooth-util -h ; bash'" },
}
bluetoothmenu = {
  { "1", bluetoothmenu1 },
  { "2", bluetoothmenu2 },
  { "3", bluetoothmenu3 },
}
codeauditmenu1 = {
  { "androwarn", "urxvt -e sh -c 'androwarn -h ; bash'" },
  { "bof-detector", "urxvt -e sh -c 'bof-detector -h ; bash'" },
  { "brakeman", "urxvt -e sh -c 'brakeman ; bash'" },
  { "cflow", "urxvt -e sh -c 'cflow -h ; bash'" },
  { "codeql", "urxvt -e sh -c 'codeql ; bash'" },
  { "java", "urxvt -e sh -c 'java ; bash'" },
  { "javac", "urxvt -e sh -c 'javac ; bash'" },
  { "keytool", "urxvt -e sh -c 'keytool ; bash'" },
  { "rmid", "urxvt -e sh -c 'rmid ; bash'" },
  { "rmiregistry", "urxvt -e sh -c 'rmiregistry ; bash'" },
  { "serialver", "urxvt -e sh -c 'serialver ; bash'" },
  { "tsc", "urxvt -e sh -c 'tsc ; bash'" },
  { "tsserver", "urxvt -e sh -c 'tsserver ; bash'" },
  { "java", "urxvt -e sh -c 'java ; bash'" },
  { "javac", "urxvt -e sh -c 'javac ; bash'" },
  { "keytool", "urxvt -e sh -c 'keytool ; bash'" },
  { "rmiregistry", "urxvt -e sh -c 'rmiregistry ; bash'" },
  { "serialver", "urxvt -e sh -c 'serialver ; bash'" },
  { "cppcheck", "urxvt -e sh -c 'cppcheck -h ; bash'" },
  { "cppcheck-gui", "urxvt -e sh -c 'cppcheck-gui ; bash'" },
}
codeauditmenu2 = {
  { "cppcheck-htmlreport", "urxvt -e sh -c 'cppcheck-htmlreport -h ; bash'" },
  { "cppcheck", "urxvt -e sh -c 'cppcheck -h ; bash'" },
  { "cppcheck-gui", "urxvt -e sh -c 'cppcheck-gui ; bash'" },
  { "cppcheck-htmlreport", "urxvt -e sh -c 'cppcheck-htmlreport -h ; bash'" },
  { "detect-secrets", "urxvt -e sh -c 'detect-secrets -h ; bash'" },
  { "detect-secrets-hook", "urxvt -e sh -c 'detect-secrets-hook -h ; bash'" },
  { "devaudit", "urxvt -e sh -c 'devaudit -h ; bash'" },
  { "dscanner", "urxvt -e sh -c 'dscanner -h ; bash'" },
  { "expose", "urxvt -e sh -c 'expose ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "compress", "urxvt -e sh -c 'compress ; bash'" },
  { "lint", "urxvt -e sh -c 'lint ; bash'" },
  { "release", "urxvt -e sh -c 'release ; bash'" },
  { "source-highlight", "urxvt -e sh -c 'source-highlight ; bash'" },
  { ".coverrc", "urxvt -e sh -c '.coverrc ; bash'" },
  { "cover", "urxvt -e sh -c 'cover ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "test262.whitelist", "urxvt -e sh -c 'test262.whitelist ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
}
codeauditmenu3 = {
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "compress", "urxvt -e sh -c 'compress ; bash'" },
  { "lint", "urxvt -e sh -c 'lint ; bash'" },
  { "release", "urxvt -e sh -c 'release ; bash'" },
  { "source-highlight", "urxvt -e sh -c 'source-highlight ; bash'" },
  { ".coverrc", "urxvt -e sh -c '.coverrc ; bash'" },
  { "cover", "urxvt -e sh -c 'cover ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "test262.whitelist", "urxvt -e sh -c 'test262.whitelist ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
}
codeauditmenu4 = {
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "parser", "urxvt -e sh -c 'parser ; bash'" },
  { "jsesc", "urxvt -e sh -c 'jsesc ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "flawfinder", "urxvt -e sh -c 'flawfinder -h ; bash'" },
  { "git-dump", "urxvt -e sh -c 'git-dump ; bash'" },
}
codeauditmenu5 = {
  { "graudit", "urxvt -e sh -c 'graudit -h ; bash'" },
  { "leena", "urxvt -e sh -c 'leena ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "cake", "urxvt -e sh -c 'cake ; bash'" },
  { "coffee", "urxvt -e sh -c 'coffee ; bash'" },
  { "grunt", "urxvt -e sh -c 'grunt ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "tsc", "urxvt -e sh -c 'tsc ; bash'" },
  { "tsserver", "urxvt -e sh -c 'tsserver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "handlebars", "urxvt -e sh -c 'handlebars ; bash'" },
  { "client", "urxvt -e sh -c 'client ; bash'" },
  { "ncp", "urxvt -e sh -c 'ncp ; bash'" },
  { "semver", "urxvt -e sh -c 'semver ; bash'" },
  { "tsc", "urxvt -e sh -c 'tsc ; bash'" },
  { "tsserver", "urxvt -e sh -c 'tsserver ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "without_eval", "urxvt -e sh -c 'without_eval ; bash'" },
}
codeauditmenu6 = {
  { "local-php-security-checker", "urxvt -e sh -c 'local-php-security-checker -h ; bash'" },
  { "mosca", "urxvt -e sh -c 'mosca ; bash'" },
  { "peach-fuzz", "urxvt -e sh -c 'peach-fuzz -h ; bash'" },
  { "codequery", "urxvt -e sh -c 'codequery ; bash'" },
  { "codeslicer", "urxvt -e sh -c 'codeslicer ; bash'" },
  { "pfff", "urxvt -e sh -c 'pfff ; bash'" },
  { "pfff_db", "urxvt -e sh -c 'pfff_db ; bash'" },
  { "pfff_test", "urxvt -e sh -c 'pfff_test ; bash'" },
  { "scheck", "urxvt -e sh -c 'scheck ; bash'" },
  { "sgrep", "urxvt -e sh -c 'sgrep ; bash'" },
  { "spatch", "urxvt -e sh -c 'spatch ; bash'" },
  { "stags", "urxvt -e sh -c 'stags ; bash'" },
  { "php-malware-finder", "urxvt -e sh -c 'php-malware-finder -h ; bash'" },
  { "console", "urxvt -e sh -c 'console ; bash'" },
  { "procyon", "urxvt -e sh -c 'procyon ; bash'" },
  { "pscan", "urxvt -e sh -c 'pscan -h ; bash'" },
  { "rats", "urxvt -e sh -c 'rats -h ; bash'" },
  { "retire", "urxvt -e sh -c 'retire -h ; bash'" },
  { "semgrep", "urxvt -e sh -c 'semgrep ; bash'" },
  { "shellcheck", "urxvt -e sh -c 'shellcheck ; bash'" },
}
codeauditmenu7 = {
  { "slither", "urxvt -e sh -c 'slither -h ; bash'" },
  { "slither-check-erc", "urxvt -e sh -c 'slither-check-erc ; bash'" },
  { "slither-check-kspec", "urxvt -e sh -c 'slither-check-kspec ; bash'" },
  { "slither-check-upgradeability", "urxvt -e sh -c 'slither-check-upgradeability ; bash'" },
  { "slither-doctor", "urxvt -e sh -c 'slither-doctor ; bash'" },
  { "slither-documentation", "urxvt -e sh -c 'slither-documentation ; bash'" },
  { "slither-find-paths", "urxvt -e sh -c 'slither-find-paths ; bash'" },
  { "slither-flat", "urxvt -e sh -c 'slither-flat ; bash'" },
  { "slither-format", "urxvt -e sh -c 'slither-format ; bash'" },
  { "slither-mutate", "urxvt -e sh -c 'slither-mutate ; bash'" },
  { "slither-read-storage", "urxvt -e sh -c 'slither-read-storage ; bash'" },
  { "slither-simil", "urxvt -e sh -c 'slither-simil ; bash'" },
  { "smalisca", "urxvt -e sh -c 'smalisca --help ; bash'" },
  { "snyk", "urxvt -e sh -c 'snyk -h ; bash'" },
  { "spaf", "urxvt -e sh -c 'spaf -h ; bash'" },
  { "genflagcodes", "urxvt -e sh -c 'genflagcodes ; bash'" },
  { "spotbugs", "urxvt -e sh -c 'spotbugs -h ; bash'" },
  { "addMessages", "urxvt -e sh -c 'addMessages ; bash'" },
  { "computeBugHistory", "urxvt -e sh -c 'computeBugHistory ; bash'" },
  { "convertXmlToText", "urxvt -e sh -c 'convertXmlToText ; bash'" },
}
codeauditmenu8 = {
  { "defectDensity", "urxvt -e sh -c 'defectDensity ; bash'" },
  { "fb", "urxvt -e sh -c 'fb ; bash'" },
  { "fbwrap", "urxvt -e sh -c 'fbwrap ; bash'" },
  { "filterBugs", "urxvt -e sh -c 'filterBugs ; bash'" },
  { "findbugs-msv", "urxvt -e sh -c 'findbugs-msv ; bash'" },
  { "listBugDatabaseInfo", "urxvt -e sh -c 'listBugDatabaseInfo ; bash'" },
  { "mineBugHistory", "urxvt -e sh -c 'mineBugHistory ; bash'" },
  { "printAppVersion", "urxvt -e sh -c 'printAppVersion ; bash'" },
  { "printClass", "urxvt -e sh -c 'printClass ; bash'" },
  { "setBugDatabaseInfo", "urxvt -e sh -c 'setBugDatabaseInfo ; bash'" },
  { "spotbugs", "urxvt -e sh -c 'spotbugs -h ; bash'" },
  { "spotbugs.ico", "urxvt -e sh -c 'spotbugs.ico ; bash'" },
  { "spotbugs2", "urxvt -e sh -c 'spotbugs2 ; bash'" },
  { "unionBugs", "urxvt -e sh -c 'unionBugs ; bash'" },
  { "xpathFind", "urxvt -e sh -c 'xpathFind ; bash'" },
  { "stacoan", "urxvt -e sh -c 'stacoan -h ; bash'" },
  { "jadx", "urxvt -e sh -c 'jadx -h ; bash'" },
  { "jadx-gui", "urxvt -e sh -c 'jadx-gui ; bash'" },
  { "stoq", "urxvt -e sh -c 'stoq -h ; bash'" },
  { "tell-me-your-secrets", "urxvt -e sh -c 'tell-me-your-secrets -h ; bash'" },
}
codeauditmenu9 = {
  { "trufflehog", "urxvt -e sh -c 'trufflehog -h ; bash'" },
  { "callgrind_annotate", "urxvt -e sh -c 'callgrind_annotate ; bash'" },
  { "callgrind_control", "urxvt -e sh -c 'callgrind_control ; bash'" },
  { "cg_annotate", "urxvt -e sh -c 'cg_annotate ; bash'" },
  { "cg_diff", "urxvt -e sh -c 'cg_diff ; bash'" },
  { "cg_merge", "urxvt -e sh -c 'cg_merge ; bash'" },
  { "ms_print", "urxvt -e sh -c 'ms_print ; bash'" },
  { "valgrind", "urxvt -e sh -c 'valgrind ; bash'" },
  { "valgrind-di-server", "urxvt -e sh -c 'valgrind-di-server ; bash'" },
  { "valgrind-listener", "urxvt -e sh -c 'valgrind-listener ; bash'" },
  { "vgdb", "urxvt -e sh -c 'vgdb ; bash'" },
  { "callgrind_annotate", "urxvt -e sh -c 'callgrind_annotate ; bash'" },
  { "callgrind_control", "urxvt -e sh -c 'callgrind_control ; bash'" },
  { "cg_annotate", "urxvt -e sh -c 'cg_annotate ; bash'" },
  { "cg_diff", "urxvt -e sh -c 'cg_diff ; bash'" },
  { "cg_merge", "urxvt -e sh -c 'cg_merge ; bash'" },
  { "ms_print", "urxvt -e sh -c 'ms_print ; bash'" },
  { "valgrind", "urxvt -e sh -c 'valgrind ; bash'" },
  { "valgrind-di-server", "urxvt -e sh -c 'valgrind-di-server ; bash'" },
  { "valgrind-listener", "urxvt -e sh -c 'valgrind-listener ; bash'" },
}
codeauditmenu10 = {
  { "vgdb", "urxvt -e sh -c 'vgdb ; bash'" },
  { "whispers", "urxvt -e sh -c 'whispers -h ; bash'" },
  { "wpbullet", "urxvt -e sh -c 'wpbullet -h ; bash'" },
  { "wscript", "urxvt -e sh -c 'wscript ; bash'" },
  { "acorn", "urxvt -e sh -c 'acorn ; bash'" },
  { "handlebars", "urxvt -e sh -c 'handlebars ; bash'" },
  { "he", "urxvt -e sh -c 'he ; bash'" },
  { "_mocha", "urxvt -e sh -c '_mocha ; bash'" },
  { "mocha", "urxvt -e sh -c 'mocha ; bash'" },
  { "uuid", "urxvt -e sh -c 'uuid ; bash'" },
  { "which", "urxvt -e sh -c 'which ; bash'" },
  { "yasca", "urxvt -e sh -c 'yasca ; bash'" },
}
codeauditmenu = {
  { "1", codeauditmenu1 }
  { "2", codeauditmenu2 }
  { "3", codeauditmenu3 }
  { "4", codeauditmenu4 }
  { "5", codeauditmenu5 }
  { "6", codeauditmenu6 }
  { "7", codeauditmenu7 }
  { "8", codeauditmenu8 }
  { "9", codeauditmenu9 }
  { "10", codeauditmenu10 }
}
configmenu = {
  { "bactl", "urxvt -e sh -c 'bactl ; bash'" },
  { "app", "urxvt -e sh -c 'app ; bash'" },
  { "binary_file", "urxvt -e sh -c 'binary_file ; bash'" },
  { "empty_file", "urxvt -e sh -c 'empty_file ; bash'" },
}
crackermenu1 = {
  { "acccheck", "urxvt -e sh -c 'acccheck -h ; bash'" },
  { "adfspray", "urxvt -e sh -c 'adfspray -h ; bash'" },
  { "aesfix", "urxvt -e sh -c 'aesfix ; bash'" },
  { "against", "urxvt -e sh -c 'against ; bash'" },
  { "androidpincrack", "urxvt -e sh -c 'androidpincrack -h ; bash'" },
  { "asleap", "urxvt -e sh -c 'asleap -h ; bash'" },
  { "auto-eap", "urxvt -e sh -c 'auto-eap -h ; bash'" },
  { "balbuzard", "urxvt -e sh -c 'balbuzard ; bash'" },
  { "bbcrack", "urxvt -e sh -c 'bbcrack ; bash'" },
  { "bbharvest", "urxvt -e sh -c 'bbharvest ; bash'" },
  { "bbtrans", "urxvt -e sh -c 'bbtrans ; bash'" },
  { "beleth", "urxvt -e sh -c 'beleth -h ; bash'" },
  { "pxedump", "urxvt -e sh -c 'pxedump -h ; bash'" },
  { "usbdump", "urxvt -e sh -c 'usbdump -h ; bash'" },
  { "bkcrack", "urxvt -e sh -c 'bkcrack -h ; bash'" },
  { "bkhive", "urxvt -e sh -c 'bkhive -h ; bash'" },
  { "blackbox-scanner", "urxvt -e sh -c 'blackbox-scanner -h ; bash'" },
  { "bob_admin-sse2", "urxvt -e sh -c 'bob_admin-sse2 -h ; bash'" },
  { "bob_client-sse2", "urxvt -e sh -c 'bob_client-sse2 -h ; bash'" },
  { "bob_server-sse2", "urxvt -e sh -c 'bob_server-sse2 -h ; bash'" },
}
crackermenu2 = {
  { "brute-force", "urxvt -e sh -c 'brute-force -h ; bash'" },
  { "bruteforce-luks", "urxvt -e sh -c 'bruteforce-luks -h ; bash'" },
  { "bruteforce-salted-openssl", "urxvt -e sh -c 'bruteforce-salted-openssl -h ; bash'" },
  { "bruteforce-wallet", "urxvt -e sh -c 'bruteforce-wallet ; bash'" },
  { "brutemap", "urxvt -e sh -c 'brutemap -h ; bash'" },
  { "brutespray", "urxvt -e sh -c 'brutespray -h ; bash'" },
  { "brutex", "urxvt -e sh -c 'brutex ; bash'" },
  { "brutex-masscan", "urxvt -e sh -c 'brutex-masscan ; bash'" },
  { "bully", "urxvt -e sh -c 'bully -h ; bash'" },
  { "byepass", "urxvt -e sh -c 'byepass -h ; bash'" },
  { "passtime", "urxvt -e sh -c 'passtime -h ; bash'" },
  { "cewl", "urxvt -e sh -c 'cewl -h ; bash'" },
  { "cewl-fab", "urxvt -e sh -c 'cewl-fab ; bash'" },
  { "chapcrack", "urxvt -e sh -c 'chapcrack -h ; bash'" },
  { "chntpw", "urxvt -e sh -c 'chntpw ; bash'" },
  { "cpnt", "urxvt -e sh -c 'cpnt ; bash'" },
  { "reged", "urxvt -e sh -c 'reged ; bash'" },
  { "chntpw", "urxvt -e sh -c 'chntpw ; bash'" },
  { "cpnt", "urxvt -e sh -c 'cpnt ; bash'" },
  { "reged", "urxvt -e sh -c 'reged ; bash'" },
}
crackermenu3 = {
  { "cintruder", "urxvt -e sh -c 'cintruder -h ; bash'" },
  { "CAT", "urxvt -e sh -c 'CAT ; bash'" },
  { "cisco-auditing-tool", "urxvt -e sh -c 'cisco-auditing-tool ; bash'" },
  { "cisco-ocs", "urxvt -e sh -c 'cisco-ocs ; bash'" },
  { "cisco-scanner", "urxvt -e sh -c 'cisco-scanner -h ; bash'" },
  { "cisco-snmp-enumeration", "urxvt -e sh -c 'cisco-snmp-enumeration ; bash'" },
  { "c5c", "urxvt -e sh -c 'c5c --help ; bash'" },
  { "cisco7crack", "urxvt -e sh -c 'cisco7crack -h ; bash'" },
  { "cmospwd", "urxvt -e sh -c 'cmospwd -h ; bash'" },
  { "compp", "urxvt -e sh -c 'compp -h ; bash'" },
  { "cowpatty", "urxvt -e sh -c 'cowpatty -h ; bash'" },
  { "genpmk", "urxvt -e sh -c 'genpmk -h ; bash'" },
  { "cowpatty", "urxvt -e sh -c 'cowpatty -h ; bash'" },
  { "genpmk", "urxvt -e sh -c 'genpmk -h ; bash'" },
  { "crackhor", "urxvt -e sh -c 'crackhor -h ; bash'" },
  { "crackle", "urxvt -e sh -c 'crackle ; bash'" },
  { "crackqcli", "urxvt -e sh -c 'crackqcli ; bash'" },
  { "crack-standalone", "urxvt -e sh -c 'crack-standalone -h ; bash'" },
  { "crackclient", "urxvt -e sh -c 'crackclient -h ; bash'" },
  { "crackserver", "urxvt -e sh -c 'crackserver -h ; bash'" },
}
crackermenu4 = {
  { "cachedump", "urxvt -e sh -c 'cachedump cd /usr/share/windows/cachedump ; ls ; bash'" },
  { "lsadump", "urxvt -e sh -c 'lsadump ; bash'" },
  { "pwdump", "urxvt -e sh -c 'pwdump cd /usr/share/windows/pwdump ; ls ; bash'" },
  { "crowbar", "urxvt -e sh -c 'crowbar --help ; bash'" },
  { "cryptohazemultiforcer", "urxvt -e sh -c 'cryptohazemultiforcer ; bash'" },
  { "cupp", "urxvt -e sh -c 'cupp ; bash'" },
  { "dbpwaudit", "urxvt -e sh -c 'dbpwaudit -h ; bash'" },
  { "delldrac", "urxvt -e sh -c 'delldrac -h ; bash'" },
  { "depant", "urxvt -e sh -c 'depant ; bash'" },
  { "device-pharmer", "urxvt -e sh -c 'device-pharmer -h ; bash'" },
  { "domi-owned", "urxvt -e sh -c 'domi-owned -h ; bash'" },
  { "doozer", "urxvt -e sh -c 'doozer ; bash'" },
  { "doozer-monitor", "urxvt -e sh -c 'doozer-monitor ; bash'" },
  { "doozestop", "urxvt -e sh -c 'doozestop ; bash'" },
  { "dpeparser", "urxvt -e sh -c 'dpeparser -h ; bash'" },
  { "enabler", "urxvt -e sh -c 'enabler ; bash'" },
  { "bin-seeds", "urxvt -e sh -c 'bin-seeds ; bash'" },
  { "bruteforce-erldp", "urxvt -e sh -c 'bruteforce-erldp ; bash'" },
  { "crack-prng", "urxvt -e sh -c 'crack-prng ; bash'" },
  { "dictionary-erldp", "urxvt -e sh -c 'dictionary-erldp -h ; bash'" },
}
crackermenu5 = {
  { "erldp-proxy", "urxvt -e sh -c 'erldp-proxy -h ; bash'" },
  { "shell-erldp", "urxvt -e sh -c 'shell-erldp -h ; bash'" },
  { "sweep-default-cookie", "urxvt -e sh -c 'sweep-default-cookie -h ; bash'" },
  { "evilize", "urxvt -e sh -c 'evilize -h ; bash'" },
  { "f-scrack", "urxvt -e sh -c 'f-scrack ; bash'" },
  { "facebrute", "urxvt -e sh -c 'facebrute -h ; bash'" },
  { "fang", "urxvt -e sh -c 'fang -h ; bash'" },
  { "fern-wifi-cracker", "urxvt -e sh -c 'fern-wifi-cracker ; bash'" },
  { "ftp-scanner", "urxvt -e sh -c 'ftp-scanner -h ; bash'" },
  { "ftp-spider", "urxvt -e sh -c 'ftp-spider -h ; bash'" },
  { "gomapenum", "urxvt -e sh -c 'gomapenum -h ; bash'" },
  { "gpocrack", "urxvt -e sh -c 'gpocrack -h ; bash'" },
  { "habu.arp.ping", "urxvt -e sh -c 'habu.arp.ping ; bash'" },
  { "habu.arp.poison", "urxvt -e sh -c 'habu.arp.poison ; bash'" },
  { "habu.arp.sniff", "urxvt -e sh -c 'habu.arp.sniff ; bash'" },
  { "habu.asydns", "urxvt -e sh -c 'habu.asydns ; bash'" },
  { "habu.b64", "urxvt -e sh -c 'habu.b64 ; bash'" },
  { "habu.cert.clone", "urxvt -e sh -c 'habu.cert.clone ; bash'" },
  { "habu.cert.names", "urxvt -e sh -c 'habu.cert.names ; bash'" },
  { "habu.crack.luhn", "urxvt -e sh -c 'habu.crack.luhn ; bash'" },
}
crackermenu6 = {
  { "habu.crack.snmp", "urxvt -e sh -c 'habu.crack.snmp ; bash'" },
  { "habu.crypto.fernet", "urxvt -e sh -c 'habu.crypto.fernet ; bash'" },
  { "habu.crypto.gppref", "urxvt -e sh -c 'habu.crypto.gppref ; bash'" },
  { "habu.crypto.xor", "urxvt -e sh -c 'habu.crypto.xor ; bash'" },
  { "habu.data.enrich", "urxvt -e sh -c 'habu.data.enrich ; bash'" },
  { "habu.data.extract.domain", "urxvt -e sh -c 'habu.data.extract.domain ; bash'" },
  { "habu.data.extract.email", "urxvt -e sh -c 'habu.data.extract.email ; bash'" },
  { "habu.data.extract.fqdn", "urxvt -e sh -c 'habu.data.extract.fqdn ; bash'" },
  { "habu.data.extract.ipv4", "urxvt -e sh -c 'habu.data.extract.ipv4 ; bash'" },
  { "habu.data.filter", "urxvt -e sh -c 'habu.data.filter ; bash'" },
  { "habu.data.select", "urxvt -e sh -c 'habu.data.select ; bash'" },
  { "habu.dhcp.discover", "urxvt -e sh -c 'habu.dhcp.discover ; bash'" },
  { "habu.dhcp.starvation", "urxvt -e sh -c 'habu.dhcp.starvation ; bash'" },
  { "habu.dns.lookup.forward", "urxvt -e sh -c 'habu.dns.lookup.forward ; bash'" },
  { "habu.dns.lookup.reverse", "urxvt -e sh -c 'habu.dns.lookup.reverse ; bash'" },
  { "habu.eicar", "urxvt -e sh -c 'habu.eicar ; bash'" },
  { "habu.forkbomb", "urxvt -e sh -c 'habu.forkbomb ; bash'" },
  { "habu.fqdn.finder", "urxvt -e sh -c 'habu.fqdn.finder ; bash'" },
  { "habu.gateway.find", "urxvt -e sh -c 'habu.gateway.find ; bash'" },
  { "habu.host", "urxvt -e sh -c 'habu.host ; bash'" },
}
crackermenu7 = {
  { "habu.http.headers", "urxvt -e sh -c 'habu.http.headers ; bash'" },
  { "habu.http.options", "urxvt -e sh -c 'habu.http.options ; bash'" },
  { "habu.http.tech", "urxvt -e sh -c 'habu.http.tech ; bash'" },
  { "habu.icmp.ping", "urxvt -e sh -c 'habu.icmp.ping ; bash'" },
  { "habu.ip.asn", "urxvt -e sh -c 'habu.ip.asn ; bash'" },
  { "habu.ip.geolocation", "urxvt -e sh -c 'habu.ip.geolocation ; bash'" },
  { "habu.ip.internal", "urxvt -e sh -c 'habu.ip.internal ; bash'" },
  { "habu.ip.public", "urxvt -e sh -c 'habu.ip.public ; bash'" },
  { "habu.karma", "urxvt -e sh -c 'habu.karma ; bash'" },
  { "habu.karma.bulk", "urxvt -e sh -c 'habu.karma.bulk ; bash'" },
  { "habu.land", "urxvt -e sh -c 'habu.land ; bash'" },
  { "habu.nc", "urxvt -e sh -c 'habu.nc ; bash'" },
  { "habu.net.contest", "urxvt -e sh -c 'habu.net.contest ; bash'" },
  { "habu.net.interfaces", "urxvt -e sh -c 'habu.net.interfaces ; bash'" },
  { "habu.nmap.excluded", "urxvt -e sh -c 'habu.nmap.excluded ; bash'" },
  { "habu.nmap.open", "urxvt -e sh -c 'habu.nmap.open ; bash'" },
  { "habu.nmap.ports", "urxvt -e sh -c 'habu.nmap.ports ; bash'" },
  { "habu.protoscan", "urxvt -e sh -c 'habu.protoscan ; bash'" },
  { "habu.server.ftp", "urxvt -e sh -c 'habu.server.ftp ; bash'" },
  { "habu.tcp.flags", "urxvt -e sh -c 'habu.tcp.flags ; bash'" },
}
crackermenu8 = {
  { "habu.tcp.isn", "urxvt -e sh -c 'habu.tcp.isn ; bash'" },
  { "habu.tcp.scan", "urxvt -e sh -c 'habu.tcp.scan ; bash'" },
  { "habu.tcp.synflood", "urxvt -e sh -c 'habu.tcp.synflood ; bash'" },
  { "habu.traceroute", "urxvt -e sh -c 'habu.traceroute ; bash'" },
  { "habu.upgrade", "urxvt -e sh -c 'habu.upgrade ; bash'" },
  { "habu.usercheck", "urxvt -e sh -c 'habu.usercheck ; bash'" },
  { "habu.version", "urxvt -e sh -c 'habu.version ; bash'" },
  { "habu.vhosts", "urxvt -e sh -c 'habu.vhosts ; bash'" },
  { "habu.virustotal", "urxvt -e sh -c 'habu.virustotal ; bash'" },
  { "habu.web.report", "urxvt -e sh -c 'habu.web.report ; bash'" },
  { "habu.whois.domain", "urxvt -e sh -c 'habu.whois.domain ; bash'" },
  { "habu.whois.ip", "urxvt -e sh -c 'habu.whois.ip ; bash'" },
  { "hate-crack", "urxvt -e sh -c 'hate-crack ; bash'" },
  { "hdmi-sniff", "urxvt -e sh -c 'hdmi-sniff -h ; bash'" },
  { "htpwdscan", "urxvt -e sh -c 'htpwdscan -h ; bash'" },
  { "hydra", "urxvt -e sh -c 'hydra -h ; bash'" },
  { "pw-inspector", "urxvt -e sh -c 'pw-inspector -h ; bash'" },
  { "hydra", "urxvt -e sh -c 'hydra -h ; bash'" },
  { "pw-inspector", "urxvt -e sh -c 'pw-inspector -h ; bash'" },
  { "iax-scan-hosts", "urxvt -e sh -c 'iax-scan-hosts -h ; bash'" },
}
crackermenu9 = {
  { "iax-scan-users", "urxvt -e sh -c 'iax-scan-users -h ; bash'" },
  { "ibrute", "urxvt -e sh -c 'ibrute -h ; bash'" },
  { "icloudbrutter", "urxvt -e sh -c 'icloudbrutter ; bash'" },
  { "iheartxor", "urxvt -e sh -c 'iheartxor ; bash'" },
  { "iisbf", "urxvt -e sh -c 'iisbf ; bash'" },
  { "ikecrack-snarf", "urxvt -e sh -c 'ikecrack-snarf ; bash'" },
  { "ikeforce", "urxvt -e sh -c 'ikeforce -h ; bash'" },
  { "inguma", "urxvt -e sh -c 'inguma -h ; bash'" },
  { "ingumagui", "urxvt -e sh -c 'ingumagui ; bash'" },
  { "interrogate", "urxvt -e sh -c 'interrogate -h ; bash'" },
  { "ipmipwn", "urxvt -e sh -c 'ipmipwn ; bash'" },
  { "iptv-cli", "urxvt -e sh -c 'iptv-cli ; bash'" },
  { "iptv-gui", "urxvt -e sh -c 'iptv-gui ; bash'" },
  { "jbrute", "urxvt -e sh -c 'jbrute --help ; bash'" },
  { "1password2john", "urxvt -e sh -c '1password2john ; bash'" },
  { "7z2john", "urxvt -e sh -c '7z2john ; bash'" },
  { "DPAPImk2john", "urxvt -e sh -c 'DPAPImk2john ; bash'" },
  { "SIPdump", "urxvt -e sh -c 'SIPdump ; bash'" },
  { "adxcsouf2john", "urxvt -e sh -c 'adxcsouf2john ; bash'" },
  { "aem2john", "urxvt -e sh -c 'aem2john ; bash'" },
}
crackermenu10 = {
  { "aix2john", "urxvt -e sh -c 'aix2john ; bash'" },
  { "andotp2john", "urxvt -e sh -c 'andotp2john ; bash'" },
  { "androidbackup2john", "urxvt -e sh -c 'androidbackup2john ; bash'" },
  { "androidfde2john", "urxvt -e sh -c 'androidfde2john ; bash'" },
  { "ansible2john", "urxvt -e sh -c 'ansible2john ; bash'" },
  { "apex2john", "urxvt -e sh -c 'apex2john ; bash'" },
  { "aruba2john", "urxvt -e sh -c 'aruba2john ; bash'" },
  { "axcrypt2john", "urxvt -e sh -c 'axcrypt2john ; bash'" },
  { "base64conv", "urxvt -e sh -c 'base64conv ; bash'" },
  { "bestcrypt2john", "urxvt -e sh -c 'bestcrypt2john ; bash'" },
  { "bitcoin2john", "urxvt -e sh -c 'bitcoin2john ; bash'" },
  { "bitlocker2john", "urxvt -e sh -c 'bitlocker2john ; bash'" },
  { "bitwarden2john", "urxvt -e sh -c 'bitwarden2john ; bash'" },
  { "bks2john", "urxvt -e sh -c 'bks2john ; bash'" },
  { "blockchain2john", "urxvt -e sh -c 'blockchain2john ; bash'" },
  { "calc_stat", "urxvt -e sh -c 'calc_stat ; bash'" },
  { "cisco2john", "urxvt -e sh -c 'cisco2john ; bash'" },
  { "codepage", "urxvt -e sh -c 'codepage ; bash'" },
  { "cprepair", "urxvt -e sh -c 'cprepair ; bash'" },
  { "cracf2john", "urxvt -e sh -c 'cracf2john ; bash'" },
}
crackermenu11 = {
  { "diskcryptor2john", "urxvt -e sh -c 'diskcryptor2john ; bash'" },
  { "dmg2john", "urxvt -e sh -c 'dmg2john ; bash'" },
  { "ecryptfs2john", "urxvt -e sh -c 'ecryptfs2john ; bash'" },
  { "ejabberd2john", "urxvt -e sh -c 'ejabberd2john ; bash'" },
  { "electrum2john", "urxvt -e sh -c 'electrum2john ; bash'" },
  { "encfs2john", "urxvt -e sh -c 'encfs2john ; bash'" },
  { "enpass2john", "urxvt -e sh -c 'enpass2john ; bash'" },
  { "ethereum2john", "urxvt -e sh -c 'ethereum2john ; bash'" },
  { "filezilla2john", "urxvt -e sh -c 'filezilla2john ; bash'" },
  { "fuzz_option", "urxvt -e sh -c 'fuzz_option ; bash'" },
  { "geli2john", "urxvt -e sh -c 'geli2john ; bash'" },
  { "genincstats", "urxvt -e sh -c 'genincstats ; bash'" },
  { "genmkvpwd", "urxvt -e sh -c 'genmkvpwd ; bash'" },
  { "gpg2john", "urxvt -e sh -c 'gpg2john ; bash'" },
  { "hccap2john", "urxvt -e sh -c 'hccap2john ; bash'" },
  { "hccapx2john", "urxvt -e sh -c 'hccapx2john ; bash'" },
  { "hextoraw", "urxvt -e sh -c 'hextoraw ; bash'" },
  { "htdigest2john", "urxvt -e sh -c 'htdigest2john ; bash'" },
  { "ibmiscanner2john", "urxvt -e sh -c 'ibmiscanner2john ; bash'" },
  { "ikescan2john", "urxvt -e sh -c 'ikescan2john ; bash'" },
}
crackermenu12 = {
  { "ios7tojohn", "urxvt -e sh -c 'ios7tojohn ; bash'" },
  { "itunes_backup2john", "urxvt -e sh -c 'itunes_backup2john ; bash'" },
  { "iwork2john", "urxvt -e sh -c 'iwork2john ; bash'" },
  { "john", "urxvt -e sh -c 'john ; bash'" },
  { "kdcdump2john", "urxvt -e sh -c 'kdcdump2john ; bash'" },
  { "keepass2john", "urxvt -e sh -c 'keepass2john ; bash'" },
  { "keychain2john", "urxvt -e sh -c 'keychain2john ; bash'" },
  { "keyring2john", "urxvt -e sh -c 'keyring2john ; bash'" },
  { "keystore2john", "urxvt -e sh -c 'keystore2john ; bash'" },
  { "known_hosts2john", "urxvt -e sh -c 'known_hosts2john ; bash'" },
  { "kwallet2john", "urxvt -e sh -c 'kwallet2john ; bash'" },
  { "lastpass2john", "urxvt -e sh -c 'lastpass2john ; bash'" },
  { "ldif2john", "urxvt -e sh -c 'ldif2john ; bash'" },
  { "leet", "urxvt -e sh -c 'leet ; bash'" },
  { "libreoffice2john", "urxvt -e sh -c 'libreoffice2john ; bash'" },
  { "lion2john", "urxvt -e sh -c 'lion2john ; bash'" },
  { "lion2john-alt", "urxvt -e sh -c 'lion2john-alt ; bash'" },
  { "lotus2john", "urxvt -e sh -c 'lotus2john ; bash'" },
  { "luks2john", "urxvt -e sh -c 'luks2john ; bash'" },
  { "mac2john", "urxvt -e sh -c 'mac2john ; bash'" },
}
crackermenu13 = {
  { "mac2john-alt", "urxvt -e sh -c 'mac2john-alt ; bash'" },
  { "mcafee_epo2john", "urxvt -e sh -c 'mcafee_epo2john ; bash'" },
  { "mkvcalcproba", "urxvt -e sh -c 'mkvcalcproba ; bash'" },
  { "monero2john", "urxvt -e sh -c 'monero2john ; bash'" },
  { "money2john", "urxvt -e sh -c 'money2john ; bash'" },
  { "mozilla2john", "urxvt -e sh -c 'mozilla2john ; bash'" },
  { "multibit2john", "urxvt -e sh -c 'multibit2john ; bash'" },
  { "neo2john", "urxvt -e sh -c 'neo2john ; bash'" },
  { "netntlm", "urxvt -e sh -c 'netntlm ; bash'" },
  { "netscreen", "urxvt -e sh -c 'netscreen ; bash'" },
  { "network2john", "urxvt -e sh -c 'network2john ; bash'" },
  { "office2john", "urxvt -e sh -c 'office2john ; bash'" },
  { "openbsd_softraid2john", "urxvt -e sh -c 'openbsd_softraid2john ; bash'" },
  { "openssl2john", "urxvt -e sh -c 'openssl2john ; bash'" },
  { "padlock2john", "urxvt -e sh -c 'padlock2john ; bash'" },
  { "pass_gen", "urxvt -e sh -c 'pass_gen ; bash'" },
  { "pcap2john", "urxvt -e sh -c 'pcap2john ; bash'" },
  { "pdf2john", "urxvt -e sh -c 'pdf2john ; bash'" },
  { "pem2john", "urxvt -e sh -c 'pem2john ; bash'" },
  { "pfx2john", "urxvt -e sh -c 'pfx2john ; bash'" },
}
crackermenu14 = {
  { "pgpdisk2john", "urxvt -e sh -c 'pgpdisk2john ; bash'" },
  { "pgpwde2john", "urxvt -e sh -c 'pgpwde2john ; bash'" },
  { "potcheck", "urxvt -e sh -c 'potcheck ; bash'" },
  { "prosody2john", "urxvt -e sh -c 'prosody2john ; bash'" },
  { "ps_token2john", "urxvt -e sh -c 'ps_token2john ; bash'" },
  { "pse2john", "urxvt -e sh -c 'pse2john ; bash'" },
  { "putty2john", "urxvt -e sh -c 'putty2john ; bash'" },
  { "pwsafe2john", "urxvt -e sh -c 'pwsafe2john ; bash'" },
  { "racf2john", "urxvt -e sh -c 'racf2john ; bash'" },
  { "radius2john", "urxvt -e sh -c 'radius2john ; bash'" },
  { "rar2john", "urxvt -e sh -c 'rar2john ; bash'" },
  { "raw2dyna", "urxvt -e sh -c 'raw2dyna ; bash'" },
  { "rexgen2rules", "urxvt -e sh -c 'rexgen2rules ; bash'" },
  { "rulestack", "urxvt -e sh -c 'rulestack ; bash'" },
  { "sap2john", "urxvt -e sh -c 'sap2john ; bash'" },
  { "sha-dump", "urxvt -e sh -c 'sha-dump ; bash'" },
  { "sha-test", "urxvt -e sh -c 'sha-test ; bash'" },
  { "signal2john", "urxvt -e sh -c 'signal2john ; bash'" },
  { "sipdump2john", "urxvt -e sh -c 'sipdump2john ; bash'" },
  { "sspr2john", "urxvt -e sh -c 'sspr2john ; bash'" },
}
crackermenu15 = {
  { "staroffice2john", "urxvt -e sh -c 'staroffice2john ; bash'" },
  { "strip2john", "urxvt -e sh -c 'strip2john ; bash'" },
  { "telegram2john", "urxvt -e sh -c 'telegram2john ; bash'" },
  { "tezos2john", "urxvt -e sh -c 'tezos2john ; bash'" },
  { "truecrypt2john", "urxvt -e sh -c 'truecrypt2john ; bash'" },
  { "uaf2john", "urxvt -e sh -c 'uaf2john ; bash'" },
  { "unafs", "urxvt -e sh -c 'unafs ; bash'" },
  { "undrop", "urxvt -e sh -c 'undrop ; bash'" },
  { "unique", "urxvt -e sh -c 'unique ; bash'" },
  { "unrule", "urxvt -e sh -c 'unrule ; bash'" },
  { "vdi2john", "urxvt -e sh -c 'vdi2john ; bash'" },
  { "vmx2john", "urxvt -e sh -c 'vmx2john ; bash'" },
  { "vncpcap2john", "urxvt -e sh -c 'vncpcap2john ; bash'" },
  { "wpapcap2john", "urxvt -e sh -c 'wpapcap2john ; bash'" },
  { "zip2john", "urxvt -e sh -c 'zip2john ; bash'" },
  { "1password2john", "urxvt -e sh -c '1password2john ; bash'" },
  { "7z2john", "urxvt -e sh -c '7z2john ; bash'" },
  { "DPAPImk2john", "urxvt -e sh -c 'DPAPImk2john ; bash'" },
  { "SIPdump", "urxvt -e sh -c 'SIPdump ; bash'" },
  { "adxcsouf2john", "urxvt -e sh -c 'adxcsouf2john ; bash'" },
}
crackermenu16 = {
  { "aem2john", "urxvt -e sh -c 'aem2john ; bash'" },
  { "aix2john", "urxvt -e sh -c 'aix2john ; bash'" },
  { "andotp2john", "urxvt -e sh -c 'andotp2john ; bash'" },
  { "androidbackup2john", "urxvt -e sh -c 'androidbackup2john ; bash'" },
  { "androidfde2john", "urxvt -e sh -c 'androidfde2john ; bash'" },
  { "ansible2john", "urxvt -e sh -c 'ansible2john ; bash'" },
  { "apex2john", "urxvt -e sh -c 'apex2john ; bash'" },
  { "aruba2john", "urxvt -e sh -c 'aruba2john ; bash'" },
  { "axcrypt2john", "urxvt -e sh -c 'axcrypt2john ; bash'" },
  { "base64conv", "urxvt -e sh -c 'base64conv ; bash'" },
  { "bestcrypt2john", "urxvt -e sh -c 'bestcrypt2john ; bash'" },
  { "bitcoin2john", "urxvt -e sh -c 'bitcoin2john ; bash'" },
  { "bitlocker2john", "urxvt -e sh -c 'bitlocker2john ; bash'" },
  { "bitwarden2john", "urxvt -e sh -c 'bitwarden2john ; bash'" },
  { "bks2john", "urxvt -e sh -c 'bks2john ; bash'" },
  { "blockchain2john", "urxvt -e sh -c 'blockchain2john ; bash'" },
  { "calc_stat", "urxvt -e sh -c 'calc_stat ; bash'" },
  { "cisco2john", "urxvt -e sh -c 'cisco2john ; bash'" },
  { "codepage", "urxvt -e sh -c 'codepage ; bash'" },
  { "cprepair", "urxvt -e sh -c 'cprepair ; bash'" },
}
crackermenu17 = {
  { "cracf2john", "urxvt -e sh -c 'cracf2john ; bash'" },
  { "diskcryptor2john", "urxvt -e sh -c 'diskcryptor2john ; bash'" },
  { "dmg2john", "urxvt -e sh -c 'dmg2john ; bash'" },
  { "ecryptfs2john", "urxvt -e sh -c 'ecryptfs2john ; bash'" },
  { "ejabberd2john", "urxvt -e sh -c 'ejabberd2john ; bash'" },
  { "electrum2john", "urxvt -e sh -c 'electrum2john ; bash'" },
  { "encfs2john", "urxvt -e sh -c 'encfs2john ; bash'" },
  { "enpass2john", "urxvt -e sh -c 'enpass2john ; bash'" },
  { "ethereum2john", "urxvt -e sh -c 'ethereum2john ; bash'" },
  { "filezilla2john", "urxvt -e sh -c 'filezilla2john ; bash'" },
  { "fuzz_option", "urxvt -e sh -c 'fuzz_option ; bash'" },
  { "geli2john", "urxvt -e sh -c 'geli2john ; bash'" },
  { "genincstats", "urxvt -e sh -c 'genincstats ; bash'" },
  { "genmkvpwd", "urxvt -e sh -c 'genmkvpwd ; bash'" },
  { "gpg2john", "urxvt -e sh -c 'gpg2john ; bash'" },
  { "hccap2john", "urxvt -e sh -c 'hccap2john ; bash'" },
  { "hccapx2john", "urxvt -e sh -c 'hccapx2john ; bash'" },
  { "hextoraw", "urxvt -e sh -c 'hextoraw ; bash'" },
  { "htdigest2john", "urxvt -e sh -c 'htdigest2john ; bash'" },
  { "ibmiscanner2john", "urxvt -e sh -c 'ibmiscanner2john ; bash'" },
}
crackermenu18 = {
  { "ikescan2john", "urxvt -e sh -c 'ikescan2john ; bash'" },
  { "ios7tojohn", "urxvt -e sh -c 'ios7tojohn ; bash'" },
  { "itunes_backup2john", "urxvt -e sh -c 'itunes_backup2john ; bash'" },
  { "iwork2john", "urxvt -e sh -c 'iwork2john ; bash'" },
  { "john", "urxvt -e sh -c 'john ; bash'" },
  { "kdcdump2john", "urxvt -e sh -c 'kdcdump2john ; bash'" },
  { "keepass2john", "urxvt -e sh -c 'keepass2john ; bash'" },
  { "keychain2john", "urxvt -e sh -c 'keychain2john ; bash'" },
  { "keyring2john", "urxvt -e sh -c 'keyring2john ; bash'" },
  { "keystore2john", "urxvt -e sh -c 'keystore2john ; bash'" },
  { "known_hosts2john", "urxvt -e sh -c 'known_hosts2john ; bash'" },
  { "kwallet2john", "urxvt -e sh -c 'kwallet2john ; bash'" },
  { "lastpass2john", "urxvt -e sh -c 'lastpass2john ; bash'" },
  { "ldif2john", "urxvt -e sh -c 'ldif2john ; bash'" },
  { "leet", "urxvt -e sh -c 'leet ; bash'" },
  { "libreoffice2john", "urxvt -e sh -c 'libreoffice2john ; bash'" },
  { "lion2john", "urxvt -e sh -c 'lion2john ; bash'" },
  { "lion2john-alt", "urxvt -e sh -c 'lion2john-alt ; bash'" },
  { "lotus2john", "urxvt -e sh -c 'lotus2john ; bash'" },
  { "luks2john", "urxvt -e sh -c 'luks2john ; bash'" },
}
crackermenu19 = {
  { "mac2john", "urxvt -e sh -c 'mac2john ; bash'" },
  { "mac2john-alt", "urxvt -e sh -c 'mac2john-alt ; bash'" },
  { "mcafee_epo2john", "urxvt -e sh -c 'mcafee_epo2john ; bash'" },
  { "mkvcalcproba", "urxvt -e sh -c 'mkvcalcproba ; bash'" },
  { "monero2john", "urxvt -e sh -c 'monero2john ; bash'" },
  { "money2john", "urxvt -e sh -c 'money2john ; bash'" },
  { "mozilla2john", "urxvt -e sh -c 'mozilla2john ; bash'" },
  { "multibit2john", "urxvt -e sh -c 'multibit2john ; bash'" },
  { "neo2john", "urxvt -e sh -c 'neo2john ; bash'" },
  { "netntlm", "urxvt -e sh -c 'netntlm ; bash'" },
  { "netscreen", "urxvt -e sh -c 'netscreen ; bash'" },
  { "network2john", "urxvt -e sh -c 'network2john ; bash'" },
  { "office2john", "urxvt -e sh -c 'office2john ; bash'" },
  { "openbsd_softraid2john", "urxvt -e sh -c 'openbsd_softraid2john ; bash'" },
  { "openssl2john", "urxvt -e sh -c 'openssl2john ; bash'" },
  { "padlock2john", "urxvt -e sh -c 'padlock2john ; bash'" },
  { "pass_gen", "urxvt -e sh -c 'pass_gen ; bash'" },
  { "pcap2john", "urxvt -e sh -c 'pcap2john ; bash'" },
  { "pdf2john", "urxvt -e sh -c 'pdf2john ; bash'" },
  { "pem2john", "urxvt -e sh -c 'pem2john ; bash'" },
}
crackermenu20 = {
  { "pfx2john", "urxvt -e sh -c 'pfx2john ; bash'" },
  { "pgpdisk2john", "urxvt -e sh -c 'pgpdisk2john ; bash'" },
  { "pgpwde2john", "urxvt -e sh -c 'pgpwde2john ; bash'" },
  { "potcheck", "urxvt -e sh -c 'potcheck ; bash'" },
  { "prosody2john", "urxvt -e sh -c 'prosody2john ; bash'" },
  { "ps_token2john", "urxvt -e sh -c 'ps_token2john ; bash'" },
  { "pse2john", "urxvt -e sh -c 'pse2john ; bash'" },
  { "putty2john", "urxvt -e sh -c 'putty2john ; bash'" },
  { "pwsafe2john", "urxvt -e sh -c 'pwsafe2john ; bash'" },
  { "racf2john", "urxvt -e sh -c 'racf2john ; bash'" },
  { "radius2john", "urxvt -e sh -c 'radius2john ; bash'" },
  { "rar2john", "urxvt -e sh -c 'rar2john ; bash'" },
  { "raw2dyna", "urxvt -e sh -c 'raw2dyna ; bash'" },
  { "rexgen2rules", "urxvt -e sh -c 'rexgen2rules ; bash'" },
  { "rulestack", "urxvt -e sh -c 'rulestack ; bash'" },
  { "sap2john", "urxvt -e sh -c 'sap2john ; bash'" },
  { "sha-dump", "urxvt -e sh -c 'sha-dump ; bash'" },
  { "sha-test", "urxvt -e sh -c 'sha-test ; bash'" },
  { "signal2john", "urxvt -e sh -c 'signal2john ; bash'" },
  { "sipdump2john", "urxvt -e sh -c 'sipdump2john ; bash'" },
}
crackermenu21 = {
  { "sspr2john", "urxvt -e sh -c 'sspr2john ; bash'" },
  { "staroffice2john", "urxvt -e sh -c 'staroffice2john ; bash'" },
  { "strip2john", "urxvt -e sh -c 'strip2john ; bash'" },
  { "telegram2john", "urxvt -e sh -c 'telegram2john ; bash'" },
  { "tezos2john", "urxvt -e sh -c 'tezos2john ; bash'" },
  { "truecrypt2john", "urxvt -e sh -c 'truecrypt2john ; bash'" },
  { "uaf2john", "urxvt -e sh -c 'uaf2john ; bash'" },
  { "unafs", "urxvt -e sh -c 'unafs ; bash'" },
  { "undrop", "urxvt -e sh -c 'undrop ; bash'" },
  { "unique", "urxvt -e sh -c 'unique ; bash'" },
  { "unrule", "urxvt -e sh -c 'unrule ; bash'" },
  { "vdi2john", "urxvt -e sh -c 'vdi2john ; bash'" },
  { "vmx2john", "urxvt -e sh -c 'vmx2john ; bash'" },
  { "vncpcap2john", "urxvt -e sh -c 'vncpcap2john ; bash'" },
  { "wpapcap2john", "urxvt -e sh -c 'wpapcap2john ; bash'" },
  { "zip2john", "urxvt -e sh -c 'zip2john ; bash'" },
  { "johnny", "urxvt -e sh -c 'johnny ; bash'" },
  { "jooforce", "urxvt -e sh -c 'jooforce ; bash'" },
  { "jwt-cracker", "urxvt -e sh -c 'jwt-cracker ; bash'" },
  { "jwt-hack", "urxvt -e sh -c 'jwt-hack -h ; bash'" },
}
crackermenu22 = {
  { "jwt-tool", "urxvt -e sh -c 'jwt-tool -h ; bash'" },
  { "jwtcat", "urxvt -e sh -c 'jwtcat -h ; bash'" },
  { "katana-framework-ktf.gui", "urxvt -e sh -c 'katana-framework-ktf.gui ; bash'" },
  { "katana-framework-ktfconsole", "urxvt -e sh -c 'katana-framework-ktfconsole ; bash'" },
  { "katana-framework-ktfktf", "urxvt -e sh -c 'katana-framework-ktfktf ; bash'" },
  { "katana-framework-ktflinker", "urxvt -e sh -c 'katana-framework-ktflinker ; bash'" },
  { "katana-framework-ktfrun", "urxvt -e sh -c 'katana-framework-ktfrun ; bash'" },
  { "katana-framework-ktfupdate", "urxvt -e sh -c 'katana-framework-ktfupdate ; bash'" },
  { "keimpx", "urxvt -e sh -c 'keimpx -h ; bash'" },
  { "khc", "urxvt -e sh -c 'khc ; bash'" },
  { "ldap-brute", "urxvt -e sh -c 'ldap-brute -h ; bash'" },
  { "leviathan", "urxvt -e sh -c 'leviathan ; bash'" },
  { "levye", "urxvt -e sh -c 'levye -h ; bash'" },
  { "linset", "urxvt -e sh -c 'linset ; bash'" },
  { "lodowep", "urxvt -e sh -c 'lodowep -h ; bash'" },
  { "lyricpass", "urxvt -e sh -c 'lyricpass -h ; bash'" },
  { "mdcrack", "urxvt -e sh -c 'mdcrack ; bash'" },
  { "medusa", "urxvt -e sh -c 'medusa -h ; bash'" },
  { "mentalist", "urxvt -e sh -c 'mentalist ; bash'" },
  { "mfoc", "urxvt -e sh -c 'mfoc -h ; bash'" },
}
crackermenu23 = {
  { "mimipenguin", "urxvt -e sh -c 'mimipenguin ; bash'" },
  { "mkbrutus", "urxvt -e sh -c 'mkbrutus -h ; bash'" },
  { "morxbook", "urxvt -e sh -c 'morxbook ; bash'" },
  { "morxbrute", "urxvt -e sh -c 'morxbrute ; bash'" },
  { "morxbtcrack", "urxvt -e sh -c 'morxbtcrack ; bash'" },
  { "morxcoinpwn", "urxvt -e sh -c 'morxcoinpwn ; bash'" },
  { "morxcrack", "urxvt -e sh -c 'morxcrack -h ; bash'" },
  { "mybff", "urxvt -e sh -c 'mybff -h ; bash'" },
  { "myjwt", "urxvt -e sh -c 'myjwt -h ; bash'" },
  { "ncrack", "urxvt -e sh -c 'ncrack -h ; bash'" },
  { "o365enum", "urxvt -e sh -c 'o365enum -h ; bash'" },
  { "o365spray", "urxvt -e sh -c 'o365spray -h ; bash'" },
  { "obevilion", "urxvt -e sh -c 'obevilion --help ; bash'" },
  { "ocs-cisco", "urxvt -e sh -c 'ocs-cisco ; bash'" },
  { "omen-alphabetcreator", "urxvt -e sh -c 'omen-alphabetcreator -h ; bash'" },
  { "omen-createng", "urxvt -e sh -c 'omen-createng -h ; bash'" },
  { "omen-enumng", "urxvt -e sh -c 'omen-enumng -h ; bash'" },
  { "omen-evalpw", "urxvt -e sh -c 'omen-evalpw -h ; bash'" },
  { "onesixtyone", "urxvt -e sh -c 'onesixtyone ; bash'" },
  { "ophcrack", "urxvt -e sh -c 'ophcrack -h ; bash'" },
}
crackermenu24 = {
  { "owabf", "urxvt -e sh -c 'owabf -h ; bash'" },
  { "maskgen", "urxvt -e sh -c 'maskgen -h ; bash'" },
  { "policygen", "urxvt -e sh -c 'policygen -h ; bash'" },
  { "rulegen", "urxvt -e sh -c 'rulegen -h ; bash'" },
  { "statsgen", "urxvt -e sh -c 'statsgen -h ; bash'" },
  { "passcracking", "urxvt -e sh -c 'passcracking ; bash'" },
  { "passe-partout", "urxvt -e sh -c 'passe-partout -h ; bash'" },
  { "patator", "urxvt -e sh -c 'patator --help ; bash'" },
  { "pdfcrack", "urxvt -e sh -c 'pdfcrack ; bash'" },
  { "pdgmail", "urxvt -e sh -c 'pdgmail -h ; bash'" },
  { "pemcrack", "urxvt -e sh -c 'pemcrack ; bash'" },
  { "pemcracker", "urxvt -e sh -c 'pemcracker ; bash'" },
  { "PHoss", "urxvt -e sh -c 'PHoss -h ; bash'" },
  { "php-mt-seed", "urxvt -e sh -c 'php-mt-seed ; bash'" },
  { "phrasendrescher", "urxvt -e sh -c 'phrasendrescher -h ; bash'" },
  { "pipal", "urxvt -e sh -c 'pipal ; bash'" },
  { "pipeline", "urxvt -e sh -c 'pipeline ; bash'" },
  { "pkcrack", "urxvt -e sh -c 'pkcrack ; bash'" },
  { "pkcrack-extract", "urxvt -e sh -c 'pkcrack-extract ; bash'" },
  { "pwcrack", "urxvt -e sh -c 'pwcrack -h ; bash'" },
}
crackermenu25 = {
  { "pybozocrack", "urxvt -e sh -c 'pybozocrack -h ; bash'" },
  { "pyrit", "urxvt -e sh -c 'pyrit -h ; bash'" },
  { "pythem", "urxvt -e sh -c 'pythem ; bash'" },
  { "rcrack", "urxvt -e sh -c 'rcrack ; bash'" },
  { "rt2rtc", "urxvt -e sh -c 'rt2rtc ; bash'" },
  { "rtc2rt", "urxvt -e sh -c 'rtc2rt ; bash'" },
  { "rtgen", "urxvt -e sh -c 'rtgen ; bash'" },
  { "rtmerge", "urxvt -e sh -c 'rtmerge ; bash'" },
  { "rtsort", "urxvt -e sh -c 'rtsort ; bash'" },
  { "rarcrack", "urxvt -e sh -c 'rarcrack --help ; bash'" },
  { "rcracki_mt", "urxvt -e sh -c 'rcracki_mt ; bash'" },
  { "rdesktop-brute", "urxvt -e sh -c 'rdesktop-brute -h ; bash'" },
  { "rdpassspray", "urxvt -e sh -c 'rdpassspray -h ; bash'" },
  { "reaver", "urxvt -e sh -c 'reaver ; bash'" },
  { "rhodiola", "urxvt -e sh -c 'rhodiola -h ; bash'" },
  { "ridenum", "urxvt -e sh -c 'ridenum -h ; bash'" },
  { "rlogin-scanner", "urxvt -e sh -c 'rlogin-scanner -h ; bash'" },
  { "rootbrute", "urxvt -e sh -c 'rootbrute -h ; bash'" },
  { "rpdscan", "urxvt -e sh -c 'rpdscan -h ; bash'" },
  { "rsactftool", "urxvt -e sh -c 'rsactftool -h ; bash'" },
}
crackermenu26 = {
  { "rustpad", "urxvt -e sh -c 'rustpad -h ; bash'" },
  { "samydeluxe", "urxvt -e sh -c 'samydeluxe -h ; bash'" },
  { "sb0x", "urxvt -e sh -c 'sb0x -h ; bash'" },
  { "shreder", "urxvt -e sh -c 'shreder -h ; bash'" },
  { "sidguess", "urxvt -e sh -c 'sidguess ; bash'" },
  { "sipbrute", "urxvt -e sh -c 'sipbrute -h ; bash'" },
  { "sipcrack", "urxvt -e sh -c 'sipcrack -h ; bash'" },
  { "sipdump", "urxvt -e sh -c 'sipdump -h ; bash'" },
  { "skul", "urxvt -e sh -c 'skul ; bash'" },
  { "nbdecode", "urxvt -e sh -c 'nbdecode ; bash'" },
  { "smbbf", "urxvt -e sh -c 'smbbf -h ; bash'" },
  { "smbdumpusers", "urxvt -e sh -c 'smbdumpusers ; bash'" },
  { "smbgetserverinfo", "urxvt -e sh -c 'smbgetserverinfo ; bash'" },
  { "smtptester", "urxvt -e sh -c 'smtptester -h ; bash'" },
  { "sn1per", "urxvt -e sh -c 'sn1per ; bash'" },
  { "http-default-accounts-fingerprints-nndefaccts.lua", "urxvt -e sh -c 'http-default-accounts-fingerprints-nndefaccts.lua ; bash'" },
  { "inurlbr.php", "urxvt -e sh -c 'inurlbr.php ; bash'" },
  { "nmap-bootstrap.xsl", "urxvt -e sh -c 'nmap-bootstrap.xsl ; bash'" },
  { "snmpbrute", "urxvt -e sh -c 'snmpbrute ; bash'" },
  { "sparta", "urxvt -e sh -c 'sparta ; bash'" },
}
crackermenu27 = {
  { "speedport-arcadyan", "urxvt -e sh -c 'speedport-arcadyan ; bash'" },
  { "speedpwn", "urxvt -e sh -c 'speedpwn -h ; bash'" },
  { "spray365", "urxvt -e sh -c 'spray365 -h ; bash'" },
  { "sc", "urxvt -e sh -c 'sc ; bash'" },
  { "spraycharles", "urxvt -e sh -c 'spraycharles -h ; bash'" },
  { "sqlbf", "urxvt -e sh -c 'sqlbf ; bash'" },
  { "sslnuke", "urxvt -e sh -c 'sslnuke ; bash'" },
  { "sucrack", "urxvt -e sh -c 'sucrack ; bash'" },
  { "swarm", "urxvt -e sh -c 'swarm -h ; bash'" },
  { "talon", "urxvt -e sh -c 'talon -h ; bash'" },
  { "tftpbrute", "urxvt -e sh -c 'tftpbrute ; bash'" },
  { "keyfinder", "urxvt -e sh -c 'keyfinder ; bash'" },
  { "thc-pptp-bruter", "urxvt -e sh -c 'thc-pptp-bruter ; bash'" },
  { "thc-smartbrute", "urxvt -e sh -c 'thc-smartbrute -h ; bash'" },
  { "timeverter", "urxvt -e sh -c 'timeverter -h ; bash'" },
  { "trevorspray", "urxvt -e sh -c 'trevorspray -h ; bash'" },
  { "ttpassgen", "urxvt -e sh -c 'ttpassgen -h ; bash'" },
  { "ufo-wardriving", "urxvt -e sh -c 'ufo-wardriving ; bash'" },
  { "vnc-bypauth", "urxvt -e sh -c 'vnc-bypauth ; bash'" },
  { "vncrack", "urxvt -e sh -c 'vncrack ; bash'" },
}
crackermenu28 = {
  { "wifibroot", "urxvt -e sh -c 'wifibroot -h ; bash'" },
  { "wifite", "urxvt -e sh -c 'wifite ; bash'" },
  { "wmat", "urxvt -e sh -c 'wmat ; bash'" },
  { "wordbrutepress", "urxvt -e sh -c 'wordbrutepress ; bash'" },
  { "wpbf", "urxvt -e sh -c 'wpbf -h ; bash'" },
  { "wpbrute-rpc", "urxvt -e sh -c 'wpbrute-rpc ; bash'" },
  { "wpforce", "urxvt -e sh -c 'wpforce -h ; bash'" },
  { "wpforce-yertle", "urxvt -e sh -c 'wpforce-yertle -h ; bash'" },
  { "wyd", "urxvt -e sh -c 'wyd ; bash'" },
  { "zackattack", "urxvt -e sh -c 'zackattack -h ; bash'" },
  { "zulu", "urxvt -e sh -c 'zulu ; bash'" },
}
crackermenu = {
  { "1", crackermenu1 },
  { "2", crackermenu2 },
  { "3", crackermenu3 },
  { "4", crackermenu4 },
  { "5", crackermenu5 },
  { "6", crackermenu6 },
  { "7", crackermenu7 },
  { "8", crackermenu8 },
  { "9", crackermenu9 },
  { "10", crackermenu10 },
  { "11", crackermenu11 },
  { "12", crackermenu12 },
  { "13", crackermenu13 },
  { "14", crackermenu14 },
  { "15", crackermenu15 },
  { "16", crackermenu16 },
  { "17", crackermenu17 },
  { "18", crackermenu18 },
  { "19", crackermenu19 },
  { "20", crackermenu20 },
  { "21", crackermenu21 },
  { "22", crackermenu22 },
  { "23", crackermenu23 },
  { "24", crackermenu24 },
  { "25", crackermenu25 },
  { "26", crackermenu26 },
  { "27", crackermenu27 },
  { "28", crackermenu28 },
}
hackmenu = {
  { "anti-forensic", antiforensicmenu },
  { "automation", automationmenu },
  { "automobile", automobilemenu },
  { "backdoor", backdoormenu },
  { "binary", binarymenu },
  { "bluetooth", bluetoothmenu },
  { "code-audit", codeauditmenu },
  { "config", configmenu },
  { "cracker", crackermenu },
  { "crypto", cryptomenu },
  { "database", databasemenu },
  { "debugger", debuggermenu },
  { "decompiler", decompilermenu },
  { "defensive", defensivemenu },
  { "disassembler", disassemblermenu },
  { "dos", dosmenu },
  { "drone", dronemenu },
  { "exploitation", exploitationmenu },
  { "fingerprint", fingerprintmenu },
  { "firmware", firmwaremenu },
  { "forensic", forensicmenu },
  { "fuzzer", fuzzermenu },
  { "gpu", gpumenu },
  { "hardware", hardwaremenu },
  { "honeypot", honeypotmenu },
  { "ids", idsmenu },
  { "keylogger", keyloggermenu },
  { "malware", malwaremenu },
  { "misc", miscmenu },
  { "mobile", mobilemenu },
  { "networking", networkingmenu },
  { "nfc", nfcmenu },
  { "packer", packermenu },
  { "proxy", proxymenu },
  { "radio", radiomenu },
  { "recon", reconmenu },
  { "reversing", reversingmenu },
  { "scanner", scannermenu },
  { "sniffer", sniffermenu },
  { "social", socialmenu },
  { "spoof", spoofmenu },
  { "stego", stegomenu },
  { "tunnel", tunnelmenu },
  { "unpacker", unpackermenu },
  { "voip", voipmenu },
  { "webapp", webappmenu },
  { "windows", windowsmenu },
  { "wireless", wirelessmenu },
}

mymainmenu = awful.menu({
    items = { 
        { "standart", standartmenu},
        { "options", optionsmenu },
        { "terminals", termmenu },
        { "hack", hackmenu },
        { "awesome", myawesomemenu, beautiful.awesome_icon },
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "一", "二", "三", "四", "五", "六", "七", "八", "九", "十" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
