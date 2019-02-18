QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_expat_2_2_5.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/expat-2.2.5-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/expat-2.2.5-x86-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -lexpat
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libexpat.so
}

xml.path = /assets
xml.files += $$PWD/../../data/xml/note.xml
xml.depends += FORCE

INSTALLS += xml
