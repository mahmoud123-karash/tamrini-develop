import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/profile/data/repo/profile_repo_impl.dart';

import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_gender_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/image_cubit/image_cubit.dart';
import 'edit_profile_image_stack_widget.dart';

class EditProfileContentWidget extends StatelessWidget {
  const EditProfileContentWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.ageController,
    required this.autovalidateMode,
    required this.image,
    required this.gender,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final AutovalidateMode autovalidateMode;
  final String image;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => ImageCubit(
                getIt.get<ProfileRepoImpl>(),
              ),
              child: EditProfileImageStackWidget(image: image),
            ),
            const SizedBox(
              height: 30,
            ),
            NameTextWidget(text: S.of(context).name),
            ProfileTextFiledWidget(
              autovalidateMode: autovalidateMode,
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            NameTextWidget(text: S.of(context).phone),
            ProfileTextFiledWidget(
              autovalidateMode: autovalidateMode,
              controller: phoneController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            NameTextWidget(text: S.of(context).age),
            ProfileTextFiledWidget(
              autovalidateMode: autovalidateMode,
              controller: ageController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            NameTextWidget(
              text: S.of(context).gender,
            ),
            ProfileGenderWidget(gender: gender),
          ],
        ),
      ),
    );
  }
}
