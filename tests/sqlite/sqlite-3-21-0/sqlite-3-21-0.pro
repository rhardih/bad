QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_sqlite_3_21_0.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/lib -lsqlite3
    INCLUDEPATH += $$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/lib/libsqlite3.so
  }
}
