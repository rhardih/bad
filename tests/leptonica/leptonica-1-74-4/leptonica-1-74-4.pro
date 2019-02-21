QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_leptonica_1_74_4.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build
    TIFF_BUILD_PATH=$$(BAD_PATH)/extracted/tiff-4.0.10-armv7-a-build/lib
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/leptonica-1.74.4-x86-build
    TIFF_BUILD_PATH=$$(BAD_PATH)/extracted/tiff-4.0.10-x86-build/lib
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/leptonica-1.74.4-arm64-v8a-build
    TIFF_BUILD_PATH=$$(BAD_PATH)/extracted/tiff-4.0.10-arm64-v8a-build/lib
  }

  LIBS += -L$$BUILD_PATH/lib/ -llept
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/liblept.so \
    \ # libtiff needs to be included as well, because leptonica uses it to read a .tif file
    $$TIFF_BUILD_PATH/libtiff.so
}

images.path = /assets
images.files += $$PWD/../../data/images/phototest.tif
images.depends += FORCE

INSTALLS += images
