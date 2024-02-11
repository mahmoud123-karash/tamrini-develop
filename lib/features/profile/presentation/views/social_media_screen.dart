import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
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
  TextEditingController whatsAppController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    facbookController.dispose();
    instgramController.dispose();
    twiterController.dispose();
    whatsAppController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    facbookController.text = widget.model.facebookUri;
    instgramController.text = widget.model.instgramUri;
    twiterController.text = widget.model.twiterUri;
    whatsAppController.text = widget.model.whatsApp ?? '';

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
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              whatsAppController: whatsAppController,
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    String code = CacheHelper.getData(key: 'code') ?? '+964';
                    ProfileCubit.get(context).updateProfile(
                      name: widget.model.name,
                      email: widget.model.email,
                      gender: widget.model.gender,
                      age: widget.model.age,
                      phone: widget.model.phone,
                      trainerId: widget.model.trainerId ?? '',
                      image: widget.model.image,
                      whatsApp: whatsAppController.text.contains('+')
                          ? whatsAppController.text
                          : "$code${whatsAppController.text}",
                      isBanned: widget.model.isBanned,
                      facebookUri: facbookController.text,
                      instgramUri: instgramController.text,
                      twiterUri: twiterController.text,
                      address: widget.model.address,
                      path: '',
                    );
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
