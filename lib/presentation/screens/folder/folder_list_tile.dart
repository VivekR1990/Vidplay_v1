import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/presentation/screens/folder/folder_videos.dart';

class FolderListTile extends StatelessWidget {
  const FolderListTile({
    Key? key,
    required this.folder,
  }) : super(key: key);

  final List<VideoDetails> folder;

  @override
  Widget build(BuildContext context) {
    String videoPath = folder.isNotEmpty ? folder[0].videoPath : '';

    List<String> splitPath = videoPath.split('/');
    String fourthElement = splitPath.length >= 4 ? splitPath[3] : '';

    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FolderVideos(
            folder: folder,
            videos: '',
          ),
        ));
      },
      horizontalTitleGap: 40,
      leading: const Icon(
        Icons.folder,
        size: 50,
        color: Colors.black,
      ),
      title: Text(fourthElement,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text(
        '${folder.length} Videos',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
