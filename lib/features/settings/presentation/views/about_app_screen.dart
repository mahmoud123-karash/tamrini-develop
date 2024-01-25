import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/about_app_text_children.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/app_logo_and_name_widget.dart';

import '../../../../generated/l10n.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).about_app),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text.rich(
                  TextSpan(
                    style: TextStyles.style17.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    children: Intl.getCurrentLocale() == 'en'
                        ? childrenEn
                        : childrenAr,
                  ),
                ),
              ),
              const Spacer(),
              const ApplogoAndNameWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
