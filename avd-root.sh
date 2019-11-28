#!/bin/sh


BIN_DIR="/system/xbin"
SU_ARC="supersu-v2.82.zip"
SU_APK="supersu-v2.82.apk"

echo "[*] Checking ABI"
ARCH=$(adb shell getprop ro.product.cpu.abi | tr -d '\n\r')
case "$ARCH" in
arm64-v8a)
  ARCH="arm64"
;;
armeabi)
  ARCH="arm"
;;
armeabi-v7a)
  ARCH="armv7"
;;
x86_64)
  ARCH="x64"
;;
x86)
  ARCH="x86"
;;
mips)
  ARCH="mips"
;;
mips64)
  ARCH="mips64"
;;
esac

echo "[!] ABI == $ARCH"
echo "[*] Enabling ADB root shell, remounting /system as writable, and disabling SE Linux"
adb root
adb remount
adb shell setenforce 0
echo "[*] Moving necessary files to /tmp/su"
[ -e "/tmp/su" ] || mkdir -p /tmp/su
unzip -o "$SU_ARC" -d /tmp/su >/dev/null
if [ -e "/tmp/su/$ARCH/su.pie" ]
then
  mv /tmp/su/$ARCH/su.pie /tmp/su/$ARCH/su
fi
echo "[*] Uploading su binary to $BIN_DIR"
adb push /tmp/su/$ARCH/su $BIN_DIR
adb shell chmod 0755 /system/xbin/su
echo "[*] Running su --install"
adb shell su --install
echo "[*] Starting su daemon"
adb shell su --daemon &
echo "[*] Installing SuperSU APK"
adb install "$SU_APK"
echo "[*] Rooted Device!"
