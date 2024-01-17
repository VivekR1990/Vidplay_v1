import 'package:flutter/material.dart';
import 'package:video_vid_play/model/video_model.dart';
import 'package:video_vid_play/database/db_functions.dart';
import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/custom_tile.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteVideos();
  }

  Future<void> _loadFavoriteVideos() async {
    await FavoriteFunctions.getFavorites();
  }

  void removeFromFavoritesAndUpdateList(FavoriteData video) async {
    await FavoriteFunctions.removeFromFavorites(video);

    await _loadFavoriteVideos();

    setState(() {});
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
          const Padding(
            padding: EdgeInsets.only(top: 100, bottom: 90),
            child: Text(
              'Favorites',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<FavoriteData>>(
              valueListenable: favoriteVideoNotifier,
              builder: (context, favList, _) {
                if (favList.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 2 - 10,
                    ),
                    child: const Center(
                      child: Text(
                        'Add Video to favorites',
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: favList.length,
                  itemBuilder: (context, index) {
                    final currentVideo = favList[index];
                    return CustomListTile(
                      leading: SizedBox(
                        height: 70,
                        width: 120,
                        child: FutureBuilder<Widget>(
                          future: ThumbnailWidget().thumbnailImage(
                            "/${currentVideo.videoPath}",
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
                      title: Text(
                        currentVideo.videoName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subTitle: Text(
                        currentVideo.videoSize,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                            source: currentVideo.videoPath,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          removeFromFavoritesAndUpdateList(currentVideo);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
