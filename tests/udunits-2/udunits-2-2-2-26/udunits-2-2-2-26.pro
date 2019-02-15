QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_udunits_2_2_2_26.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/lib -ludunits2
    INCLUDEPATH += $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/udunits-2-2.2.26-armv7-a-build/lib/libudunits2.so

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
}

LIBS += -L$$OUT_PWD/../../Utils/ -lUtils
INCLUDEPATH += $$PWD/../../Utils
DEPENDPATH += $$PWD/../../Utils
PRE_TARGETDEPS += $$OUT_PWD/../../Utils/libUtils.a
