import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/food/presentation/views/supplement_category_screen.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/add_supplement_widget.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/trainee_supplement_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TraineeSupplementContentWidget extends StatefulWidget {
  const TraineeSupplementContentWidget({
    super.key,
    this.model,
    required this.supplements,
    required this.logo,
    required this.themeColor,
  });
  final TraineeModel? model;
  final List<String>? supplements;
  final String logo;
  final Color themeColor;

  @override
  State<TraineeSupplementContentWidget> createState() =>
      _TraineeSupplementContentWidgetState();
}

class _TraineeSupplementContentWidgetState
    extends State<TraineeSupplementContentWidget> {
  ScrollController scrollController = ScrollController();

  int length = 5;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if ((widget.supplements ?? widget.model!.supplements).length > length) {
        length += 10;
        Future.delayed(const Duration(seconds: 1)).then(
          (value) {
            if (mounted) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            }
          },
        );
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';

    return ListView(
      controller: scrollController,
      children: [
        if (userType == UserType.trainer)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: addCustomButton(
              color: widget.themeColor,
              fontSize: 15,
              onPressed: () {
                navigateTo(
                    context, const SupplementsCategoryScreen(isCourse: true));
              },
              lable: S.of(context).add_new_supplement,
            ),
          ),
        if (userType != UserType.trainer)
          const SizedBox(
            height: 15,
          ),
        if (userType != UserType.trainer)
          if (widget.logo != '')
            Center(
              child: CirclarImageWidget(image: widget.logo, radius: 50),
            ),
        const SizedBox(
          height: 15,
        ),
        if (widget.model != null) AddSupplementWidget(model: widget.model!),
        SupplementListViewWidget(
          model: widget.model,
          supplements: widget.supplements ?? [],
          length: length,
        ),
      ],
    );
  }
}
