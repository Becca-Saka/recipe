// extension DoubleExtension on double {
//   String get removeDecimalZero {
//     return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
//   }
// }
extension DoubleExtension on num {
  String get removeDecimalZero {
    double value = (this).toDouble();
    return value.toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }
}
