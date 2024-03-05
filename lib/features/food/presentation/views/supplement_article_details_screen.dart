import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/core/widgets/user_builder_widget.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/new_supplement_screen.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_details_content_widget.dart';
import 'package:tamrini/features/store/presentation/views/new_product_screen.dart';
import '../../../store/data/models/store_model/product_model.dart';
import '../../data/models/supplement_model/supplement_data.dart';

class SupplementArticlesDetailsScreen extends StatelessWidget {
  const SupplementArticlesDetailsScreen({
    Key? key,
    required this.id,
    required this.categoryId,
  }) : super(key: key);
  final String id;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Scaffold(
      appBar: myAppBar(S.of(context).supplement_details),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: BlocBuilder<SupplementCubit, SupplementStates>(
            builder: (context, state) {
              SupplementData? model =
                  SupplementCubit.get(context).getSupplementData(id);
              return model == null
                  ? Center(
                      child: Text(
                        S.of(context).supplement_removed,
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: SupplementSetailsContentWidget(model: model),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Divider(),
                                UserBuilderWidget(
                                  uid: model.writerUid,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (userType == UserType.admin)
                                  EditCustomButtomWidget(
                                    categoryId: categoryId,
                                    model: model,
                                  ),
                                if (model.writerUid == uid &&
                                    userType == UserType.trainer)
                                  EditCustomButtomWidget(
                                    categoryId: categoryId,
                                    model: model,
                                  ),
                                if (userType == UserType.storeOwner)
                                  customButton(
                                    onPressed: () {
                                      navigateTo(
                                        context,
                                        NewProductScreen(
                                          model: ProductModel(
                                            contact: '',
                                            ownerUid: uid,
                                            title: model.title,
                                            description: model.description,
                                            id: model.id,
                                            type: '',
                                            image: model.images.first,
                                            price: 0,
                                            oldPrice: 0,
                                            available: true,
                                            bestSeller: false,
                                            rating: [],
                                          ),
                                        ),
                                      );
                                    },
                                    lable: S.of(context).add_to_your_store,
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class EditCustomButtomWidget extends StatelessWidget {
  const EditCustomButtomWidget(
      {super.key, required this.categoryId, required this.model});
  final String categoryId;
  final SupplementData model;

  @override
  Widget build(BuildContext context) {
    return customButton(
      onPressed: () {
        navigateTo(
          context,
          NewSupplementScreen(
            model: model,
            categoryId: categoryId,
          ),
        );
      },
      lable: S.of(context).edit,
    );
  }
}
