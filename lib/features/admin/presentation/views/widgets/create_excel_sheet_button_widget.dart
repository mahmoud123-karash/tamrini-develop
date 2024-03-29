import 'dart:developer';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:tamrini/core/utils/file_storage.dart';
import 'package:tamrini/core/utils/improts.dart';

class CreateExcelSheetButtonWidget extends StatefulWidget {
  const CreateExcelSheetButtonWidget(
      {super.key, required this.list, required this.lable});
  final List<UserModel> list;
  final String lable;

  @override
  State<CreateExcelSheetButtonWidget> createState() =>
      _CreateExcelSheetButtonWidgetState();
}

class _CreateExcelSheetButtonWidgetState
    extends State<CreateExcelSheetButtonWidget> {
  final xcel.Workbook workbook = xcel.Workbook();

  @override
  void dispose() {
    workbook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: addCustomButton(
        icon: Icons.contact_page_outlined,
        onPressed: () {
          try {
            final xcel.Worksheet sheet = workbook.worksheets[0];
            sheet.getRangeByIndex(1, 1).setText("Name");
            sheet.getRangeByIndex(1, 2).setText("Phone");
            sheet.getRangeByIndex(1, 3).setText("Email");
            sheet.getRangeByIndex(1, 4).setText("Gender");
            sheet.getRangeByIndex(1, 5).setText("Role");
            for (var i = 0; i < widget.list.length; i++) {
              final item = widget.list[i];
              sheet.getRangeByIndex(i + 2, 1).setText(item.name);
              sheet.getRangeByIndex(i + 2, 2).setText(item.phone);
              sheet.getRangeByIndex(i + 2, 3).setText(item.email);
              sheet.getRangeByIndex(i + 2, 4).setText(item.gender);
              sheet.getRangeByIndex(i + 2, 5).setText(item.role);
            }
            final List<int> bytes = workbook.saveAsStream();
            FileStorage.writeCounter(bytes, "${widget.lable}.xlsx");
            showSnackBar(context, S.of(context).success_save_excel_sheet);
          } catch (e) {
            log(e.toString());
            showSnackBar(context, e.toString());
          }
        },
        lable: "create excel sheet",
      ),
    );
  }
}
