import 'package:flutter/widgets.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/views/widgets/banned_trainer_list_view_widget.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_message_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class BannedTrainersContentWidget extends StatefulWidget {
  const BannedTrainersContentWidget({super.key, required this.list});
  final List<TrainerModel> list;

  @override
  State<BannedTrainersContentWidget> createState() =>
      _BannedTrainersContentWidgetState();
}

class _BannedTrainersContentWidgetState
    extends State<BannedTrainersContentWidget> {
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
        Expanded(
          child: widget.list.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).emptyList,
                  ),
                )
              : BannedTrainersListViewWidget(
                  list: searchController.text != '' ? searchList : widget.list,
                  length: length,
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
