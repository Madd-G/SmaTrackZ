import 'package:smatrackz/core.dart';

abstract class OfficeRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getOfficeSnapshot();
}
