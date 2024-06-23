
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/model/transaction_model.dart';
import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/model/wallate_model.dart';
import 'package:money_management/app/routes/app_pages.dart';

class FirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // WallateModel wallateModel = WallateModel();

  void addUser(Map<String, dynamic> userMap) async {
    CollectionReference User = firestore.collection('users');

    DocumentSnapshot userSnapshot = await User.doc(userMap['uid']).get();

    if (!userSnapshot.exists) {
      // Menambahkan dokumen baru dengan UID tersebut ke dalam koleksi "users"
      await User.doc(userMap['uid']).set({"Username": userMap["username"]});
      UserModel userModel = UserModel.fromMap(userMap);
      print("UserModel : $userModel");
      // await User.doc(userMap['uid']).collection('wallates').doc("BCA").set({"Halo" : [userMap]});
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menambahkan user",
          onConfirm: () {
            Get.offAllNamed(Routes.DASHBOARD);
          },
          textConfirm: "OKAY");
    } else {
      UserModel userModel = UserModel.fromMap(userMap);
      print("UserModel : $userModel");
      Get.defaultDialog(
          title: "Gagal",
          middleText: "Gagal menambahkan user",
          onConfirm: () {
            Get.offAllNamed(Routes.DASHBOARD);
          },
          textConfirm: "OKAY");
    }
  }

  void addWallate(String wallates, String name, String desc, String ballance,
      String image) async {
    // Mengambil data uid dari fungsi getUserData()
    Map<String, dynamic>? userData =
        await Get.find<AuthController>().getUserData();
    String uid = userData!['user']['uid'];

    print("uidnya adalah $uid");

    // Menggunakan objek dari kedua class object
    TransactionModel transactionModel = TransactionModel(
      desc: desc,
      ballance: int.parse(ballance),
      min: 0,
      plus: 0,
      image: image,
    );

    WallateModel wallateModel = WallateModel(
      transaction: {
        wallates: [transactionModel],
      },
    );

//     DocumentReference datas = await firestore.collection('users').doc(uid);

// // Get the current data of the document
//     DocumentSnapshot snapshot = await datas.get();
//     bool datass = (snapshot.data() as Map<String, dynamic>)
//         .containsKey('wallates.$wallates');
//     print("Datanya adalah : $datass");

//     if (snapshot.exists &&
//         (snapshot.data() as Map<String, dynamic>)
//             .containsKey('wallates.$wallates')) {
//       // If the key exists, update the value
//       await datas.update({
//         'wallates.$wallates': FieldValue.arrayUnion([wallateModel.toMap()])
//       });
//     } else {
//       // If the key doesn't exist, add the key and value
//       await datas.set({
//         'wallates.$wallates': [wallateModel.toMap()]
//       }, SetOptions(merge: true));
//     }

    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(uid);

    docRef.get().then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        final Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('wallates')) {
          // docSnapshot.docs;
        } else {
          print('The "wallates" field does not exist in the document.');
        }
      } else {
        print('The document does not exist.');
      }
    });
    Get.defaultDialog(
      title: "Berhasil",
      middleText: "Berhasil menambahkan wallate",
      onConfirm: () {
        Get.offAllNamed(Routes.DASHBOARD);
      },
      textConfirm: "OKAY",
    );
  }
}
