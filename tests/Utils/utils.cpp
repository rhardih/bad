#include "utils.h"

#include <QFile>
#include <QFileInfo>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

Utils::Utils()
{
}

QString Utils::migrateAsset(QString path)
{
  QString path_copy(path);
  QString appDataLocation = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
  QString output_file_path = QDir(appDataLocation).filePath(path_copy.remove("assets:/"));
  QFileInfo output_file_info(output_file_path);
  QString output_file_path_copy(output_file_path);
  QString output_file_dir = output_file_path_copy.remove(output_file_info.fileName());
  QFile input_file(path);

  qDebug() << "UTILS migrateAsset" << input_file << output_file_path;
  if (QDir().mkpath(output_file_dir))
  {
    if (output_file_info.exists())
    {
      qDebug() << "File" << output_file_path << "already exists. Not migrated.";
      //qDebug() << "Content of" << output_file_dir << ":";

      //QDir dir(appDataLocation);
      //dir.setFilter(QDir::AllEntries | QDir::NoDotAndDotDot);
      //QFileInfoList list = dir.entryInfoList();
      //qDebug() << "     Bytes Filename";
      //for (int i = 0; i < list.size(); ++i) {
      //  QFileInfo fileInfo = list.at(i);
      //  qDebug() << QString("%1 %2").arg(fileInfo.size(), 10).arg(fileInfo.fileName());
      //}

      return output_file_path;
    }
    else
    {
      if (input_file.copy(output_file_path)) {
        return output_file_path;
      }
      else
      {
        qDebug() << "Failed to copy" << path;
      }
    }
  }
  else
  {
    qDebug() << "Failed to create" << output_file_dir;
  }

  return "";
}
