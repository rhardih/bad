QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_geos_3_6_2.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/geos-3.6.2-armv7-a-build/lib -lgeos_c
    INCLUDEPATH += $$(BAD_PATH)/extracted/geos-3.6.2-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/geos-3.6.2-armv7-a-build/lib/libgeos_c.so
  }
}
