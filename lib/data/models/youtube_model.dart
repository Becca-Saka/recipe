class YoutubeSearchItem {
  final String id;
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final String imageUrl;
  final String channelTitle;
  final String liveBroadcastContent;
  final String publishTime;
  YoutubeSearchItem({
    required this.id,
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  factory YoutubeSearchItem.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final image = snippet['thumbnails']['default']['url'];
    return YoutubeSearchItem(
      id: json['id']['videoId'],
      publishedAt: snippet['publishedAt'],
      channelId: snippet['channelId'],
      title: snippet['title'],
      description: snippet['description'],
      imageUrl: image,
      channelTitle: snippet['channelTitle'],
      liveBroadcastContent: snippet['liveBroadcastContent'],
      publishTime: snippet['publishTime'],
    );
  }
}
