import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/widgets/category_content_widget.dart';

class CategoryContentBuilderWidget extends StatelessWidget {
  const CategoryContentBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreStates>(
      builder: (context, state) {
        List<ProductModel> list = StoreCubit.get(context).displayedList;
        return list.isEmpty
            ? Center(
                child: Text(
                  S.of(context).nocProducts,
                ),
              )
            : CategoryContentWidget(list: list);
      },
    );
  }
}
