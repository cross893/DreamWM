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
automationmenu = {
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
