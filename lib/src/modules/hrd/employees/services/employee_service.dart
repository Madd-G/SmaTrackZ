import 'package:smatrackz/core.dart';

class EmployeeService {
  Stream<QuerySnapshot<Object?>>? employeeSnapshot() {
    return FirebaseFirestore.instance.collection("employees").snapshots();
  }

  add({
    required String fullName,
    required String email,
    required String position,
  }) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("employees")
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      throw Exception("This user already exists!");
    }

    await FirebaseFirestore.instance.collection("employees").add({
      "uid": const Uuid().v4(),
      "fullName": fullName,
      "email": email,
      "position": position,
    });
  }

  Future<bool> isNotRegistered(String email) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("employees")
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return true;
    }
    return false;
  }
}
