import 'package:flutter/material.dart';

class PopupMenuButtonPlaylist extends StatelessWidget {
  const PopupMenuButtonPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Create playlist",
                  style: TextStyle(color: Colors.black)),
            ),
          ),
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Delete playlist",
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ];
      },
    );
  }
}
