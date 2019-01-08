QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_expat_2_2_5.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    # leptonica
    LIBS += -L$$(BAD_PATH)/extracted/expat-2.2.5-armv7-a-build/lib/ -lexpat
    INCLUDEPATH += $$(BAD_PATH)/extracted/expat-2.2.5-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/expat-2.2.5-armv7-a-build/lib/libexpat.so
  }
}

xml.path = /assets
xml.files += $$PWD/../../data/xml/note.xml
xml.depends += FORCE

INSTALLS += xml
