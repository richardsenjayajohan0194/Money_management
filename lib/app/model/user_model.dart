class UserModel {
  String? uid;
  String? email;
  String? username;
  String? password;

  UserModel({this.uid, this.email, this.username, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        username: map['username'],
        password: map['password']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'password': password
    };
  }

  void clear() {
    uid = null;
    email = null;
    username = null;
    password = null;
    print("data $uid");
  }

}
