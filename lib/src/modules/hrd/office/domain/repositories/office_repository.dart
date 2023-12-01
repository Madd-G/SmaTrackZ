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
    required String workingTime,
    required String phoneNumber,
  });

  ResultFuture<OfficeModel> getOffice(String id);

  ResultFuture<void> updateOffice({
    required UpdateOfficeAction action,
    required dynamic officeData,
  });
}
