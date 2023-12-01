import 'package:smatrackz/core.dart';

class OfficeUtil {
  const OfficeUtil._();

  static Stream<OfficeModel> get officeDataStream => sl<FirebaseFirestore>()
      .collection('office')
      .doc('abc')
      .snapshots()
      .map((event) => OfficeModel.fromMap(event.data()!));
}
