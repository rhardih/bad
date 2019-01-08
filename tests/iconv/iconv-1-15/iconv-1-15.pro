QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_iconv_1_15.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    # leptonica
    LIBS += -L$$(BAD_PATH)/extracted/iconv-1.15-armv7-a-build/lib/ -liconv
    INCLUDEPATH += $$(BAD_PATH)/extracted/iconv-1.15-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/iconv-1.15-armv7-a-build/lib/libiconv.so
  }
}
