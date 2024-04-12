import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class YoutubeApiService {
  final String _youtubeBaseUrl = "https://www.googleapis.com/youtube/v3/";
  String get key => const String.fromEnvironment('YOUTUBE_API_KEY');
  Future<Map<String, dynamic>?> getVideos(String query) async {
    try {
      const queryFilters = "type=video&part=snippet";
      final response = await _getData(
        '${_youtubeBaseUrl}search?key=$key&q=$query&$queryFilters',
      );
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> _getData(String url) async {
    try {
      final response = await get(Uri.parse(url));
      print('response is ${response.body}');
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
