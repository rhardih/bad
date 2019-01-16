QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_openssl_1_0_2p.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/openssl-1.0.2p-armv7-a-build/lib/ -lcrypto -lssl
    INCLUDEPATH += $$(BAD_PATH)/extracted/openssl-1.0.2p-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/openssl-1.0.2p-armv7-a-build/lib/libcrypto.so \
      $$(BAD_PATH)/extracted/openssl-1.0.2p-armv7-a-build/lib/libssl.so
  }
}
