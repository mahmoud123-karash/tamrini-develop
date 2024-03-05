import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/custom_image_slide_show.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';
import 'package:tamrini/generated/l10n.dart';

class SuggestedExerciseDetailsScreen extends StatefulWidget {
  const SuggestedExerciseDetailsScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final SuggestModel model;

  @override
  State<SuggestedExerciseDetailsScreen> createState() =>
      _SuggestedExerciseDetailsScreenState();
}

class _SuggestedExerciseDetailsScreenState
    extends State<SuggestedExerciseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> assets = [];
    if (widget.model.image != '') {
      assets.add(widget.model.image);
    }

    var hieght = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        title: Text(
          S.of(context).exDetails,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          height: hieght,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: Intl.getCurrentLocale() == 'en'
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (assets.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CustomImageSlideShow(
                      assets: assets,
                      children: distributeAssets(
                        assets,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
