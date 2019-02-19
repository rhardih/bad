#include <QtTest>

#include "curl/curl.h"

class curl_7_64_0 : public QObject
{
  Q_OBJECT

private slots:
  void test_curl_version();
};

void curl_7_64_0::test_curl_version()
{
#ifdef Q_PROCESSOR_ARM
  QCOMPARE(curl_version(), "libcurl/7.64.0 zlib/1.2.11");
#else
  QCOMPARE(curl_version(), "libcurl/7.64.0 zlib/1.2.8");
#endif
}

QTEST_APPLESS_MAIN(curl_7_64_0)

#include "tst_curl_7_64_0.moc"
