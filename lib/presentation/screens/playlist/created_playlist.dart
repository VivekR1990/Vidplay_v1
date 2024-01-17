import 'package:flutter/material.dart';
import 'package:video_vid_play/database/db_playlist_functions.dart';
import 'package:video_vid_play/model/video_playlist.dart';
import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';

class CreatePlayListPage extends StatefulWidget {
  final VideoPlaylist video;
  final int index;
  const CreatePlayListPage({Key? key, required this.video, required this.index})
      : super(key: key);

  @override
  State<CreatePlayListPage> createState() => _CreatePlayListPageState();
}

class _CreatePlayListPageState extends State<CreatePlayListPage> {
  Future<void> _showDeleteDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Delete Video",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          content: const Text(
              "Are you sure you want to delete this video from the playlist?",
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
                setState(() {
                  CreatePlayList.deleteVideoFromPlaylist(
                      widget.video.name, widget.video.videos![index]);
                });
                Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 90),
            child: Text(
              widget.video.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                            source: widget.video.videos![index],
                          ),
                        ),
                      ),
                  leading: SizedBox(
                    height: 70,
                    width: 120,
                    child: FutureBuilder<Widget>(
                      future: ThumbnailWidget().thumbnailImage(
                        "/${widget.video.videos![index]}",
                      ),
                      builder: (builder, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!;
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        _showDeleteDialog(index);
                      },
                      icon: const Icon(Icons.delete,size: 22,)),
                  title: Text(
                    widget.video.videos![index].split('/').last,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              itemCount: widget.video.videos!.length,
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
