if [ "$TARGET_SINGLE_SYSTEM_IMAGE" = "qssi" ]; then
    CODENAME="dm1qxxx"
elif [ "$TARGET_SINGLE_SYSTEM_IMAGE" = "essi" ]; then
    CODENAME="r11sxxx"
else
    echo "\"$TARGET_SINGLE_SYSTEM_IMAGE\" is not a valid system image."
    exit 1
fi

if [ -d "$SRC_DIR/target/$TARGET_CODENAME/overlay" ]; then
    DECODE_APK "/product/overlay/framework-res__$CODENAME__auto_generated_rro_product.apk"

    echo "Applying stock overlay configs"
    rm -rf "$APKTOOL_DIR/product/overlay/framework-res__$CODENAME__auto_generated_rro_product.apk/res"
    cp -a --preserve=all \
        "$SRC_DIR/target/$TARGET_CODENAME/overlay" \
        "$APKTOOL_DIR/product/overlay/framework-res__$CODENAME__auto_generated_rro_product.apk/res"
fi
