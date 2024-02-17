import 'package:flutter/material.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/features/banner/presentation/views/widgets/banner_icon_widget.dart';

class BannerListViewWidget extends StatelessWidget {
  const BannerListViewWidget({super.key, required this.list});
  final List<BannerModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return BannerIconWidget(model: list[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
      itemCount: list.length,
    );
  }
}
