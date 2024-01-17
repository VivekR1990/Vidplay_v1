import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_vid_play/database/db_playlist_functions.dart';
import 'package:video_vid_play/model/video_playlist.dart';
import 'package:video_vid_play/presentation/screens/playlist/favourite_page.dart';
import 'package:video_vid_play/presentation/screens/playlist/recent_played_page.dart';
import 'package:video_vid_play/widgets/create_playlist.dart';
import 'package:video_vid_play/widgets/playlist_item.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<VideoPlaylist>('playlists_data');
    var data = box.values.toList();
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
          image: AssetImage("asset/images/vidPlay.png"),
          alignment: Alignment(20, 0),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        CreatePlaylistDialog(onCreate: (playlistName) {
                          setState(() {
                            CreatePlayList.createPlaylist(playlistName);
                          });
                        }));
              },
              icon: const Icon(Icons.playlist_add,size: 22,))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100, bottom: 50),
            child: Text(
              'Playlist',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavouritesPage(),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 22,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Favourite Videos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RcentPage(),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Colors.black,
                    size: 22,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Recently Played Videos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Text(
              'Created Playlists',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return PlaylistItemWidget(
                index: index,
                playlist: data[index],
                onPressed: () {
                  setState(() {
                    CreatePlayList.deletePlaylist(data[index].name);
                  });
                },
              );
            },
          ))
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
