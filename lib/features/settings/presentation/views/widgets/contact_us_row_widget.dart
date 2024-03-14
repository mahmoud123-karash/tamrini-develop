import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/contact_us_icon_widget.dart';

class ContactusRowWidget extends StatelessWidget {
  const ContactusRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContactUsIconWidget(
          icon: Ionicons.call_outline,
          color: Colors.blue,
          onPressed: () {
            openUri(
              url: Uri.parse("tel:+9647711211318"),
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        ContactUsIconWidget(
          icon: Ionicons.logo_whatsapp,
          color: Colors.green,
          onPressed: () {
            openUri(
              url: Uri.parse("https://wa.me/+9647711211318"),
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        ContactUsIconWidget(
          icon: Ionicons.logo_facebook,
          color: Colors.blue,
          onPressed: () {
            openUri(
              url: Uri.parse("https://www.facebook.com/tamrini9"),
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        ContactUsIconWidget(
          icon: Ionicons.logo_instagram,
          color: Colors.pink,
          onPressed: () {
            openUri(
              url: Uri.parse("https://www.instagram.com/tamrini9"),
            );
          },
        ),
      ],
    );
  }
}
