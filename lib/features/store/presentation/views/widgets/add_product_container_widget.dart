import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class AddProductContainerWidget extends StatefulWidget {
  const AddProductContainerWidget({super.key});

  @override
  State<AddProductContainerWidget> createState() =>
      _AddProductContainerWidgetState();
}

class _AddProductContainerWidgetState extends State<AddProductContainerWidget> {
  bool isOpened = true;
  @override
  Widget build(BuildContext context) {
    return !isOpened
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appColor.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 30,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            isOpened = false;
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      S.of(context).add_product_note,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
