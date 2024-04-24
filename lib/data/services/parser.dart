import 'dart:convert';

Map<String, dynamic> getJsonFromString(String rawText) {
  // // Will find, for exemple, the text: "{isUserActive:"
  // final regexMapKeyWithOpenBracket = RegExp('(?<={)(.*?):+');
  // // Will find, for exemple, the text: ", userCourses:"
  // final regexMapKeyWithCommaAndSpace = RegExp(r'(?<=, )([^\]]*?):');

  // final regexOnlyKeyInLine = RegExp(r'^.+:$');

  // final splitedSentences = rawText
  //     .replaceAllMapped(regexMapKeyWithCommaAndSpace,
  //         (Match match) => '\n${match.text.trim()}\n')
  //     .replaceAllMapped(regexMapKeyWithOpenBracket,
  //         (Match match) => '\n${match.text.trim()}\n')
  //     .replaceAll(RegExp(r'}(?=,|]|}|$|\s+)'), '\n}\n')
  //     .replaceAll(RegExp(r'(?<=(,|:|^|\[)\s?){'), '\n{\n')
  //     .replaceAll(RegExp('\\[\\s?\\]'), '\n[\n]\n')
  //     .replaceAll(RegExp('\\{\\s?\\}'), '\n{\n}\n')
  //     .replaceAll('[', '\n[\n')
  //     .replaceAll(']', '\n]\n')
  //     .replaceAll(',', '\n,\n')
  //     .split('\n')
  //   ..removeWhere((element) => element.replaceAll(' ', '').isEmpty);

  // final List<String> correctLines = [];
  // for (String line in splitedSentences) {
  //   final isMapKey = regexOnlyKeyInLine.hasMatch(line);

  //   if (isMapKey) {
  //     final lineWithoutFinalTwoDots = line.substring(0, line.length - 1);
  //     final lineWithQuaot = _putQuotationMarks(lineWithoutFinalTwoDots);

  //     correctLines.add('$lineWithQuaot:');
  //   } else {
  //     String l = line.trim();

  //     final hasCommaInFinal = l.endsWith(',') && l.length > 1;
  //     if (hasCommaInFinal) l = l.substring(0, l.length - 1);

  //     // If it falls in this else, it is a value of a key or a map structure
  //     final isNumber = double.tryParse(l) != null || int.tryParse(l) != null;
  //     final isBolean = l == 'false' || l == 'true';
  //     final isStructureCaracter = ['{', '}', '[', ']', ','].any((e) => e == l);
  //     final isNull = l == 'null';
  //     if (isStructureCaracter || isNumber || isBolean || isNull) {
  //       if (hasCommaInFinal) {
  //         correctLines.add('$l,');
  //       } else {
  //         correctLines.add(l);
  //       }
  //       continue;
  //     }

  //     // If you got to this point, i'm sure it's a value string, so lets add a double quote
  //     final lineWithQuaot = _putQuotationMarks(l);
  //     if (hasCommaInFinal) {
  //       correctLines.add('$lineWithQuaot,');
  //     } else {
  //       correctLines.add(lineWithQuaot);
  //     }
  //   }
  // }
  // log("--------------");
  // log("$correctLines");

  // final Map<String, dynamic> decoded = {};
  // (jsonDecode('{"hello":"s"}') as Map)
  // (jsonDecode(correctLines.join('')) as Map)
  //     .cast<String, dynamic>()
  //     .forEach((key, value) {
  //   decoded[key] = value;
  // });
  return jsonDecode(r'' + rawText);
  // return decoded;
}

extension MatchExtension on Match {
  String get text => input.substring(start, end);
}

String _putQuotationMarks(String findedText) {
  if (!findedText.startsWith('\'') && !findedText.startsWith('"')) {
    findedText = findedText[0] + findedText.substring(1);
  }
  if (!findedText.endsWith('\'')) {
    final lastIndex = findedText.length - 1;
    findedText = findedText.substring(0, lastIndex) + findedText[lastIndex];
  }
  return '"$findedText"';
}
