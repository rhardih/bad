QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_tiff_4_0_10.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/tiff-4.0.10-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/tiff-4.0.10-x86-build
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/tiff-4.0.10-arm64-v8a-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -ltiff
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libtiff.so
}
