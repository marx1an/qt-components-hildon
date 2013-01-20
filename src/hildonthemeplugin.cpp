#include "hildonthemeplugin.h"
#include <QSettings>
#include <QFileInfo>

HildonThemePlugin::HildonThemePlugin(QDeclarativeItem *parent) :
    QObject(parent),
    m_theme(new QSettings("/etc/hildon/theme/colors.config", QSettings::IniFormat, this)),
    m_transitions(0),
    m_enableDesaturationEffects(false)
{
    m_theme->beginGroup("Colors");
    m_defaultTextColor.setNamedColor(m_theme->value("DefaultTextColor").toString());
    m_secondaryTextColor.setNamedColor(m_theme->value("SecondaryTextColor").toString());
    m_activeTextColor.setNamedColor(m_theme->value("ActiveTextColor").toString());
    m_disabledTextColor.setNamedColor(m_theme->value("DisabledTextColor").toString());
    m_paintedTextColor.setNamedColor(m_theme->value("PaintedTextColor").toString());
    m_reversedTextColor.setNamedColor(m_theme->value("ReversedTextColor").toString());
    m_reversedSecondaryTextColor.setNamedColor(m_theme->value("ReversedSecondaryTextColor").toString());
    m_reversedActiveTextColor.setNamedColor(m_theme->value("ReversedActiveTextColor").toString());
    m_reversedDisabledTextColor.setNamedColor(m_theme->value("ReversedDisabledTextColor").toString());
    m_reversedPaintedTextColor.setNamedColor(m_theme->value("ReversedPaintedTextColor").toString());
    m_defaultBackgroundColor.setNamedColor(m_theme->value("DefaultBackgroundColor").toString());
    m_darkerBackgroundColor.setNamedColor(m_theme->value("DarkerBackgroundColor").toString());
    m_reversedBackgroundColor.setNamedColor(m_theme->value("ReversedBackgroundColor").toString());
    m_selectionColor.setNamedColor(m_theme->value("SelectionColor").toString());
    m_reversedSelectionColor.setNamedColor(m_theme->value("ReversedSelectionColor").toString());
    m_contentBackgroundColor.setNamedColor(m_theme->value("ContentBackgroundColor").toString());
    m_contentFrameColor.setNamedColor(m_theme->value("ContentFrameColor").toString());
    m_contentSelectionColor.setNamedColor(m_theme->value("ContentSelectionColor").toString());
    m_titleTextColor.setNamedColor(m_theme->value("TitleTextColor").toString());
    m_buttonTextColor.setNamedColor(m_theme->value("ButtonTextColor").toString());
    m_buttonTextPresedColor.setNamedColor(m_theme->value("ButtonTextPressedColor").toString());
    m_buttonTextDisabledColor.setNamedColor(m_theme->value("ButtonTextDisabledColor").toString());
    m_accentColor1.setNamedColor(m_theme->value("AccentColor1").toString());
    m_accentColor2.setNamedColor(m_theme->value("AccentColor2").toString());
    m_accentColor3.setNamedColor(m_theme->value("AccentColor3").toString());
    m_attentionColor.setNamedColor(m_theme->value("AttentionColor").toString());
    m_notificationBackgroundColor.setNamedColor(m_theme->value("NotificationBackgroundColor").toString());
    m_notificationTextColor.setNamedColor(m_theme->value("NotificationTextColor").toString());
    m_notificationSecondaryTextColor.setNamedColor(m_theme->value("NotificationSecondaryTextColor").toString());
    m_theme->endGroup();

    QFileInfo info("/etc/hildon/theme/transitions.ini");

    if (info.exists()) {
        m_transitions = new QSettings(info.absoluteFilePath(), QSettings::IniFormat, this);
    }
    else {
        m_transitions = new QSettings("/usr/share/hidon-desktop/transitions.ini", QSettings::IniFormat, this);
    }

    m_transitions->beginGroup("popup");
    m_popupDurationIn = m_transitions->value("duration_in", 250).toInt();
    m_popupDurationOut = m_transitions->value("duration_out", 250).toInt();
    m_transitions->endGroup();

    m_transitions->beginGroup("fade");
    m_fadeDurationIn = m_transitions->value("duration_in", 200).toInt();
    m_fadeDurationOut = m_transitions->value("duration_out", 500).toInt();
    m_infoBannerOpacity = m_transitions->value("info_note_alpha", 0.85).toDouble();
    m_infoNoteOpacity = m_transitions->value("banner_note_alpha", 0.85).toDouble();
    m_transitions->endGroup();

    m_transitions->beginGroup("thp_tweaks");
    int blurless = m_transitions->value("blurless", 0).toInt();
    int blurlessSaturation = m_transitions->value("blurless_saturation", 0).toInt();
    m_transitions->endGroup();

    if (blurless) {
        if (blurlessSaturation) {
            m_desaturation = Desaturation::Effect(Desaturation::BlurlessFullColor);
        }
        else {
            m_desaturation = Desaturation::Effect(Desaturation::BlurlessNoColor);
        }
    }
    else {
        m_desaturation = Desaturation::Effect(Desaturation::Blurred);
    }
}
