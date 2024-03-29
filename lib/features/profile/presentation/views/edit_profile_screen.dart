import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../../../core/cubit/image_cubit/image_cubit.dart';
import 'widgets/edit_profile_content_widget.dart';
import 'widgets/edit_profile_custom_button_builder_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.model});
  final ProfileModel model;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    CacheHelper.removeData(key: 'gender');
    nameController.text = widget.model.name;
    phoneController.text = widget.model.phone;
    ageController.text = widget.model.age.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).edit_profile),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: EditProfileContentWidget(
              formKey: formKey,
              nameController: nameController,
              phoneController: phoneController,
              ageController: ageController,
              autovalidateMode: autovalidateMode,
              image: widget.model.image,
              gender: widget.model.gender,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<ImageCubit, ImageStates>(
                builder: (context, state) {
                  return EditProfileCustomButtonBuilderWidget(
                    onPressed: () {
                      List<String> paths = ImageCubit.get(context).paths;
                      updateProfile(
                        context,
                        path: paths.isNotEmpty ? paths.first : '',
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateProfile(BuildContext context, {required String path}) {
    String gender = CacheHelper.getData(key: 'gender') ?? widget.model.gender;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (gender == '') {
        showSnackBar(context, S.of(context).genderConfirm);
      } else {
        ProfileCubit.get(context).updateProfile(
          name: nameController.text,
          email: widget.model.email,
          gender: gender,
          age: int.parse(ageController.text),
          phone: phoneController.text,
          image: widget.model.image,
          whatsApp: widget.model.whatsApp ?? '',
          isBanned: widget.model.isBanned,
          facebookUri: widget.model.facebookUri,
          trainerId: widget.model.trainerId ?? '',
          instgramUri: widget.model.instgramUri,
          twiterUri: widget.model.twiterUri,
          address: widget.model.address,
          path: path,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
