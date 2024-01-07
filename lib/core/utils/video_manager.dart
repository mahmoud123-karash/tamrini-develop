// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoManager extends StatefulWidget {
  final String remote_url;

  const VideoManager({Key? key, required this.remote_url}) : super(key: key);

  @override
  State<VideoManager> createState() => _VideoManagerState();
}

class _VideoManagerState extends State<VideoManager> {
  VideoPlayerController? _controller;
  ChewieController? chewieController;
  File? file;

  @override
  void dispose() {
    _controller!.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  void initializePlayer(String url) async {
    final fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));

      _controller!.initialize().then((value) {
        setState(() {
          cachedForUrl(url);
        });
      });
    } else {
      final file = fileInfo.file;
      _controller = VideoPlayerController.file(file);
      _controller!.initialize().then((value) {
        setState(() {});
      });
    }
  }

  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  @override
  void initState() {
    initializePlayer(widget.remote_url);

    super.initState();
  }

  void play() {
    _controller!.play();
    setState(() {});
  }

  void pause() {
    _controller!.pause();
    setState(() {});
  }

  Widget video() {
    return (_controller == null)
        ? const Center(child: Text('Loading...'))
        : ((_controller!.value.isInitialized)
            ? Chewie(
                controller: ChewieController(
                  placeholder: const Center(child: CircularProgressIndicator()),
                  videoPlayerController: _controller!,
                  showControlsOnInitialize: false,
                  autoPlay: false,
                  looping: false,
                  autoInitialize: false,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return video();
  }
}

void cachedForUrl(String url) async {
  await DefaultCacheManager().getSingleFile(url).then((value) {});
}
