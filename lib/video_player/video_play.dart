// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, unused_import

import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:video_vid_play/funtions/fetch_videos_folders.dart';
import 'package:video_vid_play/widgets/video_menu.dart';

class VideoPlayerPage extends StatefulWidget {
  final String source;

  const VideoPlayerPage({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  late bool isLoading = true;
  
  

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(widget.source);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.source.split('/').last,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Center(
              child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController,
              ),
            ),
    );
  }

  void initializeVideoPlayer(String source) {
    setState(() {
      isLoading = true;
    });
    VideoPlayerController _videoPlayerController;

    _videoPlayerController = VideoPlayerController.network(source)
      ..initialize().then((value) {
        setState(() {
          isLoading = false;
        });
      });

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
    );
  }
}
