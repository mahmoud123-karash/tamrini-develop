import 'package:flutter/material.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar("عن التطبيق"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "تطبيق تمريني هو تطبيق شامل للرياضيين بشكل عام ولرياضة كمال الاجسام بشكل خاص\n بحيث انه مزود بكل اقسام التي يحتاجها الرياضي: \n-المقالات -حاسبه البروتينات -حاسبة القيم الغذائيه -متجر للمكملات العذائيه -اقسام للتمارين وكيفيه ادائها وغيرها من الاقسام المفيد\nاذا كنت تبحث عن تطبيق يكون رفيق تمرينك ويساعدك بكل شي يخص التمرين فأنت بالمكان الصحيح تطبيق تمريني هوه الحل لك",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/icon/icon.png",
                        width: 100,
                        height: 100,
                      ),
                      const Text("جميع الحقوق محفوظة"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Tamrini"),
                          const Text(" © "),
                          Text(DateTime.now().year.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
