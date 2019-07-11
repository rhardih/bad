QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_opencv_3_4_5.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/opencv-3.4.5-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/opencv-3.4.5-arm64-v8a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/opencv-3.4.5-x86-build
  }

  LIBS += -L$$BUILD_PATH/sdk/native/libs/$$ANDROID_TARGET_ARCH -lopencv_core
  INCLUDEPATH += $$BUILD_PATH/sdk/native/jni/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/sdk/native/libs/$$ANDROID_TARGET_ARCH/libopencv_core.so
}
