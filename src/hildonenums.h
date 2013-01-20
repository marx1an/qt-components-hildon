#ifndef HILDONENUMS_H
#define HILDONENUMS_H

#include <QObject>

class HildonValueLayout : public QObject
{
    Q_OBJECT

    Q_ENUMS(ValueLayout)

public:
    enum ValueLayout {
        ValueBesideText = 0,
        ValueUnderText,
        ValueUnderTextCentered
    };
};

class HildonDialogStatus : public QObject
{
    Q_OBJECT

    Q_ENUMS(DialogStatus)

public:
    enum DialogStatus {
        Opening = 0,
        Open,
        Closing,
        Closed
    };
};

class HildonScreenOrientation : public QObject
{
    Q_OBJECT

    Q_ENUMS(ScreenOrientation)

public:
    enum ScreenOrientation {
        Automatic = 0,
        LockPortrait,
        LockLandscape
    };
};

class HildonNetworkMode : public QObject
{
    Q_OBJECT

    Q_ENUMS(NetworkMode)

public:
    enum NetworkMode {
        UnknownMode = 0,
        GsmMode,
        CdmaMode,
        WcdmaMode,
        WlanMode,
        EthernetMode,
        BluetoothMode,
        WimaxMode,
        LteMode
    };
};

#endif // HILDONENUMS_H
