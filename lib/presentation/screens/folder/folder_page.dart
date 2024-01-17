import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/funtions/fetch_directories.dart';
import 'package:video_vid_play/funtions/fetch_videos_folders.dart';
import 'package:video_vid_play/presentation/screens/folder/folder_list_tile.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({Key? key}) : super(key: key);

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  late List<List<VideoDetails>> dirs = [];

  @override
  void initState() {
    fetchDir();
    super.initState();
  }

  fetchDir() async {
    List<List<VideoDetails>> data = [];
    for (var element in await DirectoryFetcher.getAllDirectories()) {
      data.add(await getAllVideosAsList(folderPath: element));
    }
    setState(() {
      dirs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Image(
        image: AssetImage("asset/images/vidPlay.png"),
        alignment: Alignment(20, 0),
      )),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, bottom: 90),
                child: Text(
                  'Folders',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final List<VideoDetails> folder = dirs[index];
                    return FolderListTile(folder: folder);
                  },
                  separatorBuilder: (__, _) => const Divider(),
                  itemCount: dirs.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
