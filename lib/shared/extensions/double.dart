extension DoubleExtension on double {
  String get removeDecimalZero {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }
}
