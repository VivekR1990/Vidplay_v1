import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/database/db_functions.dart';
import 'package:video_vid_play/widgets/create_playlist_dialog.dart';

class PopupMenuButtonVideo extends StatefulWidget {
  final VideoDetails videoDetails;

  const PopupMenuButtonVideo({
    Key? key,
    required this.videoDetails,
  }) : super(key: key);

  @override
  State<PopupMenuButtonVideo> createState() => _PopupMenuButtonVideoState();
}

class _PopupMenuButtonVideoState extends State<PopupMenuButtonVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      surfaceTintColor: Colors.white,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 25,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: TextButton(
              onPressed: () async {
                FavoriteFunctions.addToFavorites(widget.videoDetails);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Favorite",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => CreatePlaylistDialog(
                          videoDetails: widget.videoDetails,
                        ));
              },
              child: const Text(
                "Add to Playlist",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ];
      },
    );
  }
}

