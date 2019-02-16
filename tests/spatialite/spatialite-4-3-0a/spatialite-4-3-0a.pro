QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_spatialite_4_3_0a.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/lib -lsqlite3
    INCLUDEPATH += $$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/sqlite3-3.21.0-armv7-a-build/lib/libsqlite3.so \
      # Since ANDROID_EXTRA_LIBS has a restriction on filenaming, which must start
      # with lib and must end in .so, but we still want the spatialite extension in
      # our load path, it's necessary to rename the .so file, from mod_spatialite.so
      # to libmodspatialite.so. Otherwise qmake gives an error.
      $$(BAD_PATH)/extracted/spatialite-4.3.0a-armv7-a-build/lib/libmod_spatialite.so \
      $$(BAD_PATH)/extracted/proj-4.9.3-armv7-a-build/lib/libproj.so \
      $$(BAD_PATH)/extracted/iconv-1.15-armv7-a-build/lib/libiconv.so \
      $$(BAD_PATH)/extracted/iconv-1.15-armv7-a-build/lib/libcharset.so \
      $$(BAD_PATH)/extracted/geos-3.6.2-armv7-a-build/lib/libgeos-3.6.2.so \
      $$(BAD_PATH)/extracted/geos-3.6.2-armv7-a-build/lib/libgeos_c.so
  }
}
