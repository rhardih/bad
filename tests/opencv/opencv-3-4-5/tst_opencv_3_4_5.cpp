#include <QtTest>

#include "opencv2/core.hpp"

class opencv_3_4_5 : public QObject
{
    Q_OBJECT

private slots:
    void test_getVersionString();
};

void opencv_3_4_5::test_getVersionString()
{
  QCOMPARE(cv::getVersionString().c_str(), "3.4.5");
}

QTEST_APPLESS_MAIN(opencv_3_4_5)

#include "tst_opencv_3_4_5.moc"
