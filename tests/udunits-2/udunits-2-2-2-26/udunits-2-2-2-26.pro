QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_udunits_2_2_2_26.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build
    EXPAT_BUILD_PATH = $$(BAD_PATH)/extracted/expat-2.2.5-armv7-a-build
  }

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    BUILD_PATH = $$(BAD_PATH)/extracted/udunits-2-2.2.26-arm64-v8a-build
    EXPAT_BUILD_PATH = $$(BAD_PATH)/extracted/expat-2.2.5-arm64-v8a-build
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    BUILD_PATH = $$(BAD_PATH)/extracted/udunits-2-2.2.26-x86-build
    EXPAT_BUILD_PATH = $$(BAD_PATH)/extracted/expat-2.2.5-x86-build
  }

  LIBS += -L$$BUILD_PATH/lib/ -ludunits2
  INCLUDEPATH += $$BUILD_PATH/include

  ANDROID_EXTRA_LIBS += \
    $$BUILD_PATH/lib/libudunits2.so \
    $$EXPAT_BUILD_PATH/lib/libexpat.so

  definitions.path = /assets
  definitions.depends += FORCE
  definitions.files += \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2-prefixes.xml \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2.xml \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2-common.xml \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2-derived.xml \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2-accepted.xml \
    $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/share/udunits/udunits2-base.xml

  INSTALLS += definitions
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a
