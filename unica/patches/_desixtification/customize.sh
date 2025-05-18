if [[ $TARGET_SINGLE_SYSTEM_IMAGE == "qssi" || $TARGET_SINGLE_SYSTEM_IMAGE == "essi" ]]; then
    echo "Target device with 32-Bit HALs detected! Patching..."

    BLOBS_LIST=(
        "system/lib/libnfc_nxpsn_jni.so"
        "system/lib/vendor.samsung.hardware.nfc@2.0.so"
        "system/lib/vendor.samsung.hardware.nfc_aidl-V1-ndk.so"
    )
    find "$SRC_DIR/prebuilts/samsung/a73xqxx/system/lib/" -type f | while IFS= read -r blob; do
        blob_path="system/lib/$(basename "$blob")"
        if ! printf '%s\n' "${BLOBS_LIST[@]}" | grep -Fxq -- "$blob_path"; then
            ADD_TO_WORK_DIR "system" "$blob_path"
        fi
    done

    ADD_TO_WORK_DIR "a73xqxx" "system" "system/apex/com.android.i18n.apex"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/apex/com.android.runtime.apex"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/apex/com.google.android.tzdata6.apex"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/bootstrap/linker"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/bootstrap/linker_asan"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/linker"
    ADD_TO_WORK_DIR "a73xqxx" "system" "system/bin/linker_asan"

    # Downgrade ENGMODE for 32bit HAL version
    ADD_TO_WORK_DIR "a73xqxx" "system" "lib64/lib.engmode.samsung.so"
    ADD_TO_WORK_DIR "a73xqxx" "system" "lib64/lib.engmodejni.samsung.so"

    # Set props
    echo "Setting props..."
    SET_PROP "vendor" "ro.vendor.product.cpu.abilist" "arm64-v8a"
    SET_PROP "vendor" "ro.vendor.product.cpu.abilist32" ""
    SET_PROP "vendor" "ro.vendor.product.cpu.abilist64" "arm64-v8a"
    SET_PROP "vendor" "ro.zygote" "zygote64"
    SET_PROP "vendor" "dalvik.vm.dex2oat64.enabled" "true"

else
    echo "Target device does not use 32-Bit HALs. Ignoring"
fi
