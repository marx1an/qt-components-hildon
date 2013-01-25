#ifndef FILESYSTEMMODEL_H
#define FILESYSTEMMODEL_H

#include "qdeclarativefolderlistmodel.h"
#include <QSortFilterProxyModel>

class QDeclarativeItem;

class FileSystemModel : public QSortFilterProxyModel
{
    Q_OBJECT

    Q_PROPERTY(QUrl folder
               READ folder
               WRITE setFolder
               NOTIFY folderChanged)
    Q_PROPERTY(QString folderName
               READ folderName
               NOTIFY folderChanged)
    Q_PROPERTY(QUrl rootFolder
               READ rootFolder
               WRITE setRootFolder)
    Q_PROPERTY(QUrl parentFolder
               READ parentFolder
               NOTIFY folderChanged)
    Q_PROPERTY(QStringList nameFilters
               READ nameFilters
               WRITE setNameFilters)
    Q_PROPERTY(QDeclarativeFolderListModel::SortField sortField
               READ sortField
               WRITE setSortField)
    Q_PROPERTY(bool sortReversed
               READ sortReversed
               WRITE setSortReversed)
    Q_PROPERTY(bool showDirs
               READ showDirs
               WRITE setShowDirs)
    Q_PROPERTY(bool showDirsFirst
               READ showDirsFirst
               WRITE setShowDirsFirst)
    Q_PROPERTY(bool showDotAndDotDot
               READ showDotAndDotDot
               WRITE setShowDotAndDotDot)
    Q_PROPERTY(bool showOnlyReadable
               READ showOnlyReadable
               WRITE setShowOnlyReadable)
    Q_PROPERTY(int count
               READ count
               NOTIFY countChanged)
    Q_PROPERTY(QString query
               READ query
               WRITE setQuery
               NOTIFY queryChanged)

public:
    explicit FileSystemModel(QDeclarativeItem *parent = 0);
    inline QUrl folder() const { return m_model->folder(); }
    inline void setFolder(const QUrl &folder) { m_model->setFolder(folder); }
    inline QString folderName() const { return m_model->folderName(); }
    inline QUrl rootFolder() const { return m_model->rootFolder(); }
    inline void setRootFolder(const QUrl &folder) { m_model->setRootFolder(folder); }
    inline QUrl parentFolder() const { return m_model->parentFolder(); }
    inline QStringList nameFilters() const { return m_model->nameFilters(); }
    inline void setNameFilters(const QStringList &filters) { m_model->setNameFilters(filters); }
    inline QDeclarativeFolderListModel::SortField sortField() const { return m_model->sortField(); }
    inline void setSortField(QDeclarativeFolderListModel::SortField field) { m_model->setSortField(field); }
    inline bool sortReversed() const { return m_model->sortReversed(); }
    inline void setSortReversed(bool reversed) { m_model->setSortReversed(reversed); }
    inline bool showDirs() const { return m_model->showDirs(); }
    inline void setShowDirs(bool show) { m_model->setShowDirs(show); }
    inline bool showDirsFirst() const { return m_model->showDirsFirst(); }
    inline void setShowDirsFirst(bool first) { m_model->setShowDirsFirst(first); }
    inline bool showDotAndDotDot() const { return m_model->showDotAndDotDot(); }
    inline void setShowDotAndDotDot(bool show) { m_model->setShowDotAndDotDot(show); }
    inline bool showOnlyReadable() const { return m_model->showOnlyReadable(); }
    inline void setShowOnlyReadable(bool only) { m_model->setShowOnlyReadable(only); }
    inline int count() const { return m_model->count(); }
    inline QString query() const { return m_query; }
    void setQuery(const QString &query);
    Q_INVOKABLE bool newFolder(QString name) { return m_model->newFolder(name); }

signals:
    void folderChanged();
    void countChanged() const;
    void queryChanged();


private:
    QDeclarativeFolderListModel *m_model;
    QString m_query;
};

#endif // FILESYSTEMMODEL_H
