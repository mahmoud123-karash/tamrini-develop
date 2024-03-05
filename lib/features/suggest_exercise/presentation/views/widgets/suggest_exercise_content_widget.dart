import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/widgets/suggest_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestExerciseContentWidget extends StatelessWidget {
  const SuggestExerciseContentWidget({
    super.key,
    required this.nameController,
    required this.autovalidateMode,
    required this.formKey,
  });
  final TextEditingController nameController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SectionImageWidget(
                  image: '',
                ),
                const SizedBox(
                  height: 25,
                ),
                addTextField(
                  lable: S.of(context).exercise_name,
                  controller: nameController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (ImageCubit.get(context).paths.isEmpty)
                  const SuggestImageWIdget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
