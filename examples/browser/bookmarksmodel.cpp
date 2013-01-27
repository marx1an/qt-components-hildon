#include "bookmarksmodel.h"
#include <QDomNodeList>
#include <QDir>
#include <QFile>
#include <QTextStream>

BookmarksModel::BookmarksModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    this->setRoleNames(roles);
}

BookmarksModel::~BookmarksModel() {}

void BookmarksModel::setFileName(const QString &fileName) {
    if (fileName != this->fileName()) {
        m_fileName = fileName;
        this->loadBookmarks();
    }
}

int BookmarksModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)

    return m_document.documentElement().childNodes().size();
}

QVariant BookmarksModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case TitleRole:
        return m_document.documentElement().childNodes().at(index.row()).firstChildElement("title").text();
    case UrlRole:
        return m_document.documentElement().childNodes().at(index.row()).toElement().attribute("href");
    default:
        return QVariant();
    }
}

QVariant BookmarksModel::data(int row, const QByteArray &roleName) const {
    return this->data(this->index(row), this->roleNames().key(roleName));
}

bool BookmarksModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid()) {
        return false;
    }

    switch (role) {
    case TitleRole:
        m_document.documentElement().childNodes().at(index.row()).firstChildElement("title").firstChild().setNodeValue(value.toString());
        emit dataChanged(index, index);
        return this->saveBookmarks();
    case UrlRole:
        m_document.documentElement().childNodes().at(index.row()).toElement().setAttribute("href", value.toString());
        emit dataChanged(index, index);
        return this->saveBookmarks();
    default:
        return false;
    }
}

bool BookmarksModel::setData(int row, const QVariant &value, const QByteArray &roleName) {
    return this->setData(this->index(row), value, this->roleNames().key(roleName));
}

bool BookmarksModel::addBookmark(const QString &title, const QString &url) {
    QDomElement bookmark = m_document.createElement("bookmark");
    QDomElement titleElement = m_document.createElement("title");
    QDomText titleText = m_document.createTextNode(title);

    if ((bookmark.isNull()) || (titleElement.isNull())) {
        return false;
    }

    bookmark.setAttribute("href", url);
    titleElement.appendChild(titleText);
    bookmark.appendChild(titleElement);

    this->beginInsertRows(QModelIndex(), this->rowCount(), this->rowCount());
    QDomNode newChild = m_document.documentElement().appendChild(bookmark);
    this->endInsertRows();

    if (!newChild.isNull()) {
        emit countChanged(this->rowCount());
        return this->saveBookmarks();
    }

    return false;
}

bool BookmarksModel::removeBookmark(const QString &url) {
    for (int i = 0; i < m_document.documentElement().childNodes().size(); i++) {
        QDomNode bookmark = m_document.documentElement().childNodes().at(i);

        if (bookmark.toElement().attribute("href") == url) {
            this->beginRemoveRows(QModelIndex(), i, i);
            QDomNode removedChild = m_document.documentElement().removeChild(bookmark);
            this->endRemoveRows();

            if (!removedChild.isNull()) {
                emit countChanged(this->rowCount());
                return this->saveBookmarks();
            }

            return false;
        }
    }

    return false;
}

bool BookmarksModel::removeBookmark(int row) {
    Q_ASSERT((row >= 0) && (row < this->rowCount()));

    this->beginRemoveRows(QModelIndex(), row, row);
    QDomNode removedChild = m_document.documentElement().removeChild(m_document.documentElement().childNodes().at(row));
    this->endRemoveRows();

    if (!removedChild.isNull()) {
        emit countChanged(this->rowCount());
        return this->saveBookmarks();
    }

    return false;
}

void BookmarksModel::loadBookmarks() {
    QDir dir(this->fileName());
    dir.cdUp();

    if (!dir.exists(dir.path())) {
        dir.mkpath(dir.path());
    }

    QFile file(this->fileName());

    if ((file.exists()) && (file.open(QIODevice::ReadOnly)) && (m_document.setContent(&file)) && (this->rowCount() > 0)) {
        emit countChanged(this->rowCount());
    }
    else {
        QByteArray doc("<xbel version=\"1.0\"><bookmark href=\"http://talk.maemo.org/\"><title>talk.maemo.org</title><desc>Maemo Talk</desc></bookmark></xbel>");
        m_document.setContent(doc);
        this->saveBookmarks();
        emit countChanged(this->rowCount());
    }
}

bool BookmarksModel::saveBookmarks() {
    QFile file(this->fileName());

    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        const int IndentSize = 4;
        QTextStream out(&file);
        m_document.save(out, IndentSize);
        return true;
    }

    return false;
}
