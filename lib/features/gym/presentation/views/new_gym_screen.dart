import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/new_gym_content_widget.dart';

class NewGymScreen extends StatefulWidget {
  const NewGymScreen({super.key, this.model});
  final GymModel? model;

  @override
  State<NewGymScreen> createState() => _NewGymScreenState();
}

class _NewGymScreenState extends State<NewGymScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    CacheHelper.removeData(key: 'latmap');
    CacheHelper.removeData(key: 'langmap');
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      ImageCubit.get(context).images = widget.model!.assets;
      nameController.text = widget.model!.name;
      priceController.text = widget.model!.price.toString();
      descriptionController.text = widget.model!.description.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null ? S.of(context).edit_gym : S.of(context).add_gym,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewGymContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              priceController: priceController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GymCustombuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  double lat = CacheHelper.getData(key: 'latmap') ?? 0.0;
                  double lang = CacheHelper.getData(key: 'langmap') ?? 0.0;
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      GymCubit.get(context).editGym(
                        paths: paths,
                        name: nameController.text,
                        description: descriptionController.text,
                        price: int.parse(priceController.text),
                        lat: lat == 0 ? widget.model!.location.latitude : lat,
                        long:
                            lang == 0 ? widget.model!.location.longitude : lang,
                        images: ImageCubit.get(context).images,
                        oldModel: widget.model!,
                        context: context,
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        if (lat != 0.0) {
                          GymCubit.get(context).addGym(
                            paths: paths,
                            name: nameController.text,
                            description: descriptionController.text,
                            price: int.parse(priceController.text),
                            lat: lat,
                            long: lang,
                            context: context,
                          );
                        } else {
                          showSnackBar(
                              context, S.of(context).location_gym_hint_error);
                        }
                      } else {
                        showSnackBar(context, S.of(context).image_error);
                      }
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
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
