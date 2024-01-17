import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';

class SortVideos extends StatefulWidget {
  final List<VideoDetails> mutableVideoList;
  final Function(List<VideoDetails>) onSort;

  const SortVideos({
    Key? key,
    required this.mutableVideoList,
    required this.onSort,
  }) : super(key: key);

  @override
  SortVideosState createState() => SortVideosState();

  void sortAndNotify() {
    List<VideoDetails> sortedList = mutableVideoList;

    onSort(sortedList);
  }
}

class SortVideosState extends State<SortVideos> {
  late int _sortValue;

  @override
  void initState() {
    super.initState();
    _sortValue = 0;
    widget.mutableVideoList.sort((a, b) => a.videoName.compareTo(b.videoName));
  }

  void sortVideos() {
    setState(() {
      if (_sortValue == 0) {
        widget.mutableVideoList
            .sort((a, b) => a.videoName.compareTo(b.videoName));
      } else if (_sortValue == 1) {
        widget.mutableVideoList
            .sort((a, b) => b.videoName.compareTo(a.videoName));
      }

      widget.onSort(widget.mutableVideoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: _sortValue,
      onSelected: (int value) {
        setState(() {
          _sortValue = value;
          sortVideos();
        });
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Sort Ascending', style: TextStyle(color: Colors.black)),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Sort Descending', style: TextStyle(color: Colors.black)),
        ),
      ],
      icon: const Icon(Icons.sort, color: Colors.black, size: 25),
      color: Colors.white,
    );
  }
}
