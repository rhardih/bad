#include <QtTest>

#include "tiffio.h"

class tiff_4_0_10 : public QObject
{
    Q_OBJECT

private slots:
    void test_TIFFGetVersion();

};

void tiff_4_0_10::test_TIFFGetVersion()
{
  QString expected = "LIBTIFF, Version 4.0.10\n"
                   "Copyright (c) 1988-1996 Sam Leffler\n"
                   "Copyright (c) 1991-1996 Silicon Graphics, Inc.";
  QString actual(TIFFGetVersion());

  QCOMPARE(actual, expected);
}

QTEST_APPLESS_MAIN(tiff_4_0_10)

#include "tst_tiff_4_0_10.moc"
