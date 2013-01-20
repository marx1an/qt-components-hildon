import QtQuick 1.0

Style {
    property url background: "image://theme/BiDirectionalSliderBackground"
    property url backgroundDisabled: "image://theme/BiDirectionalSliderBackgroundDisabled"
    property url valueBackground: "image://theme/SliderLeftside"
    property url valueBackgroundDisabled: "image://theme/SliderLeftsideDisabled"
    property url handle: "image://theme/SliderThumb"
    property url handleDisabled: "image://theme/SliderThumbDisabled"
    property url centerPointBackground: "image://theme/BiDirectionalSliderCenterPoint"
    property url centerPointBackgroundDisabled: "image://theme/BiDirectionalSliderCenterPointDisabled"
    property url highlight: "image://theme/Progressbar"

    property int backgroundMarginRight: 10
    property int backgroundMarginLeft: 10
    property int backgroundMarginTop: 10
    property int backgroundMarginBottom: 10

    property int sliderWidth: 250
    property int sliderHeight: 60
}
