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

# luci-app-tailscale: the Tailscale web UI is not in the lede/luci feeds, so it
# comes from a third-party feed. The tailscale package itself is in the
# coolsnowwolf/packages feed and needs nothing extra here.
# If this feed ever breaks the build, comment the line out and drop
# CONFIG_PACKAGE_luci-app-tailscale from .config -- the tailscale CLI still works.
echo 'src-git tailscale https://github.com/asvow/luci-app-tailscale' >>feeds.conf.default
