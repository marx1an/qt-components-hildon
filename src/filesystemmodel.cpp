#include "filesystemmodel.h"
#include <QDeclarativeItem>

FileSystemModel::FileSystemModel(QDeclarativeItem *parent) :
    QSortFilterProxyModel(parent),
    m_model(new QDeclarativeFolderListModel(this))
{
    this->connect(m_model, SIGNAL(folderChanged()), this, SIGNAL(folderChanged()));
    this->connect(m_model, SIGNAL(rowCountChanged()), this, SIGNAL(countChanged()));
    this->setSourceModel(m_model);
    this->setRoleNames(m_model->roleNames());
    this->setFilterRole(QDeclarativeFolderListModel::FileNameRole);
    this->setDynamicSortFilter(true);
}

void FileSystemModel::setQuery(const QString &query) {
    if (query != m_query) {
        m_query = query;
        this->setFilterRegExp(QRegExp(query, Qt::CaseInsensitive, QRegExp::FixedString));
        emit queryChanged();
    }
}
