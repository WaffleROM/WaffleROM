echo "Fix up /product/etc/build.prop"
sed -i "/# Removed by /d" "$WORK_DIR/product/etc/build.prop" \
    && sed -i "s/#bluetooth./bluetooth./g" "$WORK_DIR/product/etc/build.prop" \
    && sed -i "s/?=/=/g" "$WORK_DIR/product/etc/build.prop" \
    && sed -i "$(sed -n "/provisioning.hostname/=" "$WORK_DIR/product/etc/build.prop" | sed "2p;d")d" "$WORK_DIR/product/etc/build.prop"

echo "Enable adaptive FPS"
sed -i \
    "/use_content_detection/i ro.surface_flinger.enable_frame_rate_override=false" \
    "$WORK_DIR/vendor/default.prop"
SET_PROP "vendor" "ro.surface_flinger.use_content_detection_for_refresh_rate" "true"
sed -i \
    "/use_content_detection/a ro.surface_flinger.set_idle_timer_ms=3000\nro.surface_flinger.set_touch_timer_ms=500\nro.surface_flinger.set_display_power_timer_ms=1000" \
    "$WORK_DIR/vendor/default.prop"

echo "Disabling A/B"
SET_PROP "product" "ro.product.ab_ota_partitions" --delete

echo "Fix Brightness"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "bin/hw/vendor.samsung.hardware.light-service"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib64/android.hardware.light-V1-ndk_platform.so"
ADD_TO_WORK_DIR "a73xqxx" "vendor" "lib64/vendor.samsung.hardware.light-V1-ndk_platform.so"
# will be useless after one ui 7 release.

echo "Replace btservices APEX"
ADD_TO_WORK_DIR "a73xqxx" "system" "system/apex/com.android.btservices.apex"
