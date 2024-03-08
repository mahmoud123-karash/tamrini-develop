import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/delete_account_dialog.dart';
import 'package:tamrini/generated/l10n.dart';

class CustomEditProfileButtonWidget extends StatelessWidget {
  const CustomEditProfileButtonWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: customButton(
                onPressed: onPressed, lable: S.of(context).update_profile),
          ),
          const SizedBox(
            width: 5,
          ),
          if (userType == UserType.user)
            Expanded(
              child: customButton(
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const DeleteAccountDialogWidget(),
                    );
                  },
                  lable: S.of(context).delete_account),
            ),
        ],
      ),
    );
  }
}
