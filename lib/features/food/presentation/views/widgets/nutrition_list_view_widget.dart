import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionlistViewWidget extends StatelessWidget {
  const NutritionlistViewWidget({
    super.key,
    required this.list,
    required this.onSelectedItemChanged,
    required this.scrollController,
  });
  final List<NutritionModel> list;
  final Function(int) onSelectedItemChanged;
  final FixedExtentScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(),
      scrollController: scrollController,
      magnification: 0.98,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 40.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: list.isNotEmpty
          ? List.generate(
              list.length,
              (index) => Center(
                child: GestureDetector(
                  onTapUp: (_) {
                    Navigator.pop(context);
                  },
                  child: AutoSizeText(
                    list[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          : [
              Center(
                child: Text(S.of(context).no_results),
              )
            ],
    );
  }
}
