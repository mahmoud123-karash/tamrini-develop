import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_list_view_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_message_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainersContentWidget extends StatefulWidget {
  const TrainersContentWidget({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<TrainerModel> list;

  @override
  State<TrainersContentWidget> createState() => _TrainersContentWidget();
}

class _TrainersContentWidget extends State<TrainersContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<TrainerModel> searchList = [];

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
      children: [
        searchField(
          controller: searchController,
          onChanged: (value) {
            searchList = searchTariner(value, widget.list);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        widget.list.isNotEmpty
            ? Expanded(
                child: TrainerListViewWidget(
                  controller: scrollController,
                  list: searchController.text == '' ? widget.list : searchList,
                  length: length,
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    S.of(context).emptyList,
                  ),
                ),
              ),
        if (searchList.isEmpty && searchController.text != '')
          Expanded(
            child: TrainerMessageWidget(message: S.of(context).no_trainers),
          ),
      ],
    );
  }
}
