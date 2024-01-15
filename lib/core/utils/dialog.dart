import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/generated/l10n.dart';

AwesomeDialog logOutDialog(context) => AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: S.of(context).log_out,
      desc: S.of(context).log_out_question,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        logOut(context);
      },
    );
