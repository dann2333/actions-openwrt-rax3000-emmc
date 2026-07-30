#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# fw876/helloworld
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

#HelloWorld
#echo 'src-git HelloWorld https://github.com/fw876/helloworld' >>feeds.conf.default

# luci-app-tailscale: the Tailscale web UI is not in the lede/luci feeds.
#
# It must be cloned into package/<name> and NOT added as a src-git feed. The
# repo's root is the package directory itself, and luci.mk takes the package
# name from that directory: LUCI_NAME?=$(notdir ${CURDIR}), PKG_NAME?=$(LUCI_NAME).
# As a feed named "tailscale" it lands in feeds/tailscale/, so the name comes out
# as "tailscale" and collides with the real tailscale package -- and scripts/feeds
# does not index a root-level Makefile as a package, so it silently builds nothing.
#
# The tailscale package itself is in the coolsnowwolf/packages feed and needs
# nothing here. To drop the web UI, remove the clone below and unset
# CONFIG_PACKAGE_luci-app-tailscale; the tailscale CLI still works.
rm -rf package/luci-app-tailscale
git clone --depth=1 https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
