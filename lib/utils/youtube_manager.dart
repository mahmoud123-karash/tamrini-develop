import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeManager extends StatefulWidget {
  final String youtubeUrl;

  const YoutubeManager({required this.youtubeUrl, Key? key}) : super(key: key);

  @override
  State<YoutubeManager> createState() => _YoutubeManagerState();
}

class _YoutubeManagerState extends State<YoutubeManager> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.youtubeUrl,
      )!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        forceHD: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        disableDragSeek: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
      ),
      builder: (context, player) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          player,
        ],
      ),
    );

    // return YoutubePlayerBuilder(
    //   onExitFullScreen: () {
    //     // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
    //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    //   },
    //   player: YoutubePlayer(
    //     controller: _controller,
    //     showVideoProgressIndicator: true,
    //     progressIndicatorColor: Colors.blueAccent,
    //     onReady: () {
    //       print('----- player is ready ------');
    //       _isPlayerReady = true;
    //     },
    //     onEnded: (data) {},
    //   ),
    //   builder: (context, player) => Column(
    //     children: [
    //       player,
    //     ],
    //   ),
    // );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
