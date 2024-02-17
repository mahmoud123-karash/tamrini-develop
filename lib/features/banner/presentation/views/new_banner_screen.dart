import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/add_banner_custom_builder_widget.dart';
import 'widgets/new_banner_content_widget.dart';

class NewBannerScreen extends StatefulWidget {
  const NewBannerScreen({super.key});

  @override
  State<NewBannerScreen> createState() => _NewBannerScreenState();
}

class _NewBannerScreenState extends State<NewBannerScreen> {
  TextEditingController uriController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    uriController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).add_new_banner),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: NewBannerContentWidget(
                uriController: uriController,
                autovalidateMode: autovalidateMode,
                formKey: formKey,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AddBannerCustomBuilderWidget(
                  onPressed: () {
                    List<String> paths = ImageCubit.get(context).paths;
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (paths.isNotEmpty) {
                        BannerCubit.get(context).addBanner(
                          uri: uriController.text,
                          imagePath: paths.first,
                        );
                      } else {
                        showSnackBar(context, S.of(context).image_error);
                      }
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
