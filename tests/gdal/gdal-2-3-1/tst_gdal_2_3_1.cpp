#include <QtTest>

#include "utils.h"

#include "gdal_priv.h"
#include "cpl_conv.h"

// https://www.gdal.org/gdal_tutorial.html
class gdal_2_3_1 : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_GetRaster_();
    void test_GetDriverName();

private:
    QString m_imagePath;
    GDALDataset *m_poDataset;
};

void gdal_2_3_1::initTestCase()
{
  // GeoTIFF fetched from
  //   http://www.geos.ed.ac.uk/~smudd/export_data/WhiteadderDEM.tif
  m_imagePath = Utils::migrateAsset("assets:/WhiteadderDEM.tif");
  QVERIFY2(m_imagePath != "", "WhiteadderDEM.tif not migrated");

  GDALAllRegister();
  m_poDataset = static_cast<GDALDataset *>(GDALOpen(m_imagePath.toStdString().c_str(), GA_ReadOnly));
  QVERIFY(m_poDataset != nullptr);
}

void gdal_2_3_1::cleanupTestCase() {
  GDALClose(m_poDataset);
}

void gdal_2_3_1::test_GetRaster_()
{
  QCOMPARE(m_poDataset->GetRasterXSize(), 486);
  QCOMPARE(m_poDataset->GetRasterYSize(), 645);
  QCOMPARE(m_poDataset->GetRasterCount(), 1);
}

void gdal_2_3_1::test_GetDriverName()
{
  QCOMPARE(m_poDataset->GetDriverName(), "GTiff");
}

QTEST_APPLESS_MAIN(gdal_2_3_1)

#include "tst_gdal_2_3_1.moc"
