import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_vid_play/funtions/thumbanail_functions.dart';

class ThumbnailWidget {
  Future<Widget> thumbnailImage(String currentPath) async {
    String thumPath = (await getApplicationDocumentsDirectory()).path;
    final String videoName = currentPath.split("/").last;
    final String thumbnailPath =
        '$thumPath/${videoName.substring(0, videoName.lastIndexOf('.'))}.jpg';

    return await File(thumbnailPath).exists()
        ? Image.file(
            File(thumbnailPath),
            fit: BoxFit.cover,
          )
        : FutureBuilder(
            future: ThumbanailFunctions().generateVideoThumbnail(currentPath),
            builder: (context, snapshot) =>
                snapshot.hasData && snapshot.data != null
                    ? Image.file(File(thumbnailPath))
                    : const Center(child: CircularProgressIndicator()));
  }
}
