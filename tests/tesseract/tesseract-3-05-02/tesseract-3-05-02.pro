QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_tesseract_3_05_02.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    # tesseract
    LIBS += -L$$(BAD_PATH)/extracted/tesseract-3.05.02-armv7-a-build/lib/ -ltesseract
    INCLUDEPATH += $$(BAD_PATH)/extracted/tesseract-3.05.02-armv7-a-build/include

    # leptonica
    LIBS += -L$$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/lib/ -llept
    INCLUDEPATH += $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/tesseract-3.05.02-armv7-a-build/lib/libtesseract.so \
      $$(BAD_PATH)/extracted/leptonica-1.74.4-armv7-a-build/lib/liblept.so \
      \ # libtiff needs an include as well, because of leptonica uses it to read a .tif file
      $$(BAD_PATH)/extracted/tiff-4.0.10-armv7-a-build/lib/libtiff.so
  }
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a

images.path = /assets
images.files += $$PWD/../../data/images/phototest.tif
images.depends += FORCE

traineddata.path = /assets/tessdata # apk asset path
traineddata.files += $$PWD/eng.traineddata
traineddata.depends += FORCE

INSTALLS += images traineddata

#DEFINES += BENCHMARKS
