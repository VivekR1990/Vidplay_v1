import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';
import 'package:video_vid_play/widgets/video_menu.dart';

class BuildSearchList extends StatefulWidget {
  const BuildSearchList({
    super.key,
    required Future<List<VideoDetails>> allVideos,
    required List<VideoDetails> filteredVideos,
  })  : _allVideos = allVideos,
        _filteredVideos = filteredVideos;

  final Future<List<VideoDetails>> _allVideos;
  final List<VideoDetails> _filteredVideos;

  @override
  State<BuildSearchList> createState() => _BuildVideoListState();
}

class _BuildVideoListState extends State<BuildSearchList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoDetails>>(
      future: widget._allVideos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && widget._filteredVideos.isEmpty) {
          return const Center(child: Text('No matching videos'));
        } else if (snapshot.hasData) {
          return ListView.separated(
              itemCount: widget._filteredVideos.length,
              itemBuilder: (context, index) {
                VideoDetails currentVideo = widget._filteredVideos[index];
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(
                        source: currentVideo.videoPath,
                      ),
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
                  subtitle: Text(
                    currentVideo.videoSize,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
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
                  trailing: PopupMenuButtonVideo(
                    videoDetails: currentVideo,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider());
        } else {
          return const Center(child: Text('No videos available'));
        }
      },
    );
  }
}
