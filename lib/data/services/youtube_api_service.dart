import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class YoutubeApiService {
  final String _youtubeBaseUrl = "https://www.googleapis.com/youtube/v3/";
  String get key => const String.fromEnvironment('YOUTUBE_API_KEY');
  // BY8IG_rMmdcdGDgvuwByStln_eY
  // String get key => const String.fromEnvironment('YOUTUBE_API_KEY');
  Future<List> getVideosDetails(Map<String, dynamic> videoData) async {
    try {
      final videoList = videoData['items'] as List;
      final json = videoList.map((e) => e['id']['videoId'] as String).toList();
      final response = await _getData(
          '${_youtubeBaseUrl}videos?part=statistics&id=${json.join(',')}&key=$key');
      // log('detail response is $response');
      if (response != null) {
        final items = response['items'] as List;
        // final json =
        //     items.map((e) => e['statistics'] as Map<String, dynamic>).toList();
        for (var item in items) {
          final statistics = item['statistics'] as Map<String, dynamic>;
          final id = item['id'] as String;
          final index =
              videoList.indexWhere((element) => element['id']['videoId'] == id);

          // log('detail response index is $index');
          if (index == -1) continue;
          videoList[index]['statistics'] = statistics;
          // videoData['items']
          //         .firstWhere((element) => element['id'] == id)['statistics'] =
          //     statistics;

          log('detail response is $videoList');
        }
      }

      return videoList;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List> getVideos(String query) async {
    try {
      const queryFilters = "type=video&part=snippet";
      final response = await _getData(
        '${_youtubeBaseUrl}search?key=$key&q=$query&$queryFilters',
      );

      if (response != null) {
        return getVideosDetails(response);
      }
      return [];
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return [];
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
