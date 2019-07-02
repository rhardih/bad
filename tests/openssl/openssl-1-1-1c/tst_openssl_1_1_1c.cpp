#include <QtTest>

#include <openssl/crypto.h>
#include <openssl/ssl.h>

class openssl_1_1_1c : public QObject
{
    Q_OBJECT

private slots:
    void test_SSLeay_version();
    void test_SSL_library_init();
};

void openssl_1_1_1c::test_SSLeay_version()
{
  // SSLeay_version is part of libcrypto
  const char *actual = SSLeay_version(SSLEAY_VERSION);
  const char *expected = "OpenSSL 1.1.1c  28 May 2019";

  QCOMPARE(expected, actual);
}

void openssl_1_1_1c::test_SSL_library_init()
{
  // SSL_library_init is part of libssl
  SSL_library_init();

  QVERIFY(true);
}


QTEST_APPLESS_MAIN(openssl_1_1_1c)

#include "tst_openssl_1_1_1c.moc"
