#include <QtTest>
#include <QCoreApplication>

#include "utils.h"

#include "tesseract/baseapi.h"
#include "leptonica/allheaders.h"

class tesseract_4_0_0 : public QObject
{
    Q_OBJECT

public:
    tesseract_4_0_0();
    ~tesseract_4_0_0();

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_GetUTF8Text();

#ifdef BENCHMARKS
    void benchmark_getUTF8Text();
#endif

private:
  Pix *m_image;
  tesseract::TessBaseAPI *m_tess;
  char *m_text;
};

tesseract_4_0_0::tesseract_4_0_0() { }

tesseract_4_0_0::~tesseract_4_0_0() { }

void tesseract_4_0_0::initTestCase()
{
  QString image_path = Utils::migrateAsset("assets:/phototest.tif");
  QVERIFY2(image_path != "", "phototest.tif not migrated");

  m_image = pixRead(image_path.toStdString().c_str());

  QVERIFY2(m_image != nullptr, "Failed to create PIX* from image data.");

  m_tess = new tesseract::TessBaseAPI();
  QVERIFY2(m_tess != nullptr, "Failed to create new tesseract::TessBaseAPI.");

  QString tessdata_path =
          Utils::migrateAsset("assets:/tessdata/eng.traineddata").
          remove("eng.traineddata");

  int res = m_tess->Init(tessdata_path.toStdString().c_str(), "eng", tesseract::OEM_TESSERACT_ONLY);
  QVERIFY2(res != -1, "Failed to initialize Tesseract.");
}

void tesseract_4_0_0::cleanupTestCase()
{
  m_tess->End();
  pixDestroy(&m_image);
}

void tesseract_4_0_0::test_GetUTF8Text()
{
  QString expected = \
      "This is a lot of 12 point text to test the\n" \
      "ocr code and see if it works on all types\n" \
      "of file format.\n\n" \
      "The quick brown dog jumped over the\n" \
      "lazy fox. The quick brown dog jumped\n" \
      "over the lazy fox. The quick brown dog\n" \
      "jumped over the lazy fox. The quick\n" \
      "brown dog jumped over the lazy fox.\n";

  m_tess->SetImage(m_image);
  m_text = m_tess->GetUTF8Text();
  QString actual = QString(m_text);

  QCOMPARE(actual, expected);
}

#ifdef BENCHMARKS
void tesseract_4_0_0::benchmark_getUTF8Text()
{
  QBENCHMARK {
    for(int i = 0; i < 10; ++i)
    {
      m_tess->SetImage(m_image);
      m_tess->GetUTF8Text();
    }
  }
}
#endif

QTEST_MAIN(tesseract_4_0_0)

#include "tst_tesseract_4_0_0.moc"
