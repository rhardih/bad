#include <QtTest>

#include "geos_c.h"

class geos_3_6_2 : public QObject
{
  Q_OBJECT

private slots:
  void test_GEOSversion();
};

void geos_3_6_2::test_GEOSversion()
{
  QCOMPARE(GEOSversion(), "3.6.2-CAPI-1.10.2 4d2925d6");
}

QTEST_APPLESS_MAIN(geos_3_6_2)

#include "tst_geos_3_6_2.moc"
