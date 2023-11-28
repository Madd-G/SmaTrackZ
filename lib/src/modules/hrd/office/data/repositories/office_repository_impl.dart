import 'package:smatrackz/core.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeRemoteDataSource _remoteDataSource;

  OfficeRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  }) async {
    try {
      await _remoteDataSource.addOffice(
          officeId: officeId,
          officeName: officeName,
          address: address,
          latitude: latitude,
          longitude: longitude,
          website: website);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<OfficeModel> getOffice({
    required dynamic officeData,
  }) async {
    try {
      final office = await _remoteDataSource.getOffice();
      return Right(office);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<void> updateOffice({
    required UpdateOfficeAction action,
    required dynamic officeData,
  }) async {
    try {
      await _remoteDataSource.updateOffice(
          action: action, officeData: officeData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
