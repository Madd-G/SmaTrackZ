import 'package:smatrackz/core.dart';

class UserUtils {
  const UserUtils._();

  static Stream<UserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => UserModel.fromMap(event.data()!));
}
