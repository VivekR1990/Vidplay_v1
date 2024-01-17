import 'package:hive_flutter/hive_flutter.dart';
part 'video_playlist.g.dart';

@HiveType(typeId: 3)
class VideoPlaylist {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String>? videos;

  VideoPlaylist({
    required this.name,
    this.videos,
  });
}
