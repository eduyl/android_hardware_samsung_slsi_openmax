LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	Exynos_OMX_VencControl.c \
	Exynos_OMX_Venc.c

LOCAL_MODULE := libExynosOMX_Venc
LOCAL_VENDOR_MODULE := true
LOCAL_ARM_MODE := arm
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/enc \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/hardware/samsung_slsi/exynos/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)/include

LOCAL_ADDITIONAL_DEPENDENCIES += \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS := \
    -Wno-enum-conversion \
    -Wno-unused-label \
    -Wno-unused-parameter \
    -Wno-unused-variable \
    -Wno-parentheses-equality \
    -Wno-undefined-inline

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_CFLAGS += -DUSE_ANDROID
LOCAL_C_INCLUDES += $(ANDROID_MEDIA_INC)/openmax
endif
endif

ifeq ($(EXYNOS_OMX_SUPPORT_TUNNELING), true)
LOCAL_CFLAGS += -DTUNNELING_SUPPORT
endif

ifeq ($(BOARD_USE_METADATABUFFERTYPE), true)
LOCAL_CFLAGS += -DUSE_METADATABUFFERTYPE

ifeq ($(BOARD_USE_STOREMETADATA), true)
LOCAL_CFLAGS += -DUSE_STOREMETADATA
endif

ifeq ($(BOARD_USE_ANDROIDOPAQUE), true)
LOCAL_CFLAGS += -DUSE_ANDROIDOPAQUE
endif
endif

ifeq ($(BOARD_USE_DMA_BUF), true)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(BOARD_USE_GSC_RGB_ENCODER), true)
LOCAL_CFLAGS += -DUSE_HW_CSC_GRALLOC_SOURCE
endif

ifeq ($(BOARD_USE_FIMC_RGB_ENCODER), true)
LOCAL_CFLAGS += -DUSE_HW_CSC_GRALLOC_SOURCE
LOCAL_CFLAGS += -DUSE_FIMC_CSC
endif

ifeq ($(BOARD_USE_CSC_HW), true)
LOCAL_CFLAGS += -DUSE_CSC_HW
endif

ifeq ($(BOARD_USE_QOS_CTRL), true)
LOCAL_CFLAGS += -DUSE_QOS_CTRL
endif

ifeq ($(BOARD_USE_VIDEO_EXT_FOR_WFD_HDCP), true)
LOCAL_CFLAGS += -DUSE_VIDEO_EXT_FOR_WFD_HDCP
endif

LOCAL_SHARED_LIBRARIES := libcsc

include $(BUILD_STATIC_LIBRARY)
