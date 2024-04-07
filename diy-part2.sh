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
rm -rf luci-theme-design
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon
git clone --depth=1 https://github.com/gngpp/luci-theme-design.git  luci-theme-design
cd ..
cd ..
cd ..



#Git FRP
cd feeds/packages
rm -rf net/frp
rm -rf net/tailscale
rm -rf lang/rust
rm -rf lang/golang
git clone --depth=1 https://github.com/immortalwrt/packages
cp -r packages/net/frp net/
cp -r packages/net/tailscale net/
cp -r packages/lang/golang lang/
cp -r packages/lang/rust lang/
rm -rf packages
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' net/frp/Makefile
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' net/tailscale/Makefile
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' lang/golang/golang/Makefile
sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' lang/rust/Makefile
cd ..
cd ..

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
# Themes Default
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
# AP Name Default
sed -i 's/OpenWrt/XiaoMi-R3G/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Clash Meta Core
# curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-mipsle-softfloat.tar.gz -o /tmp/clash.tar.gz
# tar zxvf /tmp/clash.tar.gz -C /tmp
# chmod +x /tmp/clash
# mkdir -p ./feeds/openclash/luci-app-openclash/root/etc/openclash/core
# mv /tmp/clash ./feeds/openclash/luci-app-openclash/root/etc/openclash/core/clash_meta
# rm -rf /tmp/clash.tar.gz

