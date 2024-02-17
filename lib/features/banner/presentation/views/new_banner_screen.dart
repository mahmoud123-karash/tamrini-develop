import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/generated/l10n.dart';

class NewBannerScreen extends StatefulWidget {
  const NewBannerScreen({super.key, this.model});
  final BannerModel? model;

  @override
  State<NewBannerScreen> createState() => _NewBannerScreenState();
}

class _NewBannerScreenState extends State<NewBannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_banner
            : S.of(context).add_new_banner,
      ),
    );
  }
}
