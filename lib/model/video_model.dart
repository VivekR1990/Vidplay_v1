import 'package:hive_flutter/hive_flutter.dart';
part 'video_model.g.dart';

@HiveType(typeId: 1)
class FavoriteData {
  @HiveField(0)
  final String videoPath;
  @HiveField(1)
  final String videoName;
  @HiveField(2)
  final String videoSize;

  FavoriteData({
    required this.videoPath,
    required this.videoName,
    required this.videoSize,
  });

  get key => null;
}
