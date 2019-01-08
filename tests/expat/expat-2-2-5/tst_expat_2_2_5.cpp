#include <QtTest>

#include "expat.h"

class expat_2_2_5 : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_XML_Parse();

private:
  QByteArray m_data;
};

void expat_2_2_5::initTestCase()
{
  QFile image_file("assets:/note.xml");
  QVERIFY2(image_file.open(QIODevice::ReadOnly),
           "Failed to open assets:/note.xml");

  m_data = image_file.readAll();

  image_file.close();
}

void expat_2_2_5::cleanupTestCase() {  }

void expat_2_2_5::test_XML_Parse()
{
  XML_Parser parser = XML_ParserCreate(nullptr);
  int depth = 0;

  XML_SetUserData(parser, &depth);

  if (XML_Parse(parser, m_data.data(), m_data.size(), 0) == XML_STATUS_ERROR) {
    QFAIL(QString("%1 at line %2").
          arg(XML_ErrorString(XML_GetErrorCode(parser))).
          arg(XML_GetCurrentLineNumber(parser)).toStdString().c_str());
  }

  XML_ParserFree(parser);
}

QTEST_APPLESS_MAIN(expat_2_2_5)

#include "tst_expat_2_2_5.moc"
