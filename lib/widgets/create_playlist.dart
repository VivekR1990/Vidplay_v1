import 'package:flutter/material.dart';

class CreatePlaylistDialog extends StatelessWidget {
  final Function(String) onCreate;

  const CreatePlaylistDialog({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    TextEditingController playlistNameController = TextEditingController();

    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text(
        'Create Playlist',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: playlistNameController,
        decoration: const InputDecoration(
          labelText: 'Playlist Name',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.black,fontSize: 16)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Create', style: TextStyle(color: Colors.black,fontSize: 16)),
          onPressed: () {
            String playlistName = playlistNameController.text.trim();
            if (playlistName.isNotEmpty) {
              onCreate(playlistName);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
