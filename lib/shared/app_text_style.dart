import 'package:flutter/material.dart';

abstract class AppTextStyle {
  /// Base text style
  static const TextStyle _baseTextStyle = TextStyle(
      fontFamily: 'SF Pro',
      fontWeight: AppFontWeight.regular,
      letterSpacing: -0.3,
      color: Colors.white);

  // ///SF Pro 12
  // static TextStyle get bodySmall => _baseTextStyle.copyWith(fontSize: 12);

  // ///SF Pro Bold 12
  // static TextStyle get bodySmallBold =>
  //     bodySmall.copyWith(fontWeight: AppFontWeight.bold);

  // ///SF Pro semibold 12
  // static TextStyle get bodySmallSemiBold =>
  //     bodySmall.copyWith(fontWeight: AppFontWeight.semiBold);
  // static TextStyle get bodySmallMedium =>
  //     bodySmall.copyWith(fontWeight: AppFontWeight.medium);
  // ///SF Pro 14
  // static TextStyle get titleSmall => _baseTextStyle.copyWith(fontSize: 14);

  // ///SF Pro semibold 14
  // static TextStyle get titleSmallSemiBold =>
  //     titleSmall.copyWith(fontWeight: AppFontWeight.semiBold);

  // ///SF Pro medium 14
  // static TextStyle get titleSmallMedium =>
  //     titleSmall.copyWith(fontWeight: AppFontWeight.medium);

  ///SF Pro 10
  static TextStyle get regular10 => _baseTextStyle.copyWith(fontSize: 10);

  ///SF Pro medium 10
  static TextStyle get medium10 =>
      regular10.copyWith(fontWeight: AppFontWeight.medium);

  ///SF Pro medium 14
  static TextStyle get medium14 => regular10.copyWith(
        fontWeight: AppFontWeight.medium,
        fontSize: 14,
      );

  ///SF Pro 14
  static TextStyle get regular14 => _baseTextStyle.copyWith(fontSize: 14);

  ///SF Pro bold 14
  static TextStyle get semibold14 =>
      regular16.copyWith(fontWeight: AppFontWeight.semiBold);

  ///SF Pro 16
  static TextStyle get regular16 => _baseTextStyle.copyWith(fontSize: 16);

  ///SF Pro bold 16
  static TextStyle get bold16 =>
      regular16.copyWith(fontWeight: AppFontWeight.bold);
}

abstract class AppFontWeight {
  /// FontWeight value of `w900`
  static const FontWeight black = FontWeight.w900;

  /// FontWeight value of `w800`
  static const FontWeight extraBold = FontWeight.w800;

  /// FontWeight value of `w700`
  static const FontWeight bold = FontWeight.w700;

  /// FontWeight value of `w600`
  static const FontWeight semiBold = FontWeight.w600;

  /// FontWeight value of `w500`
  static const FontWeight medium = FontWeight.w500;

  /// FontWeight value of `w400`
  static const FontWeight regular = FontWeight.w400;

  /// FontWeight value of `w300`
  static const FontWeight light = FontWeight.w300;

  /// FontWeight value of `w200`
  static const FontWeight extraLight = FontWeight.w200;

  /// FontWeight value of `w100`
  static const FontWeight thin = FontWeight.w100;
}
