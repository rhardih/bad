TEMPLATE = subdirs

SUBDIRS += \
    Utils \
    tesseract \
    leptonica \
    tiff \
    iconv \
    expat \
    openssl \
    proj \
    gdal \
    geos \
    udunits-2 \
    sqlite \
    spatialite \
    opencv \
    curl

BAD_PATH=$$(BAD_PATH)
isEmpty(BAD_PATH): error("Variable BAD_PATH is empty. Builds will fail unless set.")

tesseract.depends = Utils
gdal.depends = Utils
