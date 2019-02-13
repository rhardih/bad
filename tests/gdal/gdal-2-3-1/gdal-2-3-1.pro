QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_gdal_2_3_1.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/gdal-2.3.1-armv7-a-build/lib -lgdal
    INCLUDEPATH += $$(BAD_PATH)/extracted/gdal-2.3.1-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/gdal-2.3.1-armv7-a-build/lib/libgdal.so \
      $$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build/lib/libproj.so
  }
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a

tif.path = /assets
tif.files += $$PWD/../../data/images/WhiteadderDEM.tif
tif.depends += FORCE

INSTALLS += tif
