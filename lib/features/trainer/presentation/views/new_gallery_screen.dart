import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/add_gallery_custom_buider_widget.dart';
import 'widgets/new_gallery_content_widget.dart';

class NewGalleryScreen extends StatefulWidget {
  const NewGalleryScreen({super.key, required this.trainer});
  final TrainerModel trainer;

  @override
  State<NewGalleryScreen> createState() => _NewGalleryScreenState();
}

class _NewGalleryScreenState extends State<NewGalleryScreen> {
  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).add_new_gallery),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: NewGalleryContentWidget(),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: AddGalleryCustomBuilderWidget(trainer: widget.trainer),
              ),
            ),
          )
        ],
      ),
    );
  }
}
