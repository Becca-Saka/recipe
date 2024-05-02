///Handles parsing json data resturn from [GeminiService]
class CustomJSONParser {
  int _index = 0;
  final String _source;

  CustomJSONParser(this._source);

  dynamic parse() {
    _skipWhitespace();
    return _parseValue();
  }

  dynamic _parseValue() {
    if (_source[_index] == '{') {
      return _parseObject();
    } else if (_source[_index] == '[') {
      return _parseArray();
    } else if (_source[_index] == '"') {
      return _parseString();
    } else if (_isDigit(_source[_index]) || _source[_index] == '-') {
      return _parseNumber();
    } else if (_source.startsWith('true', _index)) {
      _index += 4;
      return true;
    } else if (_source.startsWith('false', _index)) {
      _index += 5;
      return false;
    } else if (_source.startsWith('null', _index)) {
      _index += 4;
      return null;
    } else {
      throw FormatException('Unexpected character: ${_source[_index]}');
    }
  }

  Map<String, dynamic> _parseObject() {
    var object = <String, dynamic>{};
    _index++; // Skip the '{'
    _skipWhitespace();
    while (_source[_index] != '}') {
      var key = _parseString();
      _skipWhitespace();

      if (_source[_index++] != ':') {
        throw FormatException(
            'Expected colon after key at $key ${_source[_index++]}');
      }

      _skipWhitespace();
      var value = _parseValue();
      object[key] = value;
      _skipWhitespace();
      if (_source[_index] == ',') {
        _index++; // Skip the ','
        _skipWhitespace();
      }
    }
    _index++; // Skip the '}'
    return object;
  }

  List<dynamic> _parseArray() {
    var array = <dynamic>[];
    _index++; // Skip the '['
    _skipWhitespace();
    while (_source[_index] != ']') {
      var value = _parseValue();
      array.add(value);
      _skipWhitespace();
      if (_source[_index] == ',') {
        _index++; // Skip the ','
        _skipWhitespace();
      }
    }
    _index++; // Skip the ']'
    return array;
  }

  String _parseString() {
    var startIndex = ++_index; // Skip the opening quote
    while (_source[_index] != '"') {
      _index++;
    }
    var string = _source.substring(startIndex, _index);
    _index++; // Skip the closing quote
    return string;
  }

  num _parseNumber() {
    var startIndex = _index;
    while (_isDigit(_source[_index]) ||
        _source[_index] == '.' ||
        _source[_index] == '-') {
      _index++;
    }
    var numberString = _source.substring(startIndex, _index);
    return num.parse(numberString);
  }

  void _skipWhitespace() {
    while (_index < _source.length && _isWhitespace(_source[_index])) {
      _index++;
    }
  }

  bool _isDigit(String string) {
    final char = num.tryParse(string);
    return char != null;
  }

  bool _isWhitespace(String char) =>
      char == ' ' || char == '\n' || char == '\r' || char == '\t';
}
