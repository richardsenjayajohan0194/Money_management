// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:money_management/app/controllers/auth_controller.dart';
import 'package:money_management/app/model/user_model.dart';
import 'package:money_management/app/routes/app_pages.dart';

import '../model/bank_model.dart';

class FirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var banks = <BankModel>[].obs; // Observable list to store banks

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

  void Bank(String bank, String type) async {
    if (bank.isNotEmpty && type.isNotEmpty) {
      try {
        // Create a new BankModel instance
        BankModel newBank = BankModel(bank: bank, type: type);

        // Add to Firestore
        await firestore.collection('banks').add(newBank.toMap());

        print(
            "Bank: ${newBank.bank}, Type: ${newBank.type} added to Firestore");

        // Optionally, show a success message
        Get.defaultDialog(
          title: "Success",
          middleText: "Bank and Type added successfully.",
          onConfirm: () {
            Get.offAllNamed(Routes.HOME);
          },
          textConfirm: "OK",
        );
      } catch (e) {
        print("Error adding document: $e");

        // Optionally, show an error message
        Get.defaultDialog(
          title: "Error",
          middleText: "An error occurred: $e",
          onConfirm: () {
            Get.back();
          },
          textConfirm: "OK",
        );
      }
    }
  }

  Future<List<BankModel>> getDataBanks() async {
    List<BankModel> bankDataList = []; // List to hold bank data
    try {
      QuerySnapshot snapshot = await firestore.collection('banks').get();

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?; // Use nullable type
        if (data != null &&
            data.containsKey('bank') &&
            data.containsKey('type')) {
          bankDataList.add(BankModel(
            id: doc.id,
            bank: data['bank'] as String? ?? 'Unknown Bank', // Handle null
            type: data['type'] as String? ?? 'Unknown Type', // Handle null
          ));
        }
      }
    } catch (e) {
      print("Error retrieving banks: $e");
    }
    return bankDataList; // Return the list of bank data
  }

  Stream<List<BankModel>> getBanks() {
    return firestore.collection('banks').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              // Check if the document exists
              if (doc.exists) {
                // Get the data safely
                final data = doc.data() as Map<String, dynamic>?;

                if (data != null) {
                  return BankModel.fromMap(data, doc.id);
                } else {
                  print('Document ${doc.id} has no data.');
                  return null; // Handle case where data is null
                }
              } else {
                print('Document ${doc.id} does not exist.');
                return null; // Document does not exist
              }
            } catch (e) {
              print('Error parsing document: ${doc.id}, error: $e');
              return null; // Handle error as needed
            }
          })
          .where((bank) => bank != null)
          .cast<BankModel>()
          .toList();
    });
  }

  void addWallate(String wallates, String name, String desc, String ballance,
      String image) async {
    // Mengambil data uid dari fungsi getUserData()
    UserModel? userData = await Get.find<AuthController>().getUserDataLog();

    //Check if user_id null or not
    String user_id = userData!.uid ?? '';
    print(user_id);

    // print("uidnya adalah userData");

    // // Menggunakan objek dari kedua class object
    // TransactionModel transactionModel = TransactionModel(
    //   desc: desc,
    //   ballance: int.parse(ballance),
    //   min: 0,
    //   plus: 0,
    //   image: image,
    // );

    // WallateModel wallateModel = WallateModel(
    //   transaction: {
    //     wallates: [transactionModel],
    //   },
    // );

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

    // final DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('users').doc(uid);

    // docRef.get().then((DocumentSnapshot docSnapshot) {
    //   if (docSnapshot.exists) {
    //     final Map<String, dynamic> data =
    //         docSnapshot.data() as Map<String, dynamic>;
    //     if (data.containsKey('wallates')) {
    //       // docSnapshot.docs;
    //     } else {
    //       print('The "wallates" field does not exist in the document.');
    //     }
    //   } else {
    //     print('The document does not exist.');
    //   }
    // });
    // Get.defaultDialog(
    //   title: "Berhasil",
    //   middleText: "Berhasil menambahkan wallate",
    //   onConfirm: () {
    //     Get.offAllNamed(Routes.DASHBOARD);
    //   },
    //   textConfirm: "OKAY",
    // );
  }

}
