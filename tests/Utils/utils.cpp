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

  if (QDir().mkpath(output_file_dir))
  {
    if (!input_file.copy(output_file_path)) {
      qDebug() << path << "not copied, since" << output_file_path << "already exists.";
    }

    return output_file_path;
  }
  else
  {
    qDebug() << "Failed to create" << output_file_dir;
  }

  return "";
}
