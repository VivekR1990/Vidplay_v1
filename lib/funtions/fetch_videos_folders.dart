import 'package:list_all_videos/list_all_videos.dart';

List<VideoDetails> videoList = [];

Future<List<VideoDetails>> getAllVideosAsList({String? folderPath}) async {
  List<VideoDetails> result = [];

  if (videoList.isEmpty) {
    videoList = await ListAllVideos().getAllVideos();
  }
  if (folderPath != null) {
    for (VideoDetails video in videoList) {
      if (video.videoPath.startsWith(folderPath)) {
        result.add(video);
      }
    }
  } else {
    result.addAll(videoList);
  }
  return result;
}
