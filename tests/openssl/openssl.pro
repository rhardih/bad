TEMPLATE = subdirs

SUBDIRS += \
    openssl-1-1-1c

# 1.0.2p doesn't compile for x86 currently
!equals(ANDROID_TARGET_ARCH, x86) {
  SUBDIRS += \
    openssl-1-0-2p
}
