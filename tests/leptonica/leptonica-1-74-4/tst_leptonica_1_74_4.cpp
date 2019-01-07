#include <QtTest>
#include <QByteArray>
#include <QFile>

#include "leptonica/allheaders.h"

class leptonica_1_74_4 : public QObject
{
  Q_OBJECT

public:
  leptonica_1_74_4();
  ~leptonica_1_74_4();

private slots:
  void initTestCase();
  void cleanupTestCase();
  void test_pixReadMem();

private:
  PIX *m_image;
  QByteArray m_data;
};

leptonica_1_74_4::leptonica_1_74_4()
{

}

leptonica_1_74_4::~leptonica_1_74_4()
{

}

void leptonica_1_74_4::initTestCase()
{
  QFile image_file("assets:/phototest.tif");
  QVERIFY2(image_file.open(QIODevice::ReadOnly),
           "Failed to open assets:/phototest.tif");

  m_data = image_file.readAll();

  image_file.close();
}

void leptonica_1_74_4::cleanupTestCase()
{

}

void leptonica_1_74_4::test_pixReadMem()
{
  m_image = pixReadMem(
              reinterpret_cast<const l_uint8 *>(m_data.data()),
              static_cast<size_t>(m_data.size()));

  QVERIFY(m_image != nullptr);
  QCOMPARE(m_image->w, 640);
  QCOMPARE(m_image->h, 480);
}

QTEST_APPLESS_MAIN(leptonica_1_74_4)

#include "tst_leptonica_1_74_4.moc"
