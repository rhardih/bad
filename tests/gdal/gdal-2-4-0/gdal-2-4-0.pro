QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_gdal_2_4_0.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/gdal-2.4.0-armv7-a-build
    PROJ_BUILD_PATH = $$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    PROJ_BUILD_PATH = $$(BAD_PATH)/extracted/proj-4.9.3-arm64-v8a-build
    BUILD_PATH = $$(BAD_PATH)/extracted/gdal-2.4.0-arm64-v8a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/gdal-2.4.0-x86-build
    PROJ_BUILD_PATH = $$(BAD_PATH)/extracted/proj-4.9.3-x86-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -lgdal
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libgdal.so \
    $$PROJ_BUILD_PATH/lib/libproj.so
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a

tif.path = /assets
tif.files += $$PWD/../../data/images/WhiteadderDEM.tif
tif.depends += FORCE

INSTALLS += tif
