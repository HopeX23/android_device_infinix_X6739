#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/Infinix/X6739
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Kernel
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/kernel:kernel

# API levels
PRODUCT_SHIPPING_API_LEVEL := 33

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/infinix/X6739/X6739-vendor.mk)