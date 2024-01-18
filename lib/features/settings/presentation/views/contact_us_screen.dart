import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/app_logo_and_name_widget.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/contact_us_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).contactUs),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "${S.of(context).contact_us_hint}  ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const ContactusRowWidget(),
              const Spacer(),
              const ApplogoAndNameWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
