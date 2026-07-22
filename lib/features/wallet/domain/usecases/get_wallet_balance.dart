import 'package:mobile_pay_task_1/features/wallet/domain/repositories/wallet_repository.dart';

class GetWalletBalance {
  const GetWalletBalance(this._repository);
  final WalletRepository _repository;

  Future<double> call() => _repository.getBalance();
}
