#
# Copyright 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES += \
    liblog \
    libcutils \
    libutils

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 30; echo $$?), 0)
LOCAL_CFLAGS += -DCBMANAGER_USE_HILD_GRAPHICS_HALS
LOCAL_SRC_FILES := hidl.cpp
LOCAL_SHARED_LIBRARIES += \
    libhidlbase \
    android.hardware.graphics.mapper@2.0 \
    android.hardware.graphics.allocator@2.0
else
LOCAL_SRC_FILES := gralloc.cpp
LOCAL_SHARED_LIBRARIES += \
    libhardware
endif

LOCAL_CFLAGS += \
    -DLOG_TAG=\"cbmanager\" \
    -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION) \
    -Werror \

LOCAL_C_INCLUDES += \
    device/generic/goldfish-opengl/system/include \
    device/generic/goldfish-opengl/shared/OpenglCodecCommon \

LOCAL_MODULE := libcbmanager
LOCAL_VENDOR_MODULE := true

include $(BUILD_SHARED_LIBRARY)
