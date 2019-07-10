QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_openssl_1_1_1c.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/openssl-1.1.1c-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/openssl-1.1.1c-arm64-v8a-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -lcrypto -lssl
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libcrypto.so \
    $$BUILD_PATH/lib/libssl.so
}
