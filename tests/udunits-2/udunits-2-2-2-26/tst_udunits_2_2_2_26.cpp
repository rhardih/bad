#include <QtTest>

#include "utils.h"

#include "udunits2.h"

class udunits_2_2_2_26 : public QObject
{
  Q_OBJECT

private slots:
  void initTestCase();
  void cleanupTestCase();
  void test_conversion();

private:
  QString m_dbPath;
  ut_system *m_system;
};

void udunits_2_2_2_26::initTestCase()
{
  // Udunits has no "in-memory" initialisation, so bundled assets need to be
  // moved to a readable location beforehand
  QVERIFY(Utils::migrateAsset("assets:/udunits2-prefixes.xml") != "");
  QVERIFY(Utils::migrateAsset("assets:/udunits2-common.xml") != "");
  QVERIFY(Utils::migrateAsset("assets:/udunits2-derived.xml") != "");
  QVERIFY(Utils::migrateAsset("assets:/udunits2-accepted.xml") != "");
  QVERIFY(Utils::migrateAsset("assets:/udunits2-base.xml") != "");
  QVERIFY((m_dbPath = Utils::migrateAsset("assets:/udunits2.xml")) != "");

  m_system = ut_read_xml(qPrintable(m_dbPath));
  QVERIFY2(ut_get_status() == UT_SUCCESS, "Failed reading xml.");
}

void udunits_2_2_2_26::cleanupTestCase() {
  ut_free_system(m_system);
}

void udunits_2_2_2_26::test_conversion()
{
  qDebug() << m_system;
  ut_unit *sourceUnit = ut_parse(m_system, "kg", UT_ASCII);
  QVERIFY2(ut_get_status() == UT_SUCCESS, "Failed parsing unit 'kg'");

  ut_unit *targetUnit = ut_parse(m_system, "lb", UT_ASCII);
  QVERIFY(ut_get_status() == UT_SUCCESS);

  cv_converter* converter = ut_get_converter(sourceUnit, targetUnit);

  double fromValue = 42.0;
  double toValue = cv_convert_double(converter, fromValue);

  QVERIFY(toValue - 92.59 < 0.01);

  cv_free(converter);
}

QTEST_APPLESS_MAIN(udunits_2_2_2_26)

#include "tst_udunits_2_2_2_26.moc"
