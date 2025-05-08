if ! grep -q "Camera End" "$WORK_DIR/vendor/ueventd.rc"; then
    echo "" >> "$WORK_DIR/vendor/ueventd.rc"
    cat "$SRC_DIR/target/m52xq/patches/camera/ueventd" >> "$WORK_DIR/vendor/ueventd.rc"
fi

echo "Remove unused libs"
BLOBS_LIST="
system/lib64/libdualcam_refocus_image.so
system/lib64/libAEBHDR_wrapper.camera.samsung.so
system/lib64/libAIDeflicker.camera.samsung.so
system/lib64/libaifrcInterface.camera.samsung.so
system/lib64/libAIQSolution_MPI.camera.samsung.so
system/lib64/libAIQSolution_MPISingleRGB40.camera.samsung.so
system/lib64/libArtifactDetector_v1.camera.samsung.so
system/lib64/libBayerAIPhoto.camera.samsung.so
system/lib64/libbayeraiphoto_wrapper_v1.camera.samsung.so
system/lib64/libBayerAIPhotoTuning.camera.samsung.so
system/lib64/libBestPhoto.camera.samsung.so
system/lib64/libcolor_engine.camera.samsung.so
system/lib64/libDeepDocRectify.camera.samsung.so
system/lib64/libDocColorEnhance.camera.samsung.so
system/lib64/libDocColorEnhance_Auto.camera.samsung.so
system/lib64/libDocDeblur.camera.samsung.so
system/lib64/libDocObjectRemoval.camera.samsung.so
system/lib64/libDocShadowRemoval.camera.samsung.so
system/lib64/libdualcam_refocus_image_lite.so
system/lib64/libDualCamBokehCapture.camera.samsung.so
system/lib64/libdvs.camera.samsung.so
system/lib64/libFaceClustering.camera.samsung.so
system/lib64/libFusionAIPhoto.camera.samsung.so
system/lib64/libFusionAIPhoto_wrapper.camera.samsung.so
system/lib64/libFusionAIPhotoTuning.camera.samsung.so
system/lib64/libGenSR_saicc_core.camera.samsung.so
system/lib64/libhybridHDR_wrapper.camera.samsung.so
system/lib64/libLightObjectDetector_v1.camera.samsung.so
system/lib64/libLocalTM_pcc.camera.samsung.so
system/lib64/libLttEngine.camera.samsung.so
system/lib64/libMPISingleRGB40.camera.samsung.so
system/lib64/libMPISingleRGB40Tuning.camera.samsung.so
system/lib64/libMultiFrameProcessing30.camera.samsung.so
system/lib64/libMultiFrameProcessing30.snapwrapper.camera.samsung.so
system/lib64/libMultiFrameProcessing30Tuning.camera.samsung.so
system/lib64/libPetClustering.camera.samsung.so
system/lib64/libRelighting_API.camera.samsung.so
system/lib64/libSemanticMap_v1.camera.samsung.so
system/lib64/libsentencepiece.camera.samsung.so
system/lib64/libSR_DynamicRectifier.camera.samsung.so
system/lib64/libSR_NearDetector.camera.samsung.so
system/lib64/libSR_StereoCapture.camera.samsung.so
system/lib64/libstartrail.camera.samsung.so
system/lib64/libStereoSolution.camera.samsung.so
system/lib64/libStereoWarp.camera.samsung.so
system/lib64/libSwIsp_core.camera.samsung.so
system/lib64/libSwIsp_wrapper_v1.camera.samsung.so
system/lib64/libtensorflowlite_c.2.16.1.camera.samsung.so
system/lib64/libVideoClassifier.camera.samsung.so
system/lib64/libVirtualApertureCapture.camera.samsung.so
system/lib64/libWideDistortionCorrection.camera.samsung.so
system/lib64/libWineDetector_v1.camera.samsung.so
system/lib64/libpic_best.arcsoft.so
system/lib64/lib_pet_detection.arcsoft.so
system/lib64/libae_bracket_hdr.arcsoft.so
system/lib64/libai_fusion_high_resolution.arcsoft.so
system/lib64/libai_fusion_high_resolution_base_v1.arcsoft.so
system/lib64/libai_fusion_high_resolution_base_v2.arcsoft.so
system/lib64/libface_recognition.arcsoft.so
system/lib64/libFaceRecognition.arcsoft.so
system/lib64/libfrtracking_engine.arcsoft.so
system/lib64/libhybrid_high_dynamic_range.arcsoft.so
system/lib64/libmf_bayer_enhance.arcsoft.so
system/lib64/libsf_tetra_enhance.arcsoft.so
system/lib64/libsnapshotdebanding.arcsoft.so
system/lib64/libsuper_fusion.arcsoft.so
"
for blob in $BLOBS_LIST
do
    DELETE_FROM_WORK_DIR "system" "$blob"
done

echo "Add stock camera libs"
BLOBS_LIST="
system/lib64/libFace_Landmark_Engine.camera.samsung.so
system/lib64/libFacialStickerEngine.arcsoft.so
system/lib64/libHpr_RecFace_dl_v1.0.camera.samsung.so
system/lib64/libImageCropper.camera.samsung.so
system/lib64/libImageTagger.camera.samsung.so
system/lib64/libMyFilter.camera.samsung.so
system/lib64/libPortraitDistortionCorrection.arcsoft.so
system/lib64/libhigh_dynamic_range.arcsoft.so
system/lib64/libhumantracking_util.camera.samsung.so
system/lib64/libhumantracking.arcsoft.so
system/lib64/liblow_light_hdr.arcsoft.so
system/lib64/libsaiv_HprFace_cmh_support_jni.camera.samsung.so
system/lib64/libsurfaceutil.camera.samsung.so
system/lib64/libtensorflowLite.myfilter.camera.samsung.so
system/lib64/libtensorflowlite_inference_api.myfilter.camera.samsung.so
"
for blob in $BLOBS_LIST
do
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "$blob" 0 0 644 "u:object_r:system_lib_file:s0"
done
