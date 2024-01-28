import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/views/pending_articles_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class PendingArticlesCustomButtonWidget extends StatelessWidget {
  const PendingArticlesCustomButtonWidget(
      {super.key, required this.length, required this.isWriter});
  final int length;
  final bool isWriter;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      color: appColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onPressed: () {
        navigateTo(context, PendingArticlesScreen(isWriter: isWriter));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.alarm_off_sharp,
            color: whiteColor,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          AutoSizeText(
            "${S.of(context).penging_articles} : ${formatNumber(length)}",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: length > 100 ? 10 : 13,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
