import 'package:smatrackz/core.dart';

class OfficeRemoteDataSource {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getOfficeSnapshot() {
    return FirebaseFirestore.instance
        .doc('office/main-company')
        .snapshots();
  }
}
