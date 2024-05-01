class TransactionModel {
  String? desc;
  int? ballance;
  int? min;
  int? plus;
  String? image;

  TransactionModel({this.desc, this.ballance, this.min, this.plus, this.image});

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'ballance': ballance,
      'min': min,
      'plus': plus,
      'image': image,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      desc: map['desc'],
      ballance: map['ballance'],
      min: map['min'],
      plus: map['plus'],
      image: map['image'],
    );
  }
}
