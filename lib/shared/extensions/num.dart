extension NumExtension on num {
  String get removeDecimalZero {
    double value = (this).toDouble();
    return value.toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }

  String get minify {
    if (this >= 1000000000000) {
      return '${(this / 1000000000000).toStringAsFixed(1)}t';
    } else if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}b';
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}m';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}k';
    } else {
      return toString();
    }
  }
}
