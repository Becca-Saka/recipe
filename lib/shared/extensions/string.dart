extension StringExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
  // String get spaced => this;
  String get spaced => replaceAll(r'\n ', '\n').replaceAll('  ', '');
}
