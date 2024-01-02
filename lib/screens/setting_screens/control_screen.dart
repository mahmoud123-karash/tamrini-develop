import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/screens/setting_screens/banner_screen.dart';
import 'package:tamrini/screens/setting_screens/orders_screens.dart';
import 'package:tamrini/screens/setting_screens/payment_methods_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class AdminControlScreen extends StatefulWidget {
  const AdminControlScreen({Key? key}) : super(key: key);

  @override
  State<AdminControlScreen> createState() => _AdminControlScreenState();
}

class _AdminControlScreenState extends State<AdminControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar('صفحة التحكم'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: kSecondaryColor,
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .fetchAndSetPaymentMethods();
                  To(const PaymentMethodsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 8.0),
                      //   child: Icon(Icons.add_circle, color: Colors.white),
                      // ),
                      Text(
                        "وسائل الدفع",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: kSecondaryColor,
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .getAllOrdersForAdmin();
                  To(const OrdersScreens());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 8.0),
                      //   child: Icon(Icons.add_circle, color: Colors.white),
                      // ),
                      Text(
                        "طلبات الشراء",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: kSecondaryColor,
                onPressed: () {
                  To(const BannerScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 8.0),
                      //   child: Icon(Icons.add_circle, color: Colors.white),
                      // ),
                      Text(
                        "البانر",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
