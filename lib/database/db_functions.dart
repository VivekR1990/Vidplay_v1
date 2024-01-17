import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/model/video_model.dart';

ValueNotifier<List<FavoriteData>> favoriteVideoNotifier =
    ValueNotifier<List<FavoriteData>>([]);

class FavoriteFunctions extends ChangeNotifier {
  static const String favBox = 'favorite_videos';

  static Future<void> getFavorites() async {
    final box = await Hive.openBox<FavoriteData>(favBox);
    favoriteVideoNotifier.value.clear();
    favoriteVideoNotifier.value.addAll(box.values.toList());
    favoriteVideoNotifier.notifyListeners();
  }

  static Future<void> addToFavorites(VideoDetails currentVideo) async {
    final FavoriteData currentData = FavoriteData(
      videoPath: currentVideo.videoPath,
      videoName: currentVideo.videoName,
      videoSize: currentVideo.videoSize,
    );

    if (!favoriteVideoNotifier.value
        .any((item) => item.videoPath == currentData.videoPath)) {
      final box = await Hive.openBox<FavoriteData>(favBox);
      await box.add(currentData);
      await getFavorites();
    } else {}
  }

  static Future<void> removeFromFavorites(FavoriteData favorite) async {
    final box = await Hive.openBox<FavoriteData>(favBox);

    final deletedVideo = box.values.toList().indexWhere((video) =>
        video.videoPath == favorite.videoPath &&
        video.videoName == favorite.videoName &&
        video.videoSize == favorite.videoSize);

    if (deletedVideo != -1) {
      await box.deleteAt(deletedVideo);
      await getFavorites();
    } else {}
  }
}
