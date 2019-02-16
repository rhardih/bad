#include <QtTest>

#include "sqlite3.h"

class spatialite_4_3_0a : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_query();

private:
  sqlite3 *m_db;
};

void spatialite_4_3_0a::initTestCase()
{
  int rc = sqlite3_open(":memory:", &m_db);
  QVERIFY2(rc == SQLITE_OK, qPrintable(QString("Can't open database: %1\n").arg(sqlite3_errmsg(m_db))));
}

void spatialite_4_3_0a::cleanupTestCase()
{
  sqlite3_close(m_db);
}

void spatialite_4_3_0a::test_query()
{
  sqlite3_stmt *stmt;
  int rc;

  rc = sqlite3_db_config(m_db, SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION, 1, NULL);
  QVERIFY2(rc == SQLITE_OK, qPrintable(QString("Cannot enable extension loading: %1").arg(sqlite3_errmsg(m_db))));

  char *error;
  rc = sqlite3_load_extension(m_db, "libmod_spatialite", nullptr, &error);
  QVERIFY2(rc == SQLITE_OK, qPrintable(QString("Failed to load extension: %1").arg(error)));

  rc = sqlite3_prepare(m_db, "SELECT spatialite_version()", -1, &stmt, nullptr);
  QVERIFY(rc == SQLITE_OK);

  rc = sqlite3_step(stmt);
  QVERIFY(rc == SQLITE_ROW);

  QCOMPARE(reinterpret_cast<const char *>(sqlite3_column_text(stmt, 0)), "4.3.0a");

  sqlite3_finalize(stmt);
}

QTEST_APPLESS_MAIN(spatialite_4_3_0a)

#include "tst_spatialite_4_3_0a.moc"
