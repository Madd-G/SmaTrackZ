import 'package:smatrackz/core.dart';

abstract class OfficeRepository {
  const OfficeRepository();

  // Stream<DocumentSnapshot<Map<String, dynamic>>> getOfficeSnapshot(
  //     String officeId);
  ResultFuture<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  });
}
