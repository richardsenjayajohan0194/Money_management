import 'package:money_management/app/model/transaction_model.dart';

class WallateModel {
  final Map<String, List<TransactionModel>>? transaction;

  WallateModel({this.transaction});

  Map<String, dynamic> toMap() {
    return {
      'transaction': transaction,
    };
  }

  factory WallateModel.fromMap(Map<String, dynamic> map) {
    Map<String, List<TransactionModel>> transactionMap = {};
    map['transaction'].forEach((key, value) {
      List<TransactionModel> transactions =
          value.map((transaction) => TransactionModel.fromMap(transaction)).toList();
      transactionMap[key] = transactions;
    });

    return WallateModel(
      transaction: transactionMap,
    );
  }
}
