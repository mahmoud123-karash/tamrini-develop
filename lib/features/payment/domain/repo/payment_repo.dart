import 'dart:convert';
import 'dart:developer';

import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tamrini/core/utils/zain_cash.dart';
import 'package:tamrini/features/payment/data/models/payment_model.dart';

class PaymentRepo {
  String createToken({
    required Map<String, dynamic> data,
  }) {
    String token = "";
    SecretKey key = SecretKey(ZainCash.secret);
    final jwt = JWT(
      data,
    );
    token = jwt.sign(key);
    return token;
  }

  Future<String?> createId({
    required String token,
  }) async {
    final Map<String, dynamic> postData = {
      'token': token,
      'merchantId': ZainCash.merchantId,
      'lang': Intl.getCurrentLocale(),
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final http.Response response = await http.post(
      Uri.parse(ZainCash.initUrl),
      headers: headers,
      body: jsonEncode(postData),
    );

    final String responseBody = response.body;
    log(response.body);
    if (response.statusCode == 200) {
      final String? operationId = jsonDecode(responseBody)['id'];
      if (operationId != null) {
        return operationId;
      } else {
        throw Exception('Operation ID is null');
      }
    } else {
      return null;
    }
  }

  Future<PaymentModel?> listenOnStream({
    required String id,
    required String token,
  }) async {
    final Map<String, dynamic> postData = {
      'token': token,
      'merchantId': ZainCash.merchantId,
      'lang': 'en',
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final http.Response response = await http.post(
      Uri.parse(ZainCash.getUrl),
      headers: headers,
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      final String responseBody = response.body;
      final Map<String, dynamic> result = jsonDecode(responseBody);
      log(result.toString());
      PaymentModel model = PaymentModel.fromJson(result);
      return model;
    } else {
      return null;
    }
  }
}
