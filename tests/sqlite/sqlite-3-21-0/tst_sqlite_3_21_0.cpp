#include <QtTest>

#include "sqlite3.h"

class sqlite_3_21_0 : public QObject
{
  Q_OBJECT

private slots:
  void initTestCase();
  void cleanupTestCase();
  void test_query();

private:
  sqlite3 *m_db;
};

void sqlite_3_21_0::initTestCase()
{
  int rc = sqlite3_open(":memory:", &m_db);
  QVERIFY2(rc == SQLITE_OK, qPrintable(QString("Can't open database: %1\n").arg(sqlite3_errmsg(m_db))));
}

void sqlite_3_21_0::cleanupTestCase() {
  sqlite3_close(m_db);
}

void sqlite_3_21_0::test_query()
{
  sqlite3_stmt *stmt;
  int rc;

  rc = sqlite3_prepare(m_db, "SELECT SQLITE_VERSION()", -1, &stmt, nullptr);
  QVERIFY(rc == SQLITE_OK);

  rc = sqlite3_step(stmt);
  QVERIFY(rc == SQLITE_ROW);

  QCOMPARE(reinterpret_cast<const char *>(sqlite3_column_text(stmt, 0)), "3.21.0");

  sqlite3_finalize(stmt);
}

QTEST_APPLESS_MAIN(sqlite_3_21_0)

#include "tst_sqlite_3_21_0.moc"
