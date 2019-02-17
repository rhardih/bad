QT += testlib
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_opencv_3_4_5.cpp

android {
  equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
    LIBS += -L$$(BAD_PATH)/extracted/opencv-3.4.5-armv7-a-build/sdk/native/libs/armeabi-v7a -lopencv_core
    INCLUDEPATH += $$(BAD_PATH)/extracted/opencv-3.4.5-armv7-a-build/sdk/native/jni/include

    ANDROID_EXTRA_LIBS += \
      $$(BAD_PATH)/extracted/opencv-3.4.5-armv7-a-build/sdk/native/libs/armeabi-v7a/libopencv_core.so
  }
}
