QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_proj_4_9_3.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build/lib -lproj
    INCLUDEPATH += $$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build/lib/libproj.so
  }
}
