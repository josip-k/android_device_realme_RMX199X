#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_TOP := $(shell pwd)

DEVICE_PATH := device/realme/RMX199X

### DISPLAY
TARGET_SCREEN_DENSITY := 480

### BOARD
BOARD_VENDOR                 := realme
TARGET_BOARD_PLATFORM        := sm6150
TARGET_BOARD_PLATFORM_GPU    := qcom-adreno618
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER         := true

### PROCESSOR
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_ABI2     :=
TARGET_CPU_VARIANT  := cortex-a76

TARGET_2ND_ARCH         := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT  := cortex-a55

### KERNEL
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_SOURCE        := kernel/realme/sm6150
TARGET_KERNEL_CONFIG        := vendor/x2_defconfig

BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=1 androidboot.usbcontroller=a600000.dwc3 firmware_class.path=/vendor/firmware_mnt/image earlycon=msm_geni_serial,0x880000 loop.max_part=7 cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE           := 0x00000000
BOARD_KERNEL_IMAGE_NAME     := Image.gz-dtb
BOARD_KERNEL_PAGESIZE       := 4096
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000

BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE    := 268435456
BOARD_DTBOIMG_PARTITION_SIZE       := 25165824
BOARD_FLASH_BLOCK_SIZE             := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 100663296
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 4320133120
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12884901888

# Filesystem
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE     := ext4
BOARD_SYSTEMIMAGE_PARTITION_TYPE      := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE  := ext4
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USERIMAGES_USE_EXT4            := true
TARGET_USERIMAGES_USE_F2FS            := true

TARGET_COPY_OUT_VENDOR := vendor

# QCOM
BOARD_USES_QCOM_HARDWARE := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_RECOVERY_FSTAB        := $(DEVICE_PATH)/config/init/fstab.qcom

### ANDROID VERIFIED BOOT
BOARD_AVB_ENABLE := true
ifeq ($(BOARD_AVB_ENABLE), true)
ifneq ($(LINEAGE_AVB_KEY_PATH),)
BOARD_AVB_KEY_PATH := $(LINEAGE_AVB_KEY_PATH)
else
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
endif
BOARD_AVB_RECOVERY_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(BOARD_AVB_ROLLBACK_INDEX)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
endif # BOARD_AVB_ENABLE

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
