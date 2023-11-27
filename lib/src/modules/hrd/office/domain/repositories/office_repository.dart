import 'package:smatrackz/core.dart';

abstract class OfficeRepository {
  const OfficeRepository();

  ResultFuture<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  });

  ResultFuture<OfficeModel> getOffice({required dynamic officeData});
}
