import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/database/db_recent_played.dart';
import 'package:video_vid_play/presentation/screens/all_video/search.dart';
import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/custom_tile.dart';
import 'package:video_vid_play/widgets/sort_videos.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';
import 'package:video_vid_play/widgets/video_menu.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<VideoDetails> mutableVideoList = [];

  void updateVideoList(List<VideoDetails> sortedList) {
    setState(() {
      mutableVideoList = List.from(sortedList);
    });
  }

  Future<void> fetchVideoData() async {
    List<VideoDetails> fetchedVideos = await ListAllVideos().getAllVideos();
    setState(() {
      mutableVideoList = List.from(fetchedVideos);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mutableVideoList.isEmpty) {
      fetchVideoData();
    }
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
            image: AssetImage("asset/images/vidPlay.png"),
            alignment: Alignment(20, 0)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            ),
            icon: const Icon(Icons.search, color: Colors.black, size: 25),
          ),
          SortVideos(
            mutableVideoList: mutableVideoList,
            onSort: (sortedList) {
              updateVideoList(sortedList);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: mutableVideoList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 100, bottom: 90),
                            child: Column(
                              children: [
                                const Text(
                                  'Videos',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${mutableVideoList.length} Videos',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final currentVideo = mutableVideoList[index];

                      return CustomListTile(
                        leading: SizedBox(
                          height: 70,
                          width: 120,
                          child: FutureBuilder(
                            future: ThumbnailWidget().thumbnailImage(
                              "/${currentVideo.videoPath}",
                            ),
                            builder: (builder, snapshot) => snapshot.hasData
                                ? snapshot.data!
                                : const CircularProgressIndicator(),
                          ),
                        ),
                        title: Text(
                          currentVideo.videoName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subTitle: Text(
                          currentVideo.videoSize,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          RcentFunctions.addTorecent(currentVideo);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerPage(
                                source: currentVideo.videoPath,
                              ),
                            ),
                          );
                        },
                        trailing: PopupMenuButtonVideo(
                          videoDetails: currentVideo,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: mutableVideoList.length,
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
