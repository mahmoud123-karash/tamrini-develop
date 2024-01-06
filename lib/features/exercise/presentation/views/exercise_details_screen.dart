import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/presentation/manager/swiper_cubit/swiper_cubit.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_assets_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.model, required this.vedio})
      : super(key: key);
  final DataModel model;
  final String vedio;

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
    CacheHelper.removeData(key: 'index');
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
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.model.title ?? '',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: Intl.getCurrentLocale() == 'en'
                            ? TextAlign.end
                            : TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.model.assets != null ||
                        widget.model.assets!.isNotEmpty)
                      BlocProvider(
                        create: (context) => SwiperCubit(),
                        child: ExerciseAssetsViewWidget(
                          images: widget.model.assets!,
                          player: player,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          """${(widget.model.description)}""",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
