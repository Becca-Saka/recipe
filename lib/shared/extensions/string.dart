import 'package:intl/intl.dart';

extension StringExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
  // String get spaced => this;
  String get spaced => replaceAll('\\n ', '\n')
      .replaceAll(r'\n ', '\n')
      .replaceAll(r'\n', '\n')
      .replaceAll('  ', '');
  String get singlarize =>
      endsWith('s') ? replaceRange(lastIndexOf('s'), null, ' ') : this;

  String get imagify => (split(' ').length == 1
          ? singlarize
          : split(' ').map((str) => str.trim()).join(' ').replaceAll(' ', '-'))
      .toLowerCase();

  String get formatDate {
    final date = DateTime.tryParse(this);
    if (date != null) {
      final diffInHours = DateTime.now().difference(date).inHours;
      final diffInMinutes = (diffInHours * 60 * 60) ~/ 60;
      final diffInDays = diffInHours ~/ 24;
      final diffInWeeks = diffInDays ~/ 7;
      final diffInMonths = diffInWeeks ~/ 4;
      if (diffInMinutes <= 1) {
        return '1 minute ago';
      } else if (diffInMinutes < 60 && diffInHours < 1) {
        return '$diffInMinutes minutes ago';
      } else if (diffInHours == 1) {
        return '$diffInHours hour ago';
      } else if (diffInHours < 24 && diffInDays < 1) {
        return '$diffInHours hours ago';
      } else if (diffInDays <= 1) {
        return 'Today';
      } else if (diffInDays > 1 && diffInDays <= 2) {
        return 'Yesterday';
      } else if (diffInDays < 7) {
        return '$diffInDays days ago';
      } else if (diffInWeeks <= 1) {
        return 'a week ago';
      } else if (diffInWeeks <= 4 && diffInMonths <= 1) {
        return '$diffInWeeks weeks ago';
      } else if (diffInMonths > 1 && diffInMonths <= 12) {
        return '$diffInMonths months ago';
      } else if (diffInMonths > 12) {
        return '${diffInMonths ~/ 12} years ago';
      } else {
        return DateFormat('yyyy-MM-dd').format(date);
      }
    }
    return this;
  }
}
