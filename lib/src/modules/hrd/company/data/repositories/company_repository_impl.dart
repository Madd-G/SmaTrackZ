import 'package:smatrackz/core.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource _remoteDataSource;

  CompanyRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<void> addCompany({
    required String companyId,
    required String companyName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
    required String workStart,
    required String workEnd,
    required String phoneNumber,
  }) async {
    try {
      await _remoteDataSource.addCompany(
        companyId: companyId,
        companyName: companyName,
        address: address,
        latitude: latitude,
        longitude: longitude,
        website: website,
        workStart: workStart,
        workEnd: workEnd,
        phoneNumber: phoneNumber,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<CompanyModel> getCompany(String id) async {
    try {
      final company = await _remoteDataSource.getCompany(id);
      return Right(company);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<void> updateCompany({
    required UpdateCompanyAction action,
    required dynamic companyData,
  }) async {
    try {
      await _remoteDataSource.updateCompany(
          action: action, companyData: companyData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
