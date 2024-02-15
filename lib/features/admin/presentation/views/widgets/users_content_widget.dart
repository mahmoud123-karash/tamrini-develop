import 'package:flutter/material.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/views/widgets/users_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'create_excel_sheet_button_widget.dart';

class UsersContentWidget extends StatefulWidget {
  const UsersContentWidget({super.key, required this.list});
  final List<UserModel> list;

  @override
  State<UsersContentWidget> createState() => _UsersContentWidgetState();
}

class _UsersContentWidgetState extends State<UsersContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<UserModel> searchList = [];

  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.list.length > length) {
        length += 10;
        Future.delayed(const Duration(seconds: 1)).then((value) {
          if (mounted) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {}));
          }
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchUser(value, widget.list);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        Expanded(
          child: UsersListViewWidget(
            controller: scrollController,
            list: searchController.text == '' ? widget.list : searchList,
            length: length,
          ),
        ),
        if (searchController.text != '' && searchList.isEmpty)
          Expanded(
            child: Center(
              child: Text(S.of(context).no_results),
            ),
          ),
        if (widget.list.isNotEmpty)
          CreateExcelSheetButtonWidget(list: widget.list),
      ],
    );
  }
}
