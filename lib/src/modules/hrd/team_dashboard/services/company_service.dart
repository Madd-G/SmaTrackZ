import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyService {
  Stream<QuerySnapshot<Object?>>? companySnapshot() {
    return FirebaseFirestore.instance.collection("company_profile").snapshots();
  }

  update({
    required String companyName,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    await FirebaseFirestore.instance
        .collection("company_profile")
        .doc("main-company")
        .set({
      "company_name": companyName,
      "address": address,
      /// TODO:
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}
