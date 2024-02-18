import 'dart:convert';
import 'dart:developer';

import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:http/http.dart' as http;

class PaymentRepo {
  String createToken({
    required num amount,
    required String orderId,
  }) {
    const String msisdn = "9647835077893";
    const String secret =
        "\$2y\$10\$hBbAZo2GfSSvyqAyV2SaqOfYewgYpfR1O19gIh4SqyGWdmySZYPuS";
    const String redirectUrl = "redirection_url";

    Map<String, dynamic> data = {
      'amount': amount,
      'serviceType': "service_type",
      'msisdn': msisdn,
      'orderId': orderId,
      'redirectUrl': redirectUrl,
      'iat': DateTime.now().millisecondsSinceEpoch,
      'exp': DateTime.now().millisecondsSinceEpoch + 60 * 60 * 4 * 1000
    };
    String token = "";
    SecretKey key = SecretKey(secret);
    final jwt = JWT(
      data,
    );
    token = jwt.sign(key);
    return token;
  }

  Future<String?> createId({
    required String token,
  }) async {
    const String merchantId = "5ffacf6612b5777c6d44266f";
    const String initUrl = 'https://test.zaincash.iq/transaction/init';
    final Map<String, dynamic> postData = {
      'token': token,
      'merchantId': merchantId,
      'lang': 'en',
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final http.Response response = await http.post(
      Uri.parse(initUrl),
      headers: headers,
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      final String responseBody = response.body;
      final String? operationId = jsonDecode(responseBody)['id'];
      log(response.body);
      if (operationId != null) {
        return operationId;
      } else {
        throw Exception('Operation ID is null');
      }
    } else {
      return null;
    }
  }
}
