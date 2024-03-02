#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

#Git Theme
cd feeds/luci/themes
rm -rf luci-theme-argon
rm -rf luci-theme-argon-mod
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon
cd ..
cd ..
cd ..

#Git FRP
cd feeds/packages/net
rm -rf frp
rm -rf tailscale
git clone https://github.com/immortalwrt/packages
cp -r packages/net/frp ./
cp -r packages/net/tailscale ./
rm -rf packages
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' frp/Makefile
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' tailscale/Makefile
cd ..
cd ..
cd ..
# Rust
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' feeds/packages/lang/rust/Makefile
# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
# Themes Default
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# Themes Default For OpenWRT23.05
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
# AP Name Default
sed -i 's/OpenWrt/XiaoMi-R3G/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# AP Name Default For ImmortalWrt
sed -i 's/ImmortalWrt/XiaoMi-R3G/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
