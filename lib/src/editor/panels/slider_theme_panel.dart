import 'package:flutter/material.dart';

import '../../theme_model.dart';
import '../../utils/constants.dart';
import '../controls/color_selector.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

///
/// [x] activeTickMarkColor
/// [x] inactiveTickMarkColor
/// [x] disabledActiveTickMarkColor
/// [x] disabledInactiveTickMarkColor
///
/// [x] activeTrackColor
/// [x] inactiveTrackColor
/// [x] disabledActiveTrackColor
/// [x] disabledInactiveTrackColor
///
/// [x] overlayColor
///
/// [x] thumbColor
/// [x] disabledThumbColor
/// [-] thumbShape => [SliderComponentShape] => needs custom panache lib
///
/// [x] showValueIndicator => [ShowValueIndicator]
/// [x] valueIndicatorColor
/// [-] valueIndicatorShape => [SliderComponentShape] => needs custom panache lib
/// [x] valueIndicatorTextStyle
///
class SliderThemePanel extends StatelessWidget {
  final ThemeModel model;

  SliderThemeData get sliderTheme => model.theme.sliderTheme;

  SliderThemePanel(this.model);

  Color get thumbColor =>
      model.theme.sliderTheme.thumbColor ?? model.theme.primaryColor;

  TextStyle get indicatorStyle =>
      model.theme.sliderTheme.valueIndicatorTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Show value indicator'),
              DropdownButton(
                  value: sliderTheme.showValueIndicator,
                  items: showIndicatorOptions
                      .map(_buildIndicatorOptions)
                      .toList(growable: false),
                  onChanged: (value) => _updateSliderTheme(
                      sliderTheme.copyWith(showValueIndicator: value))),
            ],
          ),
          getFieldsRow([
            ColorSelector(
              'Thumb color',
              thumbColor,
              (color) =>
                  _updateSliderTheme(sliderTheme.copyWith(thumbColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled thumb color',
              sliderTheme.disabledThumbColor ?? thumbColor.withAlpha(0xB2),
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledThumbColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Value indicator color',
              model.theme.sliderTheme.valueIndicatorColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(valueIndicatorColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Overlay color',
              sliderTheme.overlayColor ?? thumbColor.withAlpha(0xB2),
              (color) =>
                  _updateSliderTheme(sliderTheme.copyWith(overlayColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Active track color',
              sliderTheme.activeTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(activeTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Active tick mark color',
              sliderTheme.activeTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(activeTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Inactive track color',
              sliderTheme.inactiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(inactiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Inactive tick mark color',
              sliderTheme.inactiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(inactiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Disabled Active track color',
              sliderTheme.disabledActiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledActiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled Active tick mark color',
              sliderTheme.disabledActiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledActiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Disabled Inactive track color',
              sliderTheme.disabledInactiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledInactiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled Inactive tick mark color',
              sliderTheme.disabledInactiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledInactiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          _buildValueIndicatorTextStyleControl()
        ],
      ),
    );
  }

  DropdownMenuItem<ShowValueIndicator> _buildIndicatorOptions(
          ShowValueIndicator value) =>
      DropdownMenuItem(
        child: Text('$value'.split('.').last),
        value: value,
      );

  void _updateSliderTheme(SliderThemeData sliderTheme) =>
      model.updateTheme(model.theme.copyWith(sliderTheme: sliderTheme));

  Widget _buildValueIndicatorTextStyleControl() {
    return TextStyleControl(
      'Value indicator text style',
      style: indicatorStyle,
      maxFontSize: 20,
      onColorChanged: (c) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(color: c))),
      onFontStyleChanged: (bool isItalic) =>
          _updateSliderTheme(sliderTheme.copyWith(
              valueIndicatorTextStyle: indicatorStyle.copyWith(
            fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          ))),
      onSizeChanged: (size) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(fontSize: size))),
      onWeightChanged: (bool isBold) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal))),
      onLetterSpacingChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(letterSpacing: value))),
      onLineHeightChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle:
                  sliderTheme.valueIndicatorTextStyle.copyWith(height: value))),
      onWordSpacingChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(wordSpacing: value))),
      onDecorationChanged: (TextDecoration value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decoration: value))),
      onDecorationStyleChanged: (TextDecorationStyle value) =>
          _updateSliderTheme(sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decorationStyle: value))),
      onDecorationColorChanged: (Color value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decorationColor: value))),
    );
  }
}
