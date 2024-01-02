import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/trainer.dart';
import 'package:tamrini/model/user.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/utils/widgets/Upload%20Image.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class TrainerRequestScreen extends StatefulWidget {
  final User user;
  const TrainerRequestScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TrainerRequestScreen> createState() => _TrainerRequestScreenState();
}

class _TrainerRequestScreenState extends State<TrainerRequestScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contact1Controller = TextEditingController();
  final contact2Controller = TextEditingController();
  final contact3Controller = TextEditingController();
  final priceController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<TextFieldModel> _list;
  int? _selectedItem;
  late int _nextItem;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    allPhotos.clear();

    contact1Controller.dispose();
    contact2Controller.dispose();
    contact3Controller.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _list = ListModel<TextFieldModel>(
      listKey: _listKey,
      initialItems: <TextFieldModel>[
        TextFieldModel(controller: TextEditingController())
      ],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = _list.length;
  }

  Widget _buildRemovedItem(
      TextFieldModel item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index = _selectedItem ?? _list.length;
    _list.insert(index, TextFieldModel(controller: TextEditingController()));
  }

  // Remove the selected item from the list model.
  void remove(int index) {
    _list.removeAt(index);

    setState(() {
      _selectedItem = null;
    });
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          remove(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: globalAppBar("طلب اشتراك كمدرب"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'بياناتك',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 50,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'انجازاتك',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'السعر في الشهر (د.ع)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ImageUploads(
                        isOneImage: true,
                        isVideo: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'بيانات التواصل',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: contact1Controller,
                        decoration: const InputDecoration(
                          labelText: 'فيسبوك',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: contact2Controller,
                        decoration: const InputDecoration(
                          labelText: 'تويتر',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: contact3Controller,
                        decoration: const InputDecoration(
                          labelText: 'انستجرام',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'الأسئلة المطلوبه من المشترك',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedList(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: _list.length,
                          key: _listKey,
                          itemBuilder: (context, index, animation) {
                            return _buildItem(context, index, animation);
                          }),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            _insert();
                          },
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'إضافة سؤال',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            showLoaderDialog(context);

                            if (descriptionController.text.isNotEmpty &&
                                priceController.text.isNotEmpty &&
                                allPhotos.isNotEmpty &&
                                _list.length > 0) {
                              var images = await Provider.of<UploadProvider>(
                                      context,
                                      listen: false)
                                  .uploadFiles();
                              var questions = _list._items
                                  .map((e) => e.controller.text)
                                  .where((element) => element.isNotEmpty)
                                  .toList();

                              Trainer trainer = Trainer(
                                name: widget.user.name,
                                price: int.parse(priceController.text),
                                image: images[0],
                                description: descriptionController.text,
                                gender: widget.user.gender,
                                contacts: [
                                  widget.user.phone,
                                  contact1Controller.text,
                                  contact2Controller.text,
                                  contact3Controller.text,
                                ],
                                questions: questions,
                              );

                              Provider.of<TrainerProvider>(
                                      navigationKey.currentContext!,
                                      listen: false)
                                  .subscribeAsTrainer(trainer);

                              // pop();
                            } else {
                              pop();

                              Fluttertoast.showToast(
                                  msg: 'من فضلك ادخل البيانات كاملة');
                            }
                          } on Exception catch (e) {
                            pop();
                            Fluttertoast.showToast(msg: "حدث خطأ");
                          }
                        },
                        child: const Text('ارسال'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.onTap,
    this.selected = false,
    required this.animation,
    required this.item,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final TextFieldModel item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        child: SizedBox(
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextFormField(
                  controller: item.controller,
                  decoration: const InputDecoration(
                    labelText: 'السؤال',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Ionicons.remove,
                      color: Colors.red,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldModel {
  TextFieldModel({
    required this.controller,
  });

  final TextEditingController controller;
}
