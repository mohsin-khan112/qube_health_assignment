import 'package:flutter/cupertino.dart';

import '../constant/app_colors.dart';

Widget labels({
  @required String? text,
  Color color = AppColors.textColor,
  final textStyle,
  final double? size = 14.0,
  final maxLines,
  TextAlign textAlign = TextAlign.center,
  FontWeight fontWeight = FontWeight.normal,
  TextOverflow overflow = TextOverflow.visible,
}) =>
    Text(
      text ?? '',
      overflow: overflow,
      maxLines: maxLines,

      style: textStyle ??
          defaultTextStyle(
            color: color,
            size: size,
            fontWeight: fontWeight,
          ),
      textAlign: textAlign,
    );

TextStyle defaultTextStyle({
  final color,
  final size,
  final fontWeight,
  final decoration,
}) =>
    TextStyle(
      decoration: decoration,
      color: color ?? AppColors.textColor,
      fontSize: size ?? 14.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
