import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZainCashScreen extends StatefulWidget {
  const ZainCashScreen({super.key, required this.trasactionId});
  final String trasactionId;

  @override
  State<ZainCashScreen> createState() => _ZainCashScreenState();
}

class _ZainCashScreenState extends State<ZainCashScreen> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(appColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            'https://test.zaincash.iq/transaction/pay?id=${widget.trasactionId}'),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).zain_cash,
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
