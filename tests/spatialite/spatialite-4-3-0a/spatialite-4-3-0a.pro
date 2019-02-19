QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_spatialite_4_3_0a.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build
    ARCH=armv7-a
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/sqlite3-3.21.0-x86-build
    ARCH=x86
  }

  LIBS += -L$$BUILD_PATH/lib/ -lsqlite3
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libsqlite3.so \
    # Since ANDROID_EXTRA_LIBS has a restriction on filenaming, which must start
    # with lib and must end in .so, but we still want the spatialite extension in
    # our load path, it's necessary to rename the .so file, from mod_spatialite.so
    # to libmodspatialite.so. Otherwise qmake gives an error.
    $$(BAD_PATH)/extracted/spatialite-4.3.0a-$$ARCH-build/lib/libmod_spatialite.so \
    $$(BAD_PATH)/extracted/proj-4.9.3-$$ARCH-build/lib/libproj.so \
    $$(BAD_PATH)/extracted/iconv-1.15-$$ARCH-build/lib/libiconv.so \
    $$(BAD_PATH)/extracted/iconv-1.15-$$ARCH-build/lib/libcharset.so \
    $$(BAD_PATH)/extracted/geos-3.6.2-$$ARCH-build/lib/libgeos-3.6.2.so \
    $$(BAD_PATH)/extracted/geos-3.6.2-$$ARCH-build/lib/libgeos_c.so
}
