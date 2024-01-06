import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/services/sort_gyms.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/drop_menu_sort_gyms_widget.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/gym_item_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/search_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key, required this.models});
  final List<GymModel> models;

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
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
  int sLength = 10;

  late List<GymModel> sortedList;

  @override
  void initState() {
    sortedList = widget.models;
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  @override
  void didChangeDependencies() {
    selectedSortBy = S.of(context).minDistance;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).slatGym),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SearchTextFieldWidget(
              controller: searchController,
              onChanged: (value) {
                searchList = searchGym(value, sortedList);
                setState(() {});
              },
            ),
            DropMenuSortGymsWidget(
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
                ? ListView.separated(
                    itemCount: searchController.text != ''
                        ? searchList.length < sLength
                            ? searchList.length
                            : sLength + 1
                        : sortedList.length < length
                            ? sortedList.length
                            : length + 1,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < length) {
                        return GymItemWidget(
                          width: getWidht,
                          model: searchController.text != ''
                              ? searchList[index]
                              : sortedList[index],
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      S.of(context).emptyList,
                    ),
                  ),
            if (searchList.isEmpty && searchController.text != '')
              Text(
                S.of(context).noGyms,
                style: TextStyles.style20,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  void sortGyms(value) {
    if (value == sortBy(context)[0]) {
      sortedList = sortByPrice(true, sortedList);
    }
    if (value == sortBy(context)[1]) {
      sortedList = sortByPrice(false, sortedList);
    }
    if (value == sortBy(context)[2]) {
      sortedList = sortByDistance(true, sortedList);
    }
    if (value == sortBy(context)[3]) {
      sortedList = sortByDistance(false, sortedList);
    }
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (sortedList.length > length) {
        length += 10;
        setState(() {});
      }
      if (searchList.length > sLength) {
        sLength += 10;
        setState(() {});
      }
      if (searchController.text == '') {
        sLength = 10;
        setState(() {});
      }
    }
  }
}
