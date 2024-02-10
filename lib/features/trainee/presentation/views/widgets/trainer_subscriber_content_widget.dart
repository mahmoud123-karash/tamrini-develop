import 'package:flutter/material.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/sub_model/trainee_model.dart';
import 'package:tamrini/generated/l10n.dart';
import 'subscriber_list_view_widget.dart';

class TrainerSubscriberContentWidget extends StatefulWidget {
  const TrainerSubscriberContentWidget({
    super.key,
    required this.list,
  });
  final List<TraineeModel> list;

  @override
  State<TrainerSubscriberContentWidget> createState() =>
      _TrainerSubscriberContentWidgetState();
}

class _TrainerSubscriberContentWidgetState
    extends State<TrainerSubscriberContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<TraineeModel> searchList = [];

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
            searchList = searchSubscriber(value, widget.list);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        const SizedBox(
          height: 10,
        ),
        widget.list.isNotEmpty
            ? Expanded(
                child: SubscriberListViewWidget(
                  controller: scrollController,
                  list: searchController.text == '' ? widget.list : searchList,
                  length: length,
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    S.of(context).no_results,
                  ),
                ),
              ),
        if (searchList.isEmpty && searchController.text != '')
          Expanded(
            child: Text(
              S.of(context).no_results,
              style: TextStyles.style20,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
