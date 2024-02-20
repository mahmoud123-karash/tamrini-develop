import 'package:dartz/dartz.dart';
import 'package:tamrini/core/utils/zain_cash.dart';
import 'package:tamrini/features/payment/data/models/payment_model.dart';

import '../repo/payment_repo.dart';

abstract class UserCase {
  Future<Either<String, String?>> create({
    required num amount,
    required String orderId,
  });

  Future<Either<String, PaymentModel>> listenOnStream({
    required String id,
  });
}

class CreateTranscationIdUseCase extends UserCase {
  final PaymentRepo paymentRepo;

  CreateTranscationIdUseCase(this.paymentRepo);
  @override
  Future<Either<String, String?>> create({
    required num amount,
    required String orderId,
  }) async {
    try {
      Map<String, dynamic> data = {
        'amount': amount.toInt(),
        'serviceType': "service_type",
        'msisdn': ZainCash.msisdn,
        'orderId': orderId,
        'redirectUrl': ZainCash.redirectUrl,
        'iat': DateTime.now().millisecondsSinceEpoch,
        'exp': DateTime.now().millisecondsSinceEpoch + 60 * 60 * 4 * 1000
      };
      String token = paymentRepo.createToken(
        data: data,
      );
      String? transactionId = await paymentRepo.createId(token: token);
      return right(transactionId);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, PaymentModel>> listenOnStream({
    required String id,
  }) async {
    try {
      Map<String, dynamic> data = {
        'id': id,
        'msisdn': ZainCash.msisdn,
        'iat': DateTime.now().millisecondsSinceEpoch,
        'exp': DateTime.now().millisecondsSinceEpoch + 60 * 60 * 4 * 1000
      };
      String token = paymentRepo.createToken(data: data);
      PaymentModel? model =
          await paymentRepo.listenOnStream(id: id, token: token);
      if (model == null) {
        return left('');
      } else {
        return right(model);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
