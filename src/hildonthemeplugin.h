#ifndef HILDONTHEMEPLUGIN_H
#define HILDONTHEMEPLUGIN_H

#include <QDeclarativeItem>

class QSettings;

class HildonThemePlugin : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor defaultTextColor
               READ defaultTextColor
               CONSTANT)
    Q_PROPERTY(QColor secondaryTextColor
               READ secondaryTextColor
               CONSTANT)
    Q_PROPERTY(QColor activeTextColor
               READ activeTextColor
               CONSTANT)
    Q_PROPERTY(QColor disabledTextColor
               READ disabledTextColor
               CONSTANT)
    Q_PROPERTY(QColor paintedTextColor
               READ paintedTextColor
               CONSTANT)
    Q_PROPERTY(QColor reversedTextColor
               READ reversedTextColor
               CONSTANT)
    Q_PROPERTY(QColor reversedSecondaryTextColor
               READ reversedSecondaryTextColor
               CONSTANT)
    Q_PROPERTY(QColor reversedActiveTextColor
               READ reversedActiveTextColor
               CONSTANT)
    Q_PROPERTY(QColor reversedDisabledTextColor
               READ reversedDisabledTextColor
               CONSTANT)
    Q_PROPERTY(QColor reversedPaintedTextColor
               READ reversedPaintedTextColor
               CONSTANT)
    Q_PROPERTY(QColor defaultBackgroundColor
               READ defaultBackgroundColor
               CONSTANT)
    Q_PROPERTY(QColor darkerBackgroundColor
               READ darkerBackgroundColor
               CONSTANT)
    Q_PROPERTY(QColor reversedBackgroundColor
               READ reversedBackgroundColor
               CONSTANT)
    Q_PROPERTY(QColor selectionColor
               READ selectionColor
               CONSTANT)
    Q_PROPERTY(QColor reversedSelectionColor
               READ reversedSelectionColor
               CONSTANT)
    Q_PROPERTY(QColor contentBackgroundColor
               READ contentBackgroundColor
               CONSTANT)
    Q_PROPERTY(QColor contentFrameColor
               READ contentFrameColor
               CONSTANT)
    Q_PROPERTY(QColor titleTextColor
               READ titleTextColor
               CONSTANT)
    Q_PROPERTY(QColor buttonTextColor
               READ buttonTextColor
               CONSTANT)
    Q_PROPERTY(QColor buttonTextPressedColor
               READ buttonTextPressedColor
               CONSTANT)
    Q_PROPERTY(QColor buttonTextDisabledColor
               READ buttonTextDisabledColor
               CONSTANT)
    Q_PROPERTY(QColor accentColor1
               READ accentColor1
               CONSTANT)
    Q_PROPERTY(QColor accentColor2
               READ accentColor2
               CONSTANT)
    Q_PROPERTY(QColor accentColor3
               READ accentColor3
               CONSTANT)
    Q_PROPERTY(QColor attentionColor
               READ attentionColor
               CONSTANT)
    Q_PROPERTY(QColor notificationBackgroundColor
               READ notificationBackgroundColor
               CONSTANT)
    Q_PROPERTY(QColor notificationTextColor
               READ notificationTextColor
               CONSTANT)
    Q_PROPERTY(QColor notificationSecondaryTextColor
               READ notificationSecondaryTextColor
               CONSTANT)

    Q_PROPERTY(QString fontFamily
               READ fontFamily
               CONSTANT)
    Q_PROPERTY(int fontSizeSmall
               READ fontSizeSmall
               CONSTANT)
    Q_PROPERTY(int fontSizeNormal
               READ fontSizeNormal
               CONSTANT)
    Q_PROPERTY(int fontSizeLarge
               READ fontSizeLarge
               CONSTANT)
    Q_PROPERTY(int fontSizeXLarge
               READ fontSizeXLarge
               CONSTANT)
    Q_PROPERTY(int fontSizeXXLarge
               READ fontSizeXXLarge
               CONSTANT)
    Q_PROPERTY(int fontSizeXXXLarge
               READ fontSizeXXXLarge
               CONSTANT)

    Q_PROPERTY(int popupDurationIn
               READ popupDurationIn
               CONSTANT)
    Q_PROPERTY(int popupDurationOut
               READ popupDurationOut
               CONSTANT)
    Q_PROPERTY(int fadeDurationIn
               READ fadeDurationIn
               CONSTANT)
    Q_PROPERTY(int fadeDurationOut
               READ fadeDurationOut
               CONSTANT)
    Q_PROPERTY(double infoBannerOpacity
               READ infoBannerOpacity
               CONSTANT)
    Q_PROPERTY(double infoNoteOpacity
               READ infoNoteOpacity
               CONSTANT)
    Q_PROPERTY(int desaturation
               READ desaturation
               CONSTANT)
    Q_PROPERTY(bool enableDesaturationEffects
               READ enableDesaturationEffects
               WRITE setEnableDesaturationEffects
               NOTIFY enableDesaturationEffectsChanged)

public:
    explicit HildonThemePlugin(QDeclarativeItem *parent = 0);

    /* Colors */

    inline QColor defaultTextColor() const { return m_defaultTextColor; }
    inline QColor secondaryTextColor() const { return m_secondaryTextColor; }
    inline QColor activeTextColor() const { return m_activeTextColor; }
    inline QColor disabledTextColor() const { return m_disabledTextColor; }
    inline QColor paintedTextColor() const { return m_paintedTextColor; }
    inline QColor reversedTextColor() const { return m_reversedTextColor; }
    inline QColor reversedSecondaryTextColor() const { return m_reversedSecondaryTextColor; }
    inline QColor reversedActiveTextColor() const { return m_reversedActiveTextColor; }
    inline QColor reversedDisabledTextColor() const { return m_reversedDisabledTextColor; }
    inline QColor reversedPaintedTextColor() const { return m_reversedPaintedTextColor; }
    inline QColor defaultBackgroundColor() const { return m_defaultBackgroundColor; }
    inline QColor darkerBackgroundColor() const { return m_darkerBackgroundColor; }
    inline QColor reversedBackgroundColor() const { return m_reversedBackgroundColor; }
    inline QColor selectionColor() const { return m_selectionColor; }
    inline QColor reversedSelectionColor() const { return m_reversedSelectionColor; }
    inline QColor contentBackgroundColor() const { return m_contentBackgroundColor; }
    inline QColor contentFrameColor() const { return m_contentFrameColor; }
    inline QColor contentSelectionColor() const { return m_contentSelectionColor; }
    inline QColor titleTextColor() const { return m_titleTextColor; }
    inline QColor buttonTextColor() const { return m_buttonTextColor; }
    inline QColor buttonTextPressedColor() const { return m_buttonTextPresedColor; }
    inline QColor buttonTextDisabledColor() const { return m_buttonTextDisabledColor; }
    inline QColor accentColor1() const { return m_accentColor1; }
    inline QColor accentColor2() const { return m_accentColor2; }
    inline QColor accentColor3() const { return m_accentColor3; }
    inline QColor attentionColor() const { return m_attentionColor; }
    inline QColor notificationBackgroundColor() const { return m_notificationBackgroundColor; }
    inline QColor notificationTextColor() const { return m_notificationTextColor; }
    inline QColor notificationSecondaryTextColor() const { return m_notificationSecondaryTextColor; }

    /* Font sizes */

    inline QString fontFamily() const { return "Nokia Sans"; }
    inline int fontSizeSmall() const { return 18; }
    inline int fontSizeNormal() const { return 24; }
    inline int fontSizeLarge() const { return 35; }
    inline int fontSizeXLarge() const { return 42; }
    inline int fontSizeXXLarge() const { return 70; }
    inline int fontSizeXXXLarge() const { return 100; }

    /* Transitions */

    inline int popupDurationIn() const { return m_popupDurationIn; }
    inline int popupDurationOut() const { return m_popupDurationOut; }
    inline int fadeDurationIn() const { return m_fadeDurationIn; }
    inline int fadeDurationOut() const { return m_fadeDurationOut; }
    inline double infoBannerOpacity() const { return m_infoBannerOpacity; }
    inline double infoNoteOpacity() const { return m_infoNoteOpacity; }
    inline int desaturation() const { return m_desaturation; }
    inline bool enableDesaturationEffects() const { return m_enableDesaturationEffects; }
    inline void setEnableDesaturationEffects(bool enable) { m_enableDesaturationEffects = enable; emit enableDesaturationEffectsChanged(); }

signals:
    void enableDesaturationEffectsChanged();

private:
    QSettings *m_theme;
    QSettings *m_transitions;
    QColor m_defaultTextColor;
    QColor m_secondaryTextColor;
    QColor m_activeTextColor;
    QColor m_disabledTextColor;
    QColor m_paintedTextColor;
    QColor m_reversedTextColor;
    QColor m_reversedSecondaryTextColor;
    QColor m_reversedActiveTextColor;
    QColor m_reversedDisabledTextColor;
    QColor m_reversedPaintedTextColor;
    QColor m_defaultBackgroundColor;
    QColor m_darkerBackgroundColor;
    QColor m_reversedBackgroundColor;
    QColor m_selectionColor;
    QColor m_reversedSelectionColor;
    QColor m_contentBackgroundColor;
    QColor m_contentFrameColor;
    QColor m_contentSelectionColor;
    QColor m_titleTextColor;
    QColor m_buttonTextColor;
    QColor m_buttonTextPresedColor;
    QColor m_buttonTextDisabledColor;
    QColor m_accentColor1;
    QColor m_accentColor2;
    QColor m_accentColor3;
    QColor m_attentionColor;
    QColor m_notificationBackgroundColor;
    QColor m_notificationTextColor;
    QColor m_notificationSecondaryTextColor;
    int m_popupDurationIn;
    int m_popupDurationOut;
    int m_fadeDurationIn;
    int m_fadeDurationOut;
    double m_infoBannerOpacity;
    double m_infoNoteOpacity;
    int m_desaturation;
    bool m_enableDesaturationEffects;
};

class Desaturation : public QObject
{
    Q_OBJECT

    Q_ENUMS(Effect)

public:
    enum Effect {
        Blurred = 0,
        BlurlessNoColor,
        BlurlessFullColor
    };
};

#endif // HILDONTHEMEPLUGIN_H
