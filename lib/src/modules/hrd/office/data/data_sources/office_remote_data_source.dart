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
    final office = result;
    if (office == null) {
      throw const ServerException(
        message: 'Please try again later',
        statusCode: 'Unknown Error',
      );
    }
    var officeData = await _getOfficeData('abc');

    if (officeData.exists) {
      return OfficeModel.fromMap(officeData.data()!);
    }

    return OfficeModel.fromMap(officeData.data()!);
  }

  Future<DocumentSnapshot<DataMap>> _getOfficeData(String uid) async {
    return _cloudStoreClient.collection('office').doc('abc').get();
  }
}
