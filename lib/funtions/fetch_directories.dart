import 'dart:io';

import 'package:list_all_videos/list_all_videos.dart';

class DirectoryFetcher {
  static Future<List<String>> getAllDirectories() async {
    Set<String> directories = {};

    final List<VideoDetails> videos = await ListAllVideos().getAllVideos();
    for (VideoDetails video in videos) {
      directories.add(Directory(video.videoPath).parent.path);
    }
    return directories.toList();
  }
}
