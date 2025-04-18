#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/rmx5010

# A/B
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_VARIANT  := oryon

# Bootloader
TARGET_BOARD_INFO_FILE          := $(DEVICE_PATH)/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME    := sun

# Display
TARGET_SCREEN_DENSITY := 480

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/configs/config.fs

# Kernel
BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.load_modules_parallel=true \
    androidboot.hypervisor.protected_vm.supported=true \
    androidboot.vendor.qspa=true \
    androidboot.serialconsole=0 \
    androidboot.selinux=permissive

BOARD_KERNEL_BASE       := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE   := 0x1000     # 4096

BOARD_BOOT_HEADER_VERSION       := 4
BOARD_INIT_BOOT_HEADER_VERSION  := 4
BOARD_MKBOOTIMG_ARGS            += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_INIT_ARGS       += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_INCLUDE_DTB_IN_BOOTIMG    := true
BOARD_RAMDISK_USE_LZ4           := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# Metadata
BOARD_USES_METADATA_PARTITION   := true

# OTA assert
TARGET_OTA_ASSERT_DEVICE        := rmx5010

# Partitions
BOARD_FLASH_BLOCK_SIZE                      := 0x40000      # 262144 (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE              := 0x6000000    # 100663296
BOARD_DTBOIMG_PARTITION_SIZE                := 0x1800000    # 25165824
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE        := 0x800000     # 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE          := 0x6400000    # 104857600
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE       := 0x6000000    # 100663296

BOARD_SUPER_PARTITION_SIZE                  := 0x3A0000000  # 15569256448
BOARD_SUPER_PARTITION_GROUPS                := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext system_dlkm vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE           := 0x39FC00000  # 15565062144 (BOARD_SUPER_PARTITION_SIZE - 4 MiB)

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))

# Platform
BOARD_USES_QCOM_HARDWARE    := true
TARGET_BOARD_PLATFORM       := sun

# Properties
TARGET_PROP_PARTITION_LIST := $(filter-out %_dlkm,$(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(TARGET_PROP_PARTITION_LIST), $(eval TARGET_$(p)_PROP += $(DEVICE_PATH)/configs/properties/$(call to-lower, $(p)).prop))

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE    := true
TARGET_RECOVERY_PIXEL_FORMAT                := RGBX_8888
TARGET_RECOVERY_FSTAB                       := $(DEVICE_PATH)/init/etc/fstab.qcom
TARGET_USERIMAGES_USE_F2FS                  := true

# Sepolicy
-include device/qcom/sepolicy_vndr/SEPolicy.mk

# VINTF
DEVICE_MANIFEST_SKUS := sun
DEVICE_MANIFEST_SUN_FILES := \
    $(DEVICE_PATH)/configs/vintf/manifest_sun.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/configs/vintf/compatibility_matrix.device.xml \
    vendor/lineage/config/device_framework_matrix.xml

# Inherit from the proprietary version
-include vendor/realme/rmx5010/BoardConfigVendor.mk
