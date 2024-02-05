import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'widgets/home_exercise_body_widget.dart';

class HomeExerciseDetailsWithYoutubScreen extends StatefulWidget {
  const HomeExerciseDetailsWithYoutubScreen({
    Key? key,
    required this.vedio,
    required this.id,
    this.isAll = false,
  }) : super(key: key);
  final String vedio, id;
  final bool isAll;

  @override
  State<HomeExerciseDetailsWithYoutubScreen> createState() =>
      _HomeExerciseDetailsWithYoutubScreenState();
}

class _HomeExerciseDetailsWithYoutubScreenState
    extends State<HomeExerciseDetailsWithYoutubScreen> {
  late YoutubePlayerController controller;
  late String videoId;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;
  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.vedio)!;
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (isPlayerReady && mounted && !controller.value.isFullScreen) {
      setState(() {
        playerState = controller.value.playerState;
        videoMetaData = controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      },
      player: YoutubePlayer(
        controller: controller,
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(),
          title: Text(
            S.of(context).exDetails,
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: HomeExerciseBodyWidget(
          id: widget.id,
          isAll: widget.isAll,
          player: player,
        ),
      ),
    );
  }
}
