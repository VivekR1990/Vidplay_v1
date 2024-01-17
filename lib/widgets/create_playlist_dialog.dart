import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:video_vid_play/database/db_playlist_functions.dart';
import 'package:video_vid_play/model/video_playlist.dart';

class CreatePlaylistDialog extends StatefulWidget {
  final VideoDetails videoDetails;
  const CreatePlaylistDialog({super.key, required this.videoDetails});

  @override
  State<CreatePlaylistDialog> createState() => CreatePlaylistDialogState();
}

class CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  final TextEditingController playlistNameController = TextEditingController();
  bool isTextFieldEnabled = true;
  String? selectedPlaylist;
  @override
  void initState() {
    selectedPlaylist = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          const Text('Create Playlist', style: TextStyle(color: Colors.black)),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable:
                  Hive.box<VideoPlaylist>('playlists_data').listenable(),
              builder: (context, Box<VideoPlaylist> box, _) {
                final playlistNames =
                    box.values.map((playlist) => playlist.name).toList();

                return (playlistNames.isEmpty)
                    ? const SizedBox(
                        height: 20,
                      )
                    : Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.white,
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          value: selectedPlaylist,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPlaylist = newValue ?? '';
                              isTextFieldEnabled = newValue?.isEmpty ?? true;
                            });
                          },
                          items: [
                            const DropdownMenuItem<String>(
                              value: '',
                              child: Text(
                                "None",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            if (box.isNotEmpty)
                              ...playlistNames.map<DropdownMenuItem<String>>(
                                  (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value!,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                          ],
                        ),
                      );
              },
            ),
            TextField(
              controller: playlistNameController,
              decoration: const InputDecoration(
                labelText: 'Playlist Name',
              ),
              enabled: isTextFieldEnabled,
            ),
          ]),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Create', style: TextStyle(color: Colors.black)),
          onPressed: () async {
            String playlistName = playlistNameController.text.trim();
            if (playlistName.isNotEmpty) {
              CreatePlayList.createPlaylist(
                playlistName,
              );
              CreatePlayList.addVideoToPlaylist(
                  playlistName, widget.videoDetails.videoPath);
            }
            if (selectedPlaylist!.isNotEmpty) {
              CreatePlayList.addVideoToPlaylist(
                  selectedPlaylist!, widget.videoDetails.videoPath);
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
      surfaceTintColor: Colors.white,
    );
  }
}
