#include <QtTest>

#include <string.h>

#include <openssl/crypto.h>
#include <openssl/ssl.h>

class openssl_1_0_2p : public QObject
{
    Q_OBJECT

private slots:
    void test_SSLeay_version();
    void test_SSL_library_init();
};

void openssl_1_0_2p::test_SSLeay_version()
{
  // SSLeay_version is part of libcrypto
  const char *actual = SSLeay_version(SSLEAY_VERSION);
  const char *expected = "OpenSSL 1.0.2p  14 Aug 2018";

  QCOMPARE(expected, actual);
}

void openssl_1_0_2p::test_SSL_library_init()
{
  // SSL_library_init is part of libssl
  SSL_library_init();

  QVERIFY(true);
}

QTEST_APPLESS_MAIN(openssl_1_0_2p)

#include "tst_openssl_1_0_2p.moc"
