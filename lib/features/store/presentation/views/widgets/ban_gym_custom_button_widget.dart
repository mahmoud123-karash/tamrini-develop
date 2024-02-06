import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class BanStoreCustomButtonWidget extends StatefulWidget {
  const BanStoreCustomButtonWidget({
    super.key,
    required this.name,
    required this.uid,
    required this.isBanned,
  });
  final String name, uid;
  final bool isBanned;

  @override
  State<BanStoreCustomButtonWidget> createState() =>
      _BanStoreCustomButtonWidgetState();
}

class _BanStoreCustomButtonWidgetState
    extends State<BanStoreCustomButtonWidget> {
  late bool banned;
  @override
  void initState() {
    banned = widget.isBanned;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          AwesomeDialog(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            showCloseIcon: true,
            titleTextStyle: TextStyles.style17.copyWith(
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: widget.name,
            desc: banned == true
                ? S.of(context).no_ban_store_question
                : S.of(context).ban_store_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              StoreCubit.get(context).banStore(
                uid: widget.uid,
                message: banned == true
                    ? S.of(context).no_ban_scucess
                    : S.of(context).success_ban,
              );
              banned = !banned;
              setState(() {});
            },
          ).show();
        },
        child: Text(
          banned == true ? S.of(context).no_ban : S.of(context).ban,
          style: TextStyles.style14.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
