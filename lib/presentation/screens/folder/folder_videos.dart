import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/database/db_recent_played.dart';

import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/custom_tile.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';
import 'package:video_vid_play/widgets/video_menu.dart';

class FolderVideos extends StatefulWidget {
  const FolderVideos({Key? key, required this.videos, required this.folder})
      : super(key: key);
  final String videos;
  final List<VideoDetails> folder;

  @override
  State<FolderVideos> createState() => _FolderVideosState();
}

class _FolderVideosState extends State<FolderVideos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: ListView.separated(
          itemCount: widget.folder.length,
          itemBuilder: (context, index) {
            VideoDetails currentVideo = widget.folder[index];
            return CustomListTile(
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
              title: Text(
                currentVideo.videoName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
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
              subTitle: Text(
                currentVideo.videoSize,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ))
      ]),
      backgroundColor: Colors.white,
    );
  }
}
