import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe/data/tokens.dart';

class PexelsApiService {
  final String _pexelsBaseUrl = "https://api.pexels.com/v1/search?";
  String get key => pexelsAPIKey;

  ///Finds a picture by keyword on pexels and return a single image
  Future<String?> getPicture(String query) async {
    try {
      const queryFilters = "per_page=1";
      final response = await _getData(
        '${_pexelsBaseUrl}query=$query&$queryFilters&$queryFilters',
      );
      if (response != null) {
        final results = response['photos'] as List;
        if (results.isNotEmpty) {
          results.shuffle();
          return results.first['src']['medium'] as String;
        }
      }
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> _getData(String url) async {
    try {
      final request = Request('GET', Uri.parse(url));
      request.headers.addAll({
        'Authorization': key,
        'Content-Type': 'application/json',
      });
      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(body) as Map<String, dynamic>;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
