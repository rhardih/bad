QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_curl_7_64_0.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/curl-7.64.0-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/curl-7.64.0-x86-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -lcurl
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libcurl.so
}
