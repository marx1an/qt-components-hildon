/****************************************************************************
 **
 ** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
 ** All rights reserved.
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the examples of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:LGPL$
 ** Commercial Usage
 ** Licensees holding valid Qt Commercial licenses may use this file in
 ** accordance with the Qt Commercial License Agreement provided with the
 ** Software or, alternatively, in accordance with the terms contained in
 ** a written agreement between you and Nokia.
 **
 ** GNU Lesser General Public License Usage
 ** Alternatively, this file may be used under the terms of the GNU Lesser
 ** General Public License version 2.1 as published by the Free Software
 ** Foundation and appearing in the file LICENSE.LGPL included in the
 ** packaging of this file.  Please review the following information to
 ** ensure the GNU Lesser General Public License version 2.1 requirements
 ** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 **
 ** In addition, as a special exception, Nokia gives you certain additional
 ** rights.  These rights are described in the Nokia Qt LGPL Exception
 ** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
 **
 ** GNU General Public License Usage
 ** Alternatively, this file may be used under the terms of the GNU
 ** General Public License version 3.0 as published by the Free Software
 ** Foundation and appearing in the file LICENSE.GPL included in the
 ** packaging of this file.  Please review the following information to
 ** ensure the GNU General Public License version 3.0 requirements will be
 ** met: http://www.gnu.org/copyleft/gpl.html.
 **
 ** If you have questions regarding the use of this file, please contact
 ** Nokia at qt-info@nokia.com.
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

#ifndef QDECLARATIVFOLDERLISTMODEL_H
#define QDECLARATIVFOLDERLISTMODEL_H

#include "fileinfothread_p.h"
#include "fileproperty_p.h"
#include <QStringList>
#include <QUrl>
#include <QAbstractListModel>

QT_BEGIN_HEADER

class QModelIndex;

class QDeclarativeFolderListModelPrivate;

class QDeclarativeFolderListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QUrl folder READ folder WRITE setFolder NOTIFY folderChanged)
    Q_PROPERTY(QString folderName READ folderName NOTIFY folderChanged)
    Q_PROPERTY(QUrl rootFolder READ rootFolder WRITE setRootFolder)
    Q_PROPERTY(QUrl parentFolder READ parentFolder NOTIFY folderChanged)
    Q_PROPERTY(QStringList nameFilters READ nameFilters WRITE setNameFilters)
    Q_PROPERTY(SortField sortField READ sortField WRITE setSortField)
    Q_PROPERTY(bool sortReversed READ sortReversed WRITE setSortReversed)
    Q_PROPERTY(bool showDirs READ showDirs WRITE setShowDirs)
    Q_PROPERTY(bool showDirsFirst READ showDirsFirst WRITE setShowDirsFirst)
    Q_PROPERTY(bool showDotAndDotDot READ showDotAndDotDot WRITE setShowDotAndDotDot)
    Q_PROPERTY(bool showOnlyReadable READ showOnlyReadable WRITE setShowOnlyReadable)
    Q_PROPERTY(int count READ count NOTIFY rowCountChanged)

public:
    QDeclarativeFolderListModel(QObject *parent = 0);
    ~QDeclarativeFolderListModel();

    enum Roles {
        FileNameRole = Qt::UserRole + 1,
        FilePathRole = Qt::UserRole + 2,
        FileBaseNameRole = Qt::UserRole + 3,
        FileSuffixRole = Qt::UserRole + 4,
        FileSizeRole = Qt::UserRole + 5,
        FileLastModifiedRole = Qt::UserRole + 6,
        FileLastReadRole = Qt::UserRole +7,
        FileIsDirRole = Qt::UserRole + 8
    };

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QHash<int, QByteArray> roleNames() const;

    int count() const { return rowCount(QModelIndex()); }

    QUrl folder() const;
    void setFolder(const QUrl &folder);
    QString folderName() const;
    QUrl rootFolder() const;
    void setRootFolder(const QUrl &path);

    QUrl parentFolder() const;

    bool newFolder(const QString &name);

    QStringList nameFilters() const;
    void setNameFilters(const QStringList &filters);

    enum SortField { Unsorted, Name, Time, Size, Type };
    SortField sortField() const;
    void setSortField(SortField field);
    Q_ENUMS(SortField)

    bool sortReversed() const;
    void setSortReversed(bool rev);

    bool showDirs() const;
    void setShowDirs(bool showDirs);
    bool showDirsFirst() const;
    void setShowDirsFirst(bool showDirsFirst);
    bool showDotAndDotDot() const;
    void setShowDotAndDotDot(bool on);
    bool showOnlyReadable() const;
    void setShowOnlyReadable(bool on);

    Q_INVOKABLE bool isFolder(int index) const;
    Q_INVOKABLE QVariant get(int idx, const QString &property) const;

    int roleFromString(const QString &roleName) const;

Q_SIGNALS:
    void folderChanged();
    void rowCountChanged() const;

private:
    Q_DISABLE_COPY(QDeclarativeFolderListModel)
    Q_DECLARE_PRIVATE(QDeclarativeFolderListModel)
    QScopedPointer<QDeclarativeFolderListModelPrivate> d_ptr;

    Q_PRIVATE_SLOT(d_func(), void _q_directoryChanged(const QString &directory, const QList<FileProperty> &list))
    Q_PRIVATE_SLOT(d_func(), void _q_directoryUpdated(const QString &directory, const QList<FileProperty> &list, int fromIndex, int toIndex))
    Q_PRIVATE_SLOT(d_func(), void _q_sortFinished(const QList<FileProperty> &list))
};

class QDeclarativeFolderListModelPrivate
{
    Q_DECLARE_PUBLIC(QDeclarativeFolderListModel)

public:
    QDeclarativeFolderListModelPrivate(QDeclarativeFolderListModel *q);
    QDeclarativeFolderListModel *q_ptr;
    QUrl currentDir;
    QUrl rootDir;
    FileInfoThread fileInfoThread;
    QList<FileProperty> data;
    QHash<int, QByteArray> roleNames;
    QDeclarativeFolderListModel::SortField sortField;
    QStringList nameFilters;
    bool sortReversed;
    bool showDirs;
    bool showDirsFirst;
    bool showDots;
    bool showOnlyReadable;

    ~QDeclarativeFolderListModelPrivate() {}
    void init();
    void updateSorting();

    void _q_directoryChanged(const QString &directory, const QList<FileProperty> &list);
    void _q_directoryUpdated(const QString &directory, const QList<FileProperty> &list, int fromIndex, int toIndex);
    void _q_sortFinished(const QList<FileProperty> &list);
};


QT_END_HEADER

#endif // QDECLARATIVFOLDERLISTMODEL_H
