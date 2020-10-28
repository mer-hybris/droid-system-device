#!/bin/bash
#
# Remove unused files, or files that should not be used

if [ "$SYSTEM_SPARSE" == "" ]; then
    SYSTEM_SPARSE=$VENDOR_SPARSE
fi

if [ "$SYSTEM_SPARSE" == "" ]; then
    echo "SYSTEM_SPARSE and VENDOR_SPARSE are unset!"
    exit 1
fi

rm -rf "$(find "$SYSTEM_SPARSE" -name "*.apk")"
rm -rf "$(find "$SYSTEM_SPARSE" -name .gitignore)"
rm -rf "$SYSTEM_SPARSE"/app
rm -rf "$SYSTEM_SPARSE"/bin/apedata_mount.sh
rm -rf "$SYSTEM_SPARSE"/bin/exp-log.sh
rm -rf "$SYSTEM_SPARSE"/bin/install-recovery.sh
# Remove iptables binaries (these litter our iptables tables)
rm -rf "$SYSTEM_SPARSE"/bin/ip6tables
rm -rf "$SYSTEM_SPARSE"/bin/iptables
rm -rf "$SYSTEM_SPARSE"/bin/logd-catch.sh
rm -rf "$SYSTEM_SPARSE"/bin/preinstall.sh
rm -rf "$SYSTEM_SPARSE"/bin/tinno_audio_dump.sh
rm -rf "$SYSTEM_SPARSE"/build.prop.bakforspec
rm -rf "$SYSTEM_SPARSE"/etc/cdrom_install.iso
rm -rf "$SYSTEM_SPARSE"/etc/install_apk.sh
rm -rf "$SYSTEM_SPARSE"/etc/mmi/fonts.ttf
rm -rf "$SYSTEM_SPARSE"/etc/recovery-resource.dat
rm -rf "$SYSTEM_SPARSE"/etc/security/otacerts.zip
rm -rf "$SYSTEM_SPARSE"/fonts
rm -rf "$SYSTEM_SPARSE"/framework
rm -rf "$SYSTEM_SPARSE"/lib/libchromium_client.so
rm -rf "$SYSTEM_SPARSE"/lib/libjni_pacprocessor.so
rm -rf "$SYSTEM_SPARSE"/lib/libpac.so
rm -rf "$SYSTEM_SPARSE"/lib/libswenetxt_plugin.so
rm -rf "$SYSTEM_SPARSE"/lib/libsweskia.so
rm -rf "$SYSTEM_SPARSE"/lib/libswev8.so
rm -rf "$SYSTEM_SPARSE"/lib/libswewebviewchromium.so
rm -rf "$SYSTEM_SPARSE"/lib/libwebviewchromium_loader.so
rm -rf "$SYSTEM_SPARSE"/lib/libwebviewchromium_plat_support.so
rm -rf "$SYSTEM_SPARSE"/lib/libwebviewchromium.so
rm -rf "$SYSTEM_SPARSE"/lib/libWnnEngDic.so
rm -rf "$SYSTEM_SPARSE"/lib/libWnnJpnDic.so
rm -rf "$SYSTEM_SPARSE"/lib/modules
rm -rf "$SYSTEM_SPARSE"/lost+found
rm -rf "$SYSTEM_SPARSE"/media
rm -rf "$SYSTEM_SPARSE"/plugin
rm -rf "$SYSTEM_SPARSE"/priv-app
rm -rf "$SYSTEM_SPARSE"/recovery-from-boot.p
rm -rf "$SYSTEM_SPARSE"/tts
rm -rf "$SYSTEM_SPARSE"/usr/hyphen-data
rm -rf "$SYSTEM_SPARSE"/usr/keylayout
rm -rf "$SYSTEM_SPARSE"/usr/qfipsverify/bootimg.hmac
rm -rf "$SYSTEM_SPARSE"/vendor/app
rm -rf "$SYSTEM_SPARSE"/vendor/bin/slim_ap_daemon
rm -rf "$SYSTEM_SPARSE"/vendor/Cambodia
rm -rf "$SYSTEM_SPARSE"/vendor/CherryCommon
rm -rf "$SYSTEM_SPARSE"/vendor/ChinaMobile
rm -rf "$SYSTEM_SPARSE"/vendor/ChinaTelecom
rm -rf "$SYSTEM_SPARSE"/vendor/ChinaUnicom
rm -rf "$SYSTEM_SPARSE"/vendor/CmccPower
rm -rf "$SYSTEM_SPARSE"/vendor/CTA
rm -rf "$SYSTEM_SPARSE"/vendor/data/misc/ProjectConfig.mk
rm -rf "$SYSTEM_SPARSE"/vendor/Default/system/media
rm -rf "$SYSTEM_SPARSE"/vendor/DTGermany
rm -rf "$SYSTEM_SPARSE"/vendor/EEEU
rm -rf "$SYSTEM_SPARSE"/vendor/EEUK
rm -rf "$SYSTEM_SPARSE"/vendor/etc/scve
rm -rf "$SYSTEM_SPARSE"/vendor/etc/voicecommand
rm -rf "$SYSTEM_SPARSE"/vendor/EUCommon
rm -rf "$SYSTEM_SPARSE"/vendor/framework
rm -rf "$SYSTEM_SPARSE"/vendor/H3GItalia
rm -rf "$SYSTEM_SPARSE"/vendor/H3GUK
rm -rf "$SYSTEM_SPARSE"/vendor/IndonesiaOpenmarket
rm -rf "$SYSTEM_SPARSE"/vendor/LanixClaroColombia
rm -rf "$SYSTEM_SPARSE"/vendor/LanixTelcelMexico
rm -rf "$SYSTEM_SPARSE"/vendor/Laos
rm -rf "$SYSTEM_SPARSE"/vendor/LatamAMX
rm -rf "$SYSTEM_SPARSE"/vendor/LatamBrazil
rm -rf "$SYSTEM_SPARSE"/vendor/LatamClaroChile
rm -rf "$SYSTEM_SPARSE"/vendor/LatamClaroColombia
rm -rf "$SYSTEM_SPARSE"/vendor/LatamClaroPeru
rm -rf "$SYSTEM_SPARSE"/vendor/LatamTelcelMexico
rm -rf "$SYSTEM_SPARSE"/vendor/LatamTelefonica*
rm -rf "$SYSTEM_SPARSE"/vendor/lib/modules
rm -rf "$SYSTEM_SPARSE"/vendor/MalaysiaOpenMarket
rm -rf "$SYSTEM_SPARSE"/vendor/media
rm -rf "$SYSTEM_SPARSE"/vendor/NorthAmerica
rm -rf "$SYSTEM_SPARSE"/vendor/OrangeFrance
rm -rf "$SYSTEM_SPARSE"/vendor/PhilippinesOpenMarket
rm -rf "$SYSTEM_SPARSE"/vendor/plugin
rm -rf "$SYSTEM_SPARSE"/vendor/priv-app
rm -rf "$SYSTEM_SPARSE"/vendor/res
rm -rf "$SYSTEM_SPARSE"/vendor/RJIL
rm -rf "$SYSTEM_SPARSE"/vendor/RussiaOpen
rm -rf "$SYSTEM_SPARSE"/vendor/speccfg
rm -rf "$SYSTEM_SPARSE"/vendor/TelefonicaGermany
rm -rf "$SYSTEM_SPARSE"/vendor/TelefonicaSpain
rm -rf "$SYSTEM_SPARSE"/vendor/ThailandOpenMarket
rm -rf "$SYSTEM_SPARSE"/vendor/TurkeyOpen
rm -rf "$SYSTEM_SPARSE"/vendor/VadafoneUK
rm -rf "$SYSTEM_SPARSE"/vendor/Vodafone*
