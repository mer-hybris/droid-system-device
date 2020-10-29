#!/bin/bash
#
# Remove unused files, or files that should not be used

if [ -z "$TREE_SPARSE" ]; then
    echo "TREE_SPARSE is unset!"
    exit 1
fi

rm -rf "$(find "$TREE_SPARSE" -name "*.apk")"
rm -rf "$(find "$TREE_SPARSE" -name .gitignore)"
rm -rf "$TREE_SPARSE"/app
rm -rf "$TREE_SPARSE"/bin/apedata_mount.sh
rm -rf "$TREE_SPARSE"/bin/exp-log.sh
rm -rf "$TREE_SPARSE"/bin/install-recovery.sh
# Remove iptables binaries (these litter our iptables tables)
rm -rf "$TREE_SPARSE"/bin/ip6tables
rm -rf "$TREE_SPARSE"/bin/iptables
rm -rf "$TREE_SPARSE"/bin/logd-catch.sh
rm -rf "$TREE_SPARSE"/bin/preinstall.sh
rm -rf "$TREE_SPARSE"/bin/tinno_audio_dump.sh
rm -rf "$TREE_SPARSE"/build.prop.bakforspec
rm -rf "$TREE_SPARSE"/etc/cdrom_install.iso
rm -rf "$TREE_SPARSE"/etc/install_apk.sh
rm -rf "$TREE_SPARSE"/etc/mmi/fonts.ttf
rm -rf "$TREE_SPARSE"/etc/recovery-resource.dat
rm -rf "$TREE_SPARSE"/etc/security/otacerts.zip
rm -rf "$TREE_SPARSE"/fonts
rm -rf "$TREE_SPARSE"/framework
rm -rf "$TREE_SPARSE"/lib/libchromium_client.so
rm -rf "$TREE_SPARSE"/lib/libjni_pacprocessor.so
rm -rf "$TREE_SPARSE"/lib/libpac.so
rm -rf "$TREE_SPARSE"/lib/libswenetxt_plugin.so
rm -rf "$TREE_SPARSE"/lib/libsweskia.so
rm -rf "$TREE_SPARSE"/lib/libswev8.so
rm -rf "$TREE_SPARSE"/lib/libswewebviewchromium.so
rm -rf "$TREE_SPARSE"/lib/libwebviewchromium_loader.so
rm -rf "$TREE_SPARSE"/lib/libwebviewchromium_plat_support.so
rm -rf "$TREE_SPARSE"/lib/libwebviewchromium.so
rm -rf "$TREE_SPARSE"/lib/libWnnEngDic.so
rm -rf "$TREE_SPARSE"/lib/libWnnJpnDic.so
rm -rf "$TREE_SPARSE"/lib/modules
rm -rf "$TREE_SPARSE"/lost+found
rm -rf "$TREE_SPARSE"/media
rm -rf "$TREE_SPARSE"/overlay
rm -rf "$TREE_SPARSE"/plugin
rm -rf "$TREE_SPARSE"/priv-app
rm -rf "$TREE_SPARSE"/recovery-from-boot.p
rm -rf "$TREE_SPARSE"/tts
rm -rf "$TREE_SPARSE"/usr/hyphen-data
rm -rf "$TREE_SPARSE"/usr/keylayout
rm -rf "$TREE_SPARSE"/usr/qfipsverify/bootimg.hmac
rm -rf "$TREE_SPARSE"/vendor/app
rm -rf "$TREE_SPARSE"/vendor/bin/slim_ap_daemon
rm -rf "$TREE_SPARSE"/vendor/Cambodia
rm -rf "$TREE_SPARSE"/vendor/CherryCommon
rm -rf "$TREE_SPARSE"/vendor/ChinaMobile
rm -rf "$TREE_SPARSE"/vendor/ChinaTelecom
rm -rf "$TREE_SPARSE"/vendor/ChinaUnicom
rm -rf "$TREE_SPARSE"/vendor/CmccPower
rm -rf "$TREE_SPARSE"/vendor/CTA
rm -rf "$TREE_SPARSE"/vendor/data/misc/ProjectConfig.mk
rm -rf "$TREE_SPARSE"/vendor/Default/system/media
rm -rf "$TREE_SPARSE"/vendor/DTGermany
rm -rf "$TREE_SPARSE"/vendor/EEEU
rm -rf "$TREE_SPARSE"/vendor/EEUK
rm -rf "$TREE_SPARSE"/vendor/etc/scve
rm -rf "$TREE_SPARSE"/vendor/etc/voicecommand
rm -rf "$TREE_SPARSE"/vendor/EUCommon
rm -rf "$TREE_SPARSE"/vendor/framework
rm -rf "$TREE_SPARSE"/vendor/H3GItalia
rm -rf "$TREE_SPARSE"/vendor/H3GUK
rm -rf "$TREE_SPARSE"/vendor/IndonesiaOpenmarket
rm -rf "$TREE_SPARSE"/vendor/LanixClaroColombia
rm -rf "$TREE_SPARSE"/vendor/LanixTelcelMexico
rm -rf "$TREE_SPARSE"/vendor/Laos
rm -rf "$TREE_SPARSE"/vendor/LatamAMX
rm -rf "$TREE_SPARSE"/vendor/LatamBrazil
rm -rf "$TREE_SPARSE"/vendor/LatamClaroChile
rm -rf "$TREE_SPARSE"/vendor/LatamClaroColombia
rm -rf "$TREE_SPARSE"/vendor/LatamClaroPeru
rm -rf "$TREE_SPARSE"/vendor/LatamTelcelMexico
rm -rf "$TREE_SPARSE"/vendor/LatamTelefonica*
rm -rf "$TREE_SPARSE"/vendor/lib/modules
rm -rf "$TREE_SPARSE"/vendor/MalaysiaOpenMarket
rm -rf "$TREE_SPARSE"/vendor/media
rm -rf "$TREE_SPARSE"/vendor/NorthAmerica
rm -rf "$TREE_SPARSE"/vendor/OrangeFrance
rm -rf "$TREE_SPARSE"/vendor/PhilippinesOpenMarket
rm -rf "$TREE_SPARSE"/vendor/plugin
rm -rf "$TREE_SPARSE"/vendor/priv-app
rm -rf "$TREE_SPARSE"/vendor/res
rm -rf "$TREE_SPARSE"/vendor/RJIL
rm -rf "$TREE_SPARSE"/vendor/RussiaOpen
rm -rf "$TREE_SPARSE"/vendor/speccfg
rm -rf "$TREE_SPARSE"/vendor/TelefonicaGermany
rm -rf "$TREE_SPARSE"/vendor/TelefonicaSpain
rm -rf "$TREE_SPARSE"/vendor/ThailandOpenMarket
rm -rf "$TREE_SPARSE"/vendor/TurkeyOpen
rm -rf "$TREE_SPARSE"/vendor/VadafoneUK
rm -rf "$TREE_SPARSE"/vendor/Vodafone*
