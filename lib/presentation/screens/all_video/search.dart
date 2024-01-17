import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/widgets/build_search_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<VideoDetails>> _allVideos;
  List<VideoDetails> _filteredVideos = [];

  @override
  void initState() {
    super.initState();
    _allVideos = ListAllVideos().getAllVideos();
    _filterVideos('');
  }

  void _filterVideos(String searchText) {
    _allVideos.then((videos) {
      setState(() {
        _filteredVideos = videos
            .where((video) => video.videoName
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 25),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text('Search',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              onChanged: _filterVideos,
              decoration: const InputDecoration(
                hintText: 'Search videos...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: BuildSearchList(
              allVideos: _allVideos,
              filteredVideos: _filteredVideos,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
