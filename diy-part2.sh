#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate

# Tailscale: the tailscale package and luci-app-tailscale both install
# /etc/init.d/tailscale and /etc/config/tailscale. opkg refuses to install two
# packages owning the same file (check_data_file_clashes) and the build dies at
# package/install, ~90 minutes in. Strip them from the tailscale package and let
# the LuCI app own them, as upstream instructs:
#   https://github.com/asvow/luci-app-tailscale
# Only strip those files if luci-app-tailscale is genuinely there to replace
# them. Stripping them without it leaves a tailscale binary that has no init
# script and no config, so tailscaled never starts -- which is exactly what
# release 2026.07.30-1204 shipped.
if grep -q '^CONFIG_PACKAGE_luci-app-tailscale=y' .config; then
	if [ ! -f package/luci-app-tailscale/Makefile ]; then
		echo "diy-part2: ERROR: .config selects luci-app-tailscale but" >&2
		echo "package/luci-app-tailscale/Makefile is missing, so nothing would" >&2
		echo "provide /etc/init.d/tailscale. Check the clone in diy-part1.sh." >&2
		exit 1
	fi
	TS_MK="feeds/packages/net/tailscale/Makefile"
	if [ ! -f "$TS_MK" ]; then
		echo "diy-part2: ERROR: $TS_MK not found, so the tailscale file clash" >&2
		echo "cannot be patched. Failing now rather than at package/install." >&2
		exit 1
	fi
	sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' "$TS_MK"
	echo "diy-part2: patched $TS_MK so luci-app-tailscale owns init.d/config"
fi
