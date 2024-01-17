import 'package:flutter/material.dart';
import 'package:video_vid_play/model/video_playlist.dart';
import 'package:video_vid_play/presentation/screens/playlist/created_playlist.dart';

class PlaylistItemWidget extends StatefulWidget {
  final int index;
  final void Function() onPressed;
  const PlaylistItemWidget({
    Key? key,
    required this.playlist,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  final VideoPlaylist playlist;

  @override
  State<PlaylistItemWidget> createState() => _PlaylistItemWidgetState();
}

class _PlaylistItemWidgetState extends State<PlaylistItemWidget> {
  Future<void> _showDeleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Delete Playlist",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to delete this playlist?",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                widget.onPressed();
              },
              child: const Text("Delete",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.playlist_play, size: 28),
        title: Text(
          widget.playlist.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePlayListPage(
                  video: widget.playlist,
                  index: widget.index,
                ),
              ));
        },
        trailing: IconButton(
          onPressed: _showDeleteDialog,
          icon: const Icon(Icons.delete,size: 22,),
        ));
  }
}
