#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from RMX5010 device.
$(call inherit-product, device/realme/rmx5010/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier
PRODUCT_BRAND           := realme
PRODUCT_DEVICE          := rmx5010
PRODUCT_MANUFACTURER    := realme
PRODUCT_MODEL           := RMX5010
PRODUCT_NAME            := lineage_rmx5010

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=RE6018L1 \
    DeviceProduct=RMX5010 \
    SystemDevice=RE6018L1 \
    SystemName=RMX5010
