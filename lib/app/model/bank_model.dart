class BankModel {
  String? id;
  String? bank;
  String? type;

  BankModel({this.id, this.bank, this.type});

  // receiving data from server
  factory BankModel.fromMap(Map<String, dynamic> map, String? id) {
    return BankModel(
        id: id,
        bank: map['bank'],
        type: map['type']);
  }

  get name => null;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'bank': bank,
      'type': type
    };
  }

  void clear() {
    bank = null;
    type = null;
    print("data $bank");
  }
}
