import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/model/video_model.dart';

ValueNotifier<List<FavoriteData>> rcentVideoNotifier =
    ValueNotifier<List<FavoriteData>>([]);

class RcentFunctions extends ChangeNotifier {
  static const String recentBox = 'recent_videos';

static Future<void> getRecent() async {
    final box = await Hive.openBox<FavoriteData>(recentBox);
    rcentVideoNotifier.value.clear();
    rcentVideoNotifier.value.addAll(box.values.toList());
    rcentVideoNotifier.notifyListeners();
  }

  static Future<void> addTorecent(VideoDetails currentVideo) async {
    final FavoriteData currentData = FavoriteData(
      videoPath: currentVideo.videoPath,
      videoName: currentVideo.videoName,
      videoSize: currentVideo.videoSize,
    );

    if (!rcentVideoNotifier.value
        .any((item) => item.videoPath == currentData.videoPath)) {
      final box = await Hive.openBox<FavoriteData>(recentBox);
      await box.add(currentData);
      await getRecent();
    } else {}
  }
  static Future<void> removeFromRecent(FavoriteData favorite) async {
    final box = await Hive.openBox<FavoriteData>(recentBox);

    final deletedVideo = box.values.toList().indexWhere((video) =>
        video.videoPath == favorite.videoPath &&
        video.videoName == favorite.videoName &&
        video.videoSize == favorite.videoSize);

    if (deletedVideo != -1) {
      await box.deleteAt(deletedVideo);
      await getRecent();
    } else {}
  }
}
