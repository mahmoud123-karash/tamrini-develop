import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tamrini/core/utils/improts.dart';

class NutritionValueLableWidget extends StatelessWidget {
  const NutritionValueLableWidget(
      {super.key,
      required this.lable,
      required this.value,
      this.iscalory = false,
      this.color});
  final String lable;
  final double value;
  final bool? iscalory;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double percent = value / 100;
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            lable,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
        ),
        if (color != null)
          LinearPercentIndicator(
            width: 40.0,
            animation: true,
            animationDuration: 900,
            lineHeight: 10.0,
            percent: percent > 1.0 ? 1.0 : percent,
            backgroundColor: Colors.grey,
            progressColor: color,
          ),
        const Spacer(),
        Text(
          "${value.toPrecision(3)} ${iscalory! ? S.of(context).calory : S.of(context).g}",
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
