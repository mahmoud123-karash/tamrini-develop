import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'widgets/exercise_details_body_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.vedio,
    this.isHome = false,
    required this.id,
    this.isAll = false,
  }) : super(key: key);
  final String vedio, id;
  final bool isHome, isAll;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late YoutubePlayerController controller;
  late String videoId;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;
  @override
  void initState() {
    CacheHelper.removeData(key: 'index');
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
        onReady: () {
          isPlayerReady = true;
          setState(() {});
        },
        onEnded: (metaData) {
          controller.pause();
          setState(() {});
        },
        controller: controller,
        aspectRatio: 16 / 7,
        thumbnail: !isPlayerReady
            ? Center(
                child: Text(
                  'Waiting...',
                  style: TextStyles.style15.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox(),
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
        body: ExerciseDetailsBodyWidget(
          id: widget.id,
          isHome: widget.isHome,
          isAll: widget.isAll,
          player: player,
        ),
      ),
    );
  }
}
