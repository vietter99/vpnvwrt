#!/bin/sh
# VWRT System Multi-Service Installer
# Token: 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

TOKEN="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"
URL="https://raw.githubusercontent.com/vietter99/vpnvwrt/master"
TMP_DIR="/tmp/core_update"

echo "Content-type: text/plain"
echo ""

mkdir -p $TMP_DIR
cd $TMP_DIR

echo "[1/4] Dang ket noi may chu bao mat..."
FILES="dns2socks_2.1-r4_aarch64_cortex-a53.ipk dns2tcp_1.1.2-r2_aarch64_cortex-a53.ipk lua-neturl_1.2.1-r4_all.ipk luci-app-mosdns_1.6.16-r18_all.ipk luci-app-ssr-plus_190-r126_all.ipk microsocks_1.0.5-r3_aarch64_cortex-a53.ipk mosdns_5.3.3-r82_aarch64_cortex-a53.ipk shadowsocks-rust-sslocal_1.24.0-r14_aarch64_cortex-a53.ipk shadowsocks-rust-ssserver_1.24.0-r14_aarch64_cortex-a53.ipk shadowsocksr-libev-ssr-check_2.5.6-r6_aarch64_cortex-a53.ipk shadowsocksr-libev-ssr-local_2.5.6-r6_aarch64_cortex-a53.ipk shadowsocksr-libev-ssr-redir_2.5.6-r6_aarch64_cortex-a53.ipk simple-obfs-client_0.0.5-r4_aarch64_cortex-a53.ipk tcping_0.3-r5_aarch64_cortex-a53.ipk xray-core_25.12.8-r35_aarch64_cortex-a53.ipk gen_config.lua"

for file in $FILES; do
    echo "Dang tai: $file..."
    curl -4 -f -s -H "Authorization: token $TOKEN" -L "$URL/$file" -o "$file" || { echo "Loi tai file $file"; exit 1; }
done

echo "[2/4] Dang giai nen goi du lieu he thong..."
opkg install *.ipk --force-depends > /dev/null 2>&1

echo "[3/4] Dang toi uu hoa cau hinh loi..."
if [ -f "gen_config.lua" ]; then
    cp gen_config.lua /usr/share/shadowsocksr/gen_config.lua 2>/dev/null
    rm gen_config.lua
fi

echo "[4/4] Hoan tat. Thiet bi se tu dong Reboot sau 5 giay..."
sleep 5
reboot
