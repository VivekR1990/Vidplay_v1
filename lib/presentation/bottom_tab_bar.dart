// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:video_vid_play/presentation/Screens/All_video/video_page.dart';
import 'package:video_vid_play/presentation/Screens/Folder/folder_page.dart';
import 'package:video_vid_play/presentation/Screens/Playlist/playlist_page.dart';
import 'package:video_vid_play/presentation/Screens/Settings/settings_page.dart';

class BottomTabBar extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BottomTabBar({Key? key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _index = 0;

  final _pages = const [
    VideoPage(),
    FolderPage(),
    PlayListPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: constant_identifier_names
    const IconData grid_view_outlined =
        IconData(0xf0d7, fontFamily: 'MaterialIcons');
    return Scaffold(
        body: _pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 18.0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedFontSize: 14.0,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_rounded), label: "Videos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder_copy_rounded), label: "Folders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.featured_play_list_rounded),
                label: "Playlist"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_rounded),
                label: "Settings"),
          ],
        ));
  }
}
