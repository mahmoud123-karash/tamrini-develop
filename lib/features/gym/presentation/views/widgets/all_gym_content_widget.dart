import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/services/sort_gyms.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'add_and_sort_gym_widget.dart';
import 'gym_list_view_widge.dart';

class AllGymsContentWidget extends StatefulWidget {
  const AllGymsContentWidget({super.key, required this.models});
  final List<GymModel> models;

  @override
  State<AllGymsContentWidget> createState() => _AllGymsContentWidgetState();
}

class _AllGymsContentWidgetState extends State<AllGymsContentWidget> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<GymModel> searchList = [];

  List sortBy(context) => [
        S.of(context).lowPrice,
        S.of(context).highPrice,
        S.of(context).minDistance,
        S.of(context).maxDistance,
      ];

  late String selectedSortBy;

  int length = 10;

  late List<GymModel> sortedList;

  @override
  void initState() {
    sortedList = widget.models;
    selectedSortBy = Intl.getCurrentLocale() == 'en' ? 'Nearest' : 'الأقرب';
    super.initState();
    scrollController.addListener(_loadMoreData);
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
            searchList = searchGym(value, widget.models);
            if (value == '') {
              length = 10;
            }
            setState(() {});
          },
        ),
        AddAndSortGymWidget(
          items: sortBy(context).map<DropdownMenuItem<String>>(
            (value) {
              return DropdownMenuItem<String>(
                onTap: () {
                  sortGyms(value);
                  setState(() {});
                },
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          selectedSortBy: selectedSortBy,
          onChanged: (String? value) {
            selectedSortBy = value ?? '';
            setState(() {});
          },
        ),
        const SizedBox(
          height: 15,
        ),
        sortedList.isNotEmpty
            ? Expanded(
                child: GymListViewWidget(
                  controller: scrollController,
                  list: searchController.text == '' ? sortedList : searchList,
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
              S.of(context).noGyms,
              style: TextStyles.style20,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  void sortGyms(value) {
    List<GymModel> list = [];
    if (searchController.text != '') {
      list = searchList;
    } else {
      list = sortedList;
    }
    if (value == sortBy(context)[0]) {
      list = sortByPrice(true, list);
    }
    if (value == sortBy(context)[1]) {
      list = sortByPrice(false, list);
    }
    if (value == sortBy(context)[2]) {
      list = sortByDistance(true, list);
    }
    if (value == sortBy(context)[3]) {
      list = sortByDistance(false, list);
    }
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      length += 10;
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          if (mounted) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {}));
          }
        },
      );
    }
  }
}
