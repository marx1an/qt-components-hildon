#ifndef BOOKMARKSMODEL_H
#define BOOKMARKSMODEL_H

#include <QAbstractListModel>
#include <QDomDocument>

class BookmarksModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count
               READ rowCount
               NOTIFY countChanged)
    Q_PROPERTY(QString fileName
               READ fileName
               WRITE setFileName)

public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        UrlRole
    };

    explicit BookmarksModel(QObject *parent = 0);
    ~BookmarksModel();
    inline QString fileName() const { return m_fileName; }
    void setFileName(const QString &fileName);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    Q_INVOKABLE QVariant data(int row, const QByteArray &roleName) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Q_INVOKABLE bool setData(int row, const QVariant &value, const QByteArray &roleName);
    Q_INVOKABLE bool addBookmark(const QString &title, const QString &url);
    Q_INVOKABLE bool removeBookmark(const QString &url);
    Q_INVOKABLE bool removeBookmark(int row);

private:
    void loadBookmarks();
    bool saveBookmarks();

signals:
    void countChanged(int count);
    
private:
    QString m_fileName;
    QDomDocument m_document;
};

#endif // BOOKMARKSMODEL_H
