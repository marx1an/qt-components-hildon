#include "filesystemmodel.h"

FileSystemModel::FileSystemModel(QDeclarativeItem *parent) :
    QSortFilterProxyModel(parent), m_model(new QDeclarativeFolderListModel(this))
{
    connect(m_model, SIGNAL(folderChanged()), this, SIGNAL(folderChanged()));
    connect(m_model, SIGNAL(rowCountChanged()), this, SIGNAL(countChanged()));
    setSourceModel(m_model);
    setRoleNames(m_model->roleNames());
    setFilterRole(QDeclarativeFolderListModel::FileNameRole);
    setDynamicSortFilter(true);
}

void FileSystemModel::setQuery(const QString &query) {
    if (query != m_query) {
        m_query = query;
        setFilterRegExp(QRegExp(query, Qt::CaseInsensitive, QRegExp::FixedString));
        emit queryChanged();
    }
}
