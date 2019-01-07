#ifndef UTILS_H
#define UTILS_H

#include <QString>

class Utils
{

public:
  Utils();

  /**
     * @brief migrateAsset
     *
     * Migrate an asset from the assets:// path into a generally accessible location under standard paths
     *
     * @param path
     *
     * @return The new path of the asset
     */

  static QString migrateAsset(QString path);
};

#endif // UTILS_H
