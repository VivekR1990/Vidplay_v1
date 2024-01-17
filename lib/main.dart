import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:video_vid_play/model/video_model.dart';
import 'package:video_vid_play/model/video_playlist.dart';
import 'package:video_vid_play/presentation/Screens/splash_screen_loader.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteDataAdapter());
  Hive.registerAdapter(VideoPlaylistAdapter());
  await Hive.openBox<VideoPlaylist>('playlists_data');
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'VidPlay',
      debugShowCheckedModeBanner: false,
      home: SplashScreenLoader(),
    );
  }
}
