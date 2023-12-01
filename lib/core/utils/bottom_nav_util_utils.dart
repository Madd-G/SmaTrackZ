import 'package:smatrackz/core.dart';

class BottomNavigationUtils {
  const BottomNavigationUtils._();

  static Stream<UserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => UserModel.fromMap(event.data()!));
}
