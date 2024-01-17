import 'package:flutter/material.dart';
import 'package:video_vid_play/database/db_recent_played.dart';
import 'package:video_vid_play/model/video_model.dart';
import 'package:video_vid_play/video_player/video_play.dart';
import 'package:video_vid_play/widgets/custom_tile.dart';
import 'package:video_vid_play/widgets/thumbnail_widget.dart';

class RcentPage extends StatefulWidget {
  const RcentPage({Key? key}) : super(key: key);

  @override
  State<RcentPage> createState() => _RcentPageState();
}

class _RcentPageState extends State<RcentPage> {
  @override
  void initState() {
    super.initState();
    _loadRecentVideos();
  }

  Future<void> _loadRecentVideos() async {
    await RcentFunctions.getRecent();
  }

  void removeFromRecentAndUpdateList(FavoriteData video) async {
    await RcentFunctions.removeFromRecent(video);

    await _loadRecentVideos();

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
              'Recent Played ',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<FavoriteData>>(
              valueListenable: rcentVideoNotifier,
              builder: (context, rcentList, _) {
                if (rcentList.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 2 - 10,
                    ),
                    child: const Center(
                      child: Text(
                        'No videos played recently',
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: rcentList.length,
                  itemBuilder: (context, index) {
                    final currentVideo = rcentList[index];
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
                          removeFromRecentAndUpdateList(currentVideo);
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
