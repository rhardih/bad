#include <QtTest>

#include "proj_api.h"

class proj_4_9_3 : public QObject
{
    Q_OBJECT

private slots:
    void test_transform();

};

void proj_4_9_3::test_transform()
{
  projPJ pj_merc, pj_latlong;
  // decimal degrees
  double dd_x = -16, dd_y = 20.25;
  // cartesian meters
  double cm_x = -1495284.21, cm_y = 1920596.79;

  QVERIFY((pj_merc = pj_init_plus("+proj=merc +ellps=clrk66 +lat_ts=33")));
  QVERIFY((pj_latlong = pj_init_plus("+proj=latlong +ellps=clrk66")));

  dd_x *= DEG_TO_RAD;
  dd_y *= DEG_TO_RAD;

  QVERIFY(pj_transform(pj_latlong, pj_merc, 1, 1, &dd_x, &dd_y, nullptr) == 0);

  // Fuzzy compare
  QVERIFY(qAbs(dd_x - cm_x) < 0.01);
  QVERIFY(qAbs(dd_y - cm_y) < 0.01);
}

QTEST_APPLESS_MAIN(proj_4_9_3)

#include "tst_proj_4_9_3.moc"
