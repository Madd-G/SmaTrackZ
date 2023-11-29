import 'package:smatrackz/core.dart';

abstract class OfficeRemoteDataSource {
  const OfficeRemoteDataSource();

  Future<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  });

  Future<OfficeModel> getOffice();

  Future<void> updateOffice({
    required UpdateOfficeAction action,
    dynamic officeData,
  });
}

class OfficeRemoteDataSourceImpl implements OfficeRemoteDataSource {
  final FirebaseFirestore _cloudStoreClient;

  const OfficeRemoteDataSourceImpl({
    required FirebaseFirestore cloudStoreClient,
    required FirebaseAuth auth,
  }) : _cloudStoreClient = cloudStoreClient;

  @override
  Future<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  }) async {
    await _cloudStoreClient.collection('office').doc('abc').set(
          OfficeModel(
            officeId: officeId,
            officeName: officeName,
            address: address,
            latitude: latitude,
            longitude: longitude,
            website: website,
          ).toMap(),
        );
  }

  @override
  Future<OfficeModel> getOffice() async {
    final result =
        await _cloudStoreClient.collection('office').doc('abc').get();
    return OfficeModel.fromMap(result.data()!);
  }

  @override
  Future<void> updateOffice({
    required UpdateOfficeAction action,
    dynamic officeData,
  }) async {
    try {
      switch (action) {
        case UpdateOfficeAction.name:
          await _updateOfficeData({'office_name': officeData as String});
        case UpdateOfficeAction.address:
          await _updateOfficeData({'address': officeData as String});
        case UpdateOfficeAction.website:
          await _updateOfficeData({'website': officeData as String});
        case UpdateOfficeAction.latitude:
          await _updateOfficeData({'latitude': officeData as double});
        case UpdateOfficeAction.longitude:
          await _updateOfficeData({'longitude': officeData as double});
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

  Future<void> _updateOfficeData(DataMap data) async {
    await _cloudStoreClient.collection('office').doc('abc').update(data);
  }
}
