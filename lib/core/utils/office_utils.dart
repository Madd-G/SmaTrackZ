import 'package:smatrackz/core.dart';

class OfficeUtils {
  const OfficeUtils._();

  static Stream<OfficeModel> get officeDataStream => sl<FirebaseFirestore>()
      .collection('office')
      .doc('abc')
      .snapshots()
      .map((event) => OfficeModel.fromMap(event.data()!));
}
