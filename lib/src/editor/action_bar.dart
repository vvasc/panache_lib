import 'package:flutter/material.dart';
import 'package:flutterial_components/src/editor/controls/brightness_control.dart';
import 'package:flutterial_components/src/editor/controls/color_selector.dart';
import 'package:flutterial_components/src/utils/color_utils.dart';

import '../theme_model.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ThemeModel.of(context);
    //final onAndroid = model.theme.platform == TargetPlatform.android;
    final isDark = model.theme.brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 48),
          color: Colors.blueGrey.shade300,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text('Panache',
                  style: TextStyle(fontSize: 24, color: Colors.white70)),
              FlatButton.icon(
                  onPressed: model.exportTheme,
                  icon: Icon(Icons.save),
                  label: Text('Export'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColorSelector(
                'Primary swatch',
                model.theme.primaryColor,
                (color) => _onSwatchSelection(model, color),
                padding: 0,
              ),
              BrightnessSelector(
                isDark: isDark,
                label: 'Brightness',
                onBrightnessChanged: (value) =>
                    _onThemeBrightnessChanged(model, value),
              ),
              /*Text('Platform: Android'),
              Switch(
                onChanged: (value) => _onPlatformChanged(
                      model,
                      value ? TargetPlatform.iOS : TargetPlatform.android,
                    ),
                value: onAndroid,
              ),
              Text('iOS'),*/
            ],
          ),
        ),
      ],
    );
  }

  /*void _onPlatformChanged(ThemeModel model, TargetPlatform platform) =>
      model.updateTheme(model.theme.copyWith(platform: platform));*/

  void _onThemeBrightnessChanged(ThemeModel model, Brightness brightness) =>
      model.updateTheme(ThemeData.localize(
          ThemeData(
              primarySwatch: model.primarySwatch ??
                  swatchFor(color: model.theme.primaryColor),
              brightness: brightness),
          model.theme.textTheme));

  void _onSwatchSelection(ThemeModel model, MaterialColor swatch) {
    model.initTheme(primarySwatch: swatch, brightness: model.theme.brightness);
  }
}
