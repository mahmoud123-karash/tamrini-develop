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
      _controller = VideoPlayerController.network(url);

      _controller!.initialize().then((value) {
        setState(() {
          cachedForUrl(url);

          // _controller!.play();
        });
      });
    } else {
      final file = fileInfo.file;
      _controller = VideoPlayerController.file(file);
      _controller!.initialize().then((value) {
        setState(() {
          // _controller!.play();
        });
      });
    }
  }

//: check for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

//:cached Url Data

  @override
  void initState() {
    initializePlayer(widget.remote_url);
    // DefaultCacheManager()
    //     .getSingleFile(widget.remote_url, key: widget.remote_url)
    //     .then((value) {
    //   file = value;
    // });
    //
    // final url = widget.remote_url;
    // final file = await DefaultCacheManager().getSingleFile(url, key: url);
    // controller = VideoPlayerController.file(file)
    //   ..initialize().then(
    //     (_) => initialize(),
    //   );
    // controller = VideoPlayerController.network(
    //   widget.remote_url,
    //   videoPlayerOptions: VideoPlayerOptions(
    //       mixWithOthers: false, allowBackgroundPlayback: false),
    // );

    // init();
    super.initState();
  }

  // init() async {
  //   controller = VideoPlayerController.file(file!);
  //
  //   await controller!.initialize();
  //   // createChewieController();
  // }

  // createChewieController() {
  //   ChewieController(
  //     videoPlayerController: controller,
  //     showControlsOnInitialize: false,
  //     aspectRatio: 16 / 9,
  //     autoPlay: false,
  //     looping: false,
  //     autoInitialize: true,
  //   );
  // }

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
        ? const Center(child: Text('جاري التحميل'))
        : ((_controller!.value.isInitialized)
            ?
            //       ? VideoPlayer(_controller!)
            //
            Chewie(
                controller: ChewieController(
                  placeholder: const Center(child: CircularProgressIndicator()),
                  videoPlayerController: _controller!,
                  showControlsOnInitialize: false,
                  // aspectRatio: 16 / 9,
                  autoPlay: false,
                  looping: false,
                  autoInitialize: false,
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    return video();
  }
}

// class dd extends ChangeNotifier {
//   late String remote_url;
//   late VideoPlayerController controller;
//   ChewieController? chewieController;
//
//   VideoManager(url) {
//     remote_url = url;
//     controller = VideoPlayerController.network(
//       remote_url,
//       videoPlayerOptions: VideoPlayerOptions(
//           mixWithOthers: false, allowBackgroundPlayback: false),
//     );
//
//     init();
//   }
//
//   void disposee() {
//     controller.dispose();
//     if (chewieController != null) {
//       chewieController!.dispose();
//     }
//     notifyListeners();
//
//     super.dispose();
//   }
//   // Widget thumbnail() {
//   //   return CachedNetworkImage(
//   //
//   //   );
//   // }
// }

void cachedForUrl(String url) async {
  await DefaultCacheManager().getSingleFile(url).then((value) {
    print('downloaded successfully done for $url');
  });
}
