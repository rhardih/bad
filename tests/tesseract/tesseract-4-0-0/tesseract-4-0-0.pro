QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_tesseract_4_0_0.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/tesseract-4.0.0-armv7-a-build
    LEPT_BUILD_PATH = $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build
    TIFF_BUILD_PATH = $$(BAD_PATH)/extracted/tiff-4.0.10-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/tesseract-4.0.0-x86-build
    LEPT_BUILD_PATH = $$(BAD_PATH)/extracted/leptonica-1.74.4-x86-build
    TIFF_BUILD_PATH = $$(BAD_PATH)/extracted/tiff-4.0.10-x86-build
  }

  LIBS += -L$$BUILD_PATH/lib -ltesseract \
    -L$$LEPT_BUILD_PATH/lib -llept
  INCLUDEPATH += $$BUILD_PATH/include \
    $$LEPT_BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libtesseract.so \
    $$LEPT_BUILD_PATH/lib/liblept.so \
    \ # libtiff needs an include as well, because of leptonica uses it to read a .tif file
    $$TIFF_BUILD_PATH/lib/libtiff.so
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a

images.path = /assets
images.files += $$PWD/../../data/images/phototest.tif
images.depends += FORCE

traineddata.path = /assets/tessdata
traineddata.files += $$PWD/eng.traineddata
traineddata.depends += FORCE

INSTALLS += images traineddata

#DEFINES += BENCHMARKS
