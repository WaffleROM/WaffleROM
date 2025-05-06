SOURCE_FIRMWARE_PATH="$FW_DIR/$(echo -n "$SOURCE_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"
TARGET_FIRMWARE_PATH="$FW_DIR/$(echo -n "$TARGET_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"

ADD_TO_WORK_DIR "a73xqxx" "product" "." 0 0 755 "u:object_r:system_file:s0"

echo "Add stock /odm/ueventd.rc"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "odm" "ueventd.rc" 0 0 644 "u:object_r:vendor_file:s0"

echo "Fix Google Assistant"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentXGoogleEx6_WIDEBAND_LARGE"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentYGoogleEx6_WIDEBAND_LARGE"

DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.flip.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.nfc_authentication.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.nfc_authentication_cover.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.nsflp_level_601.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.pocketsensitivitymode_level1.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.sensorhub_level29.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.usb_authentication.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.wirelesscharger_authentication.xml"

echo "Add stock system features"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.minisviewwalletcover.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.nsflp_level_600.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.sensorhub_level40.xml" 0 0 644 "u:object_r:system_file:s0"

#DELETE_FROM_WORK_DIR "system" "system/lib64/libhdcp_client_aidl.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libhdcp2.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libremotedisplay_wfd.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libremotedisplayservice.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libsecuibc.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libstagefright_hdcp.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.hdcp.wifidisplay-V2-ndk.so"
#DELETE_FROM_WORK_DIR "system" "system/lib64/wfd_log.so"

echo "Replace saiv blobs"
DELETE_FROM_WORK_DIR "system" "system/saiv"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/saiv" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/saiv/face"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/saiv/face" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/saiv/textrecognition"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/saiv/textrecognition" 0 0 755 "u:object_r:system_file:s0"
#we are 64-bit only right now. so there are no "lib" folder. no need to add them to debloat list. :3
