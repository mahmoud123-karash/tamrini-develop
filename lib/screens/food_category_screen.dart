import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/nutritious_value_provider.dart';
import 'package:tamrini/provider/supplement_provider.dart';
import 'package:tamrini/screens/ProteinCalc_Screen.dart';
import 'package:tamrini/screens/nutritious_Screen.dart';
import 'package:tamrini/screens/supplement_screens/supplements_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class FoodCategoryScreen extends StatefulWidget {
  const FoodCategoryScreen({Key? key}) : super(key: key);

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/images/protien.jpg"), context);
    precacheImage(const AssetImage("assets/images/nutiritious.jpg"), context);
    precacheImage(const AssetImage("assets/images/whey.jpg"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // searchBar(_searchController, (p0) => null),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<NutritionalValueProvider>(context, listen: false)
                  .initiate();
              To(const NutritiousCalcScreen());
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/nutiritious.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "القيم الغذائية",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              To(const ProteinCalculatorScreen());
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/protien.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "حاسبة البروتينات",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<SupplementProvider>(context, listen: false)
                  .isLoading = true;
              Provider.of<SupplementProvider>(context, listen: false)
                  .fetchAndSetSupplements();

              To(const SupplementsHomeScreen());
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/whey.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "المكملات الغذائية",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
