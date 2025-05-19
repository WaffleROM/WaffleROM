SOURCE_FIRMWARE_PATH="$FW_DIR/$(echo -n "$SOURCE_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"
TARGET_FIRMWARE_PATH="$FW_DIR/$(echo -n "$TARGET_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"

ADD_TO_WORK_DIR "a73xqxx" "product" "." 0 0 755 "u:object_r:system_file:s0"

echo "Add stock /odm/ueventd.rc"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "odm" "ueventd.rc" 0 0 644 "u:object_r:vendor_file:s0"

echo "Replace saiv blobs"
DELETE_FROM_WORK_DIR "system" "system/saiv"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/saiv" 0 0 755 "u:object_r:system_file:s0"
#we are 64-bit only right now. so there are no "lib" folder. no need to add them to debloat list. :3
