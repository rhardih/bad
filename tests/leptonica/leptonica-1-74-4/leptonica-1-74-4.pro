QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_leptonica_1_74_4.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    # leptonica
    LIBS += -L$$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/lib/ -llept
    INCLUDEPATH += $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/lib/liblept.so \
      \ # libtiff needs an include as well, because of leptonica uses it to read a .tif file
      $$(BAD_PATH)/extracted/tiff-4.0.10-armv7-a-build/lib/libtiff.so
  }
}

images.path = /assets
images.files += $$PWD/../../data/images/phototest.tif
images.depends += FORCE

INSTALLS += images
