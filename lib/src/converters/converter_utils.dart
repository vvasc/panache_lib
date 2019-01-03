import 'dart:math';

import 'package:flutter/material.dart';

String paddingToCode(EdgeInsets padding) => 'EdgeInsets.only('
    'top:${padding.top},'
    'bottom:${padding.bottom},'
    'left:${padding.left}, '
    'right:${padding.right}'
    ')';

Map<String, dynamic> paddingToMap(EdgeInsets padding) => {
      'top': padding.top.toInt(),
      'right': padding.right.toInt(),
      'bottom': padding.bottom.toInt(),
      'left': padding.left.toInt(),
    };

String colorToCode(Color color) {
  if (color == null) return 'null';
  return 'Color( 0x${color.value.toRadixString(16).padLeft(8, '0')} )';
}

String colorSchemeToCode(ColorScheme scheme) {
  return '''ColorScheme(
        primary: ${colorToCode(scheme.primary)},
        primaryVariant: ${colorToCode(scheme.primaryVariant)},
        secondary: ${colorToCode(scheme.secondary)},
        secondaryVariant: ${colorToCode(scheme.secondaryVariant)},
        surface: ${colorToCode(scheme.surface)},
        background: ${colorToCode(scheme.background)},
        error: ${colorToCode(scheme.error)},
        onPrimary: ${colorToCode(scheme.onPrimary)},
        onSecondary: ${colorToCode(scheme.onSecondary)},
        onSurface: ${colorToCode(scheme.onSurface)},
        onBackground: ${colorToCode(scheme.onBackground)},
        onError: ${colorToCode(scheme.onError)},
        brightness: ${scheme.brightness},
      )''';
}

Map<String, dynamic> colorSchemeToMap(ColorScheme scheme) {
  return <String, dynamic>{
    'primary': scheme.primary.value,
    'primaryVariant': scheme.primaryVariant.value,
    'secondary': scheme.secondary.value,
    'secondaryVariant': scheme.secondaryVariant.value,
    'surface': scheme.surface.value,
    'background': scheme.background.value,
    'error': scheme.error.value,
    'onPrimary': scheme.onPrimary.value,
    'onSecondary': scheme.onSecondary.value,
    'onSurface': scheme.onSurface.value,
    'onBackground': scheme.onBackground.value,
    'onError': scheme.onError.value,
    'brightness': Brightness.values.indexOf(scheme.brightness),
  };
}

ColorScheme colorSchemeFromMap(Map<String, dynamic> data) {
  return ColorScheme(
    primary: Color(data['primary']),
    primaryVariant: Color(data['primaryVariant']),
    secondary: Color(data['secondary']),
    secondaryVariant: Color(data['secondaryVariant']),
    surface: Color(data['surface']),
    background: Color(data['background']),
    error: Color(data['error']),
    onPrimary: Color(data['onPrimary']),
    onSecondary: Color(data['onSecondary']),
    onSurface: Color(data['onSurface']),
    onBackground: Color(data['onBackground']),
    onError: Color(data['onError']),
    brightness: Brightness.values[data['brightness']],
  );
}

Map<String, dynamic> borderRadiusToMap(BorderRadiusGeometry radius) {
  final borderRadius = radius as BorderRadius;
  return <String, dynamic>{
    'topLeft': {'x': borderRadius.topLeft.x, 'y': borderRadius.topLeft.y},
    'topRight': {'x': borderRadius.topRight.x, 'y': borderRadius.topRight.y},
    'bottomLeft': {
      'x': borderRadius.bottomLeft.x,
      'y': borderRadius.bottomLeft.y
    },
    'bottomRight': {
      'x': borderRadius.bottomRight.x,
      'y': borderRadius.bottomRight.y
    },
  };
}

String borderSideToCode(BorderSide side) {
  //if (side.style == BorderStyle.none) return 'BorderSide.none';
  return 'BorderSide(color: ${side.color}, width: ${side.width}, style: ${side.style}, )';
}

Map<String, dynamic> borderSideToMap(BorderSide side) {
  return <String, dynamic>{
    'color': side.color,
    'width': side.width.toStringAsFixed(0),
    'style': max(0, BorderStyle.values.indexOf(side.style)),
  };
}

BorderRadius borderRadiusFromMap(Map<String, dynamic> data) {
  return BorderRadius.only(
    topLeft: data['topLeft'],
    topRight: data['topRight'],
    bottomLeft: data['bottomLeft'],
    bottomRight: data['bottomRight'],
  );
}

BorderSide borderSideFromMap(dynamic data) {
  if (data == 'none') return BorderSide.none;
  return BorderSide(
    color: data['color'],
    width: double.parse(data['width']) ?? 1.0,
    style: BorderStyle.values[data['style']],
  );
}
