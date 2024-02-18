import 'package:dartz/dartz.dart';

import '../repo/payment_repo.dart';

abstract class UserCase {
  Future<Either<String, String?>> create({
    required num amount,
    required String orderId,
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
      String token = paymentRepo.createToken(amount: amount, orderId: orderId);
      String? transactionId = await paymentRepo.createId(token: token);
      return right(transactionId);
    } catch (e) {
      return left(e.toString());
    }
  }
}
