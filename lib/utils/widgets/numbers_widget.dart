import 'package:flutter/material.dart';
import 'package:tamrini/model/trainer.dart';

class NumbersWidget extends StatelessWidget {
  final Trainer trainer;
  const NumbersWidget({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, trainer.price.toString() + "د.ع", 'السعر'),
          buildDivider(),
          buildButton(context, (trainer.traineesCount ?? 0).toString(), 'المشتركين'),
          // buildDivider(),
          // buildButton(context, '50', 'Followers'),
        ],
      );
  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Theme.of(context).textTheme.bodyLarge!.color)  ,

            ),
            const SizedBox(height: 2),
            Text(
              text,
              style:  TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ],
        ),
      );
}
