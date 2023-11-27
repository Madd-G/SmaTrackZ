import 'package:smatrackz/core.dart';

abstract class OfficeRemoteDataSource {
  const OfficeRemoteDataSource();

  // Stream<DocumentSnapshot<Map<String, dynamic>>> getOfficeSnapshot(String officeName) {
  //   return FirebaseFirestore.instance
  //       .doc('office/$officeName')
  //       .snapshots();
  // }

  Future<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
  });
}

class OfficeRemoteDataSourceImpl implements OfficeRemoteDataSource {
  final FirebaseFirestore _cloudStoreClient;

  const OfficeRemoteDataSourceImpl({
    required FirebaseFirestore cloudStoreClient,
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
}
