#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/Infinix/X6739
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Allow userspace reboots
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# # Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# A/B
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Kernel
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/kernel:kernel

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6893 \
    fstab.mt6893.vendor_ramdisk \
    init.cgroup.rc \
    init.connectivity.rc \
    init.insmod.mt6893.cfg \
    init.insmod.sh \
    init.modem.rc \
    init.mt6893.rc \
    init.mt6893.usb.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.recovery.mt6893.rc \
    init.sensor_2_0.rc \
    init.target.rc \
    ueventd.mtk.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6893:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt6893 \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6893:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.mt6893

# API levels
PRODUCT_SHIPPING_API_LEVEL := 33

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Dalvik configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-8192-dalvik-heap.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/infinix/X6739/X6739-vendor.mk)