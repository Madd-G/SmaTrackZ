import 'package:smatrackz/core.dart';

abstract class CompanyRemoteDataSource {
  const CompanyRemoteDataSource();

  Future<void> addCompany({
    required String companyId,
    required String companyName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
    required String workStart,
    required String workEnd,
    required String phoneNumber,
  });

  Future<CompanyModel> getCompany(String id);

  Future<void> updateCompany({
    required UpdateCompanyAction action,
    dynamic companyData,
  });
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseAuth _auth;

  const CompanyRemoteDataSourceImpl({
    required FirebaseFirestore cloudStoreClient,
    required FirebaseAuth auth,
  })  : _cloudStoreClient = cloudStoreClient,
        _auth = auth;

  @override
  Future<void> addCompany({
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
    await _cloudStoreClient.collection('company').doc(companyId).set(
          CompanyModel(
            companyId: companyId,
            companyName: companyName,
            address: address,
            latitude: latitude,
            longitude: longitude,
            website: website,
            workStart: workStart,
            workEnd: workEnd,
            phoneNumber: phoneNumber,
          ).toMap(),
        );
  }

  @override
  Future<CompanyModel> getCompany(String id) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final result =
          await _cloudStoreClient.collection('company').doc(id).get();
      return CompanyModel.fromMap(result.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateCompany({
    required UpdateCompanyAction action,
    dynamic companyData,
  }) async {
    try {
      switch (action) {
        case UpdateCompanyAction.name:
          await _updateCompanyData({'company_name': companyData as String});
        case UpdateCompanyAction.address:
          await _updateCompanyData({'address': companyData as String});
        case UpdateCompanyAction.website:
          await _updateCompanyData({'website': companyData as String});
        case UpdateCompanyAction.latitude:
          await _updateCompanyData({'latitude': companyData as double});
        case UpdateCompanyAction.longitude:
          await _updateCompanyData({'longitude': companyData as double});
        case UpdateCompanyAction.workStart:
          await _updateCompanyData({'work_start': companyData as double});
        case UpdateCompanyAction.workEnd:
          await _updateCompanyData({'work_end': companyData as double});
        case UpdateCompanyAction.phoneNumber:
          await _updateCompanyData({'phone_number': companyData as double});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<void> _updateCompanyData(DataMap data) async {
    await _cloudStoreClient
        .collection('company')
        .doc(_auth.currentUser?.uid)
        .update(data);
  }
}
