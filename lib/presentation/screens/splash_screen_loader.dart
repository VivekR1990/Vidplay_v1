import 'package:flutter/material.dart';
import 'package:video_vid_play/database/db_functions.dart';
import 'package:video_vid_play/presentation/bottom_tab_bar.dart';

class SplashScreenLoader extends StatefulWidget {
  const SplashScreenLoader({Key? key}) : super(key: key);

  @override
  State<SplashScreenLoader> createState() => _SplashScreenLoaderState();
}

class _SplashScreenLoaderState extends State<SplashScreenLoader> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadVideosAndNavigate();
    FavoriteFunctions();
  }

  Future<void> loadVideosAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    if (!_isLoading) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomTabBar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Text(
            'VidPlay',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
