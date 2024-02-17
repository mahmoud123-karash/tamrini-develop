import 'dart:convert';
import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

//>>>>>>>>>>>>>>>>>>>>>>> the info here is test from zain cash <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
const String msisdn = "9647711211318"; // your wallet number
const String secret =
    "\$2y\$10\$pAuCAB9OtkkHGPjff.joz.JjGK88esa77I889HW4OnRueI4yD3x4O"; // the Merchant Secret

const String merchantId = "654b2c939788a73a94a637bf"; // Merchant Id
const String initUrl = 'https://test.zaincash.iq/transaction/init';
const String redirectUrl = "redirection_url";

Map<String, dynamic> data = {
  'amount': 500,
  'serviceType': "service_type",
  'msisdn': msisdn,
  'orderId': "Bill_123455445544545544554554567890",
  'redirectUrl': redirectUrl,
  'iat': DateTime.now().millisecondsSinceEpoch,
  'exp': DateTime.now().millisecondsSinceEpoch + 60 * 60 * 4 * 1000
};

//1- get the data of transaction and convert to token
String createToken() {
  String token = "";

  SecretKey key = SecretKey(secret);
  final jwt = JWT(
    data,
  );
  token = jwt.sign(key);

  return token;
}

// 2- get the token and create the transaction id
Future<String?> transAction(String token, [String language = "ar"]) async {
  final Map<String, dynamic> postData = {
    'token': token,
    'merchantId': merchantId,
    'lang': language,
  };
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  final http.Response response = await http.post(
    Uri.parse(initUrl),
    headers: headers,
    body: jsonEncode(postData),
  );

  if (response.statusCode == 200) {
    final String responseBody = response.body;
    final String operationId = jsonDecode(responseBody)['id'];
    return operationId;
  } else {
    Logger().e('body ${response.body}');
  }
  return null;
}
