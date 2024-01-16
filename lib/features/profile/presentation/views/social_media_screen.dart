import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/edit_profile_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/social_medial_content_widget.dart';

class SocilaMediaScreen extends StatefulWidget {
  const SocilaMediaScreen({super.key, required this.model});
  final ProfileModel model;

  @override
  State<SocilaMediaScreen> createState() => _SocilaMediaScreenState();
}

class _SocilaMediaScreenState extends State<SocilaMediaScreen> {
  TextEditingController facbookController = TextEditingController();
  TextEditingController instgramController = TextEditingController();
  TextEditingController twiterController = TextEditingController();

  @override
  void dispose() {
    facbookController.dispose();
    instgramController.dispose();
    twiterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    facbookController.text = widget.model.facebookUri;
    instgramController.text = widget.model.instgramUri;
    twiterController.text = widget.model.twiterUri;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).media),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SocialMediaContentWidget(
              facbookController: facbookController,
              instgramController: instgramController,
              twiterController: twiterController,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: EditProfileCustomButtonBuilderWidget(
                onPressed: () {
                  ProfileCubit.get(context).updateProfile(
                    name: widget.model.name,
                    email: widget.model.email,
                    gender: widget.model.gender,
                    age: widget.model.age,
                    phone: widget.model.phone,
                    image: widget.model.image,
                    isBanned: widget.model.isBanned,
                    facebookUri: widget.model.facebookUri,
                    instgramUri: widget.model.image,
                    twiterUri: widget.model.twiterUri,
                    address: widget.model.address,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
