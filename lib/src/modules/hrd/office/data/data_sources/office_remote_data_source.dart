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
    required String workingTime,
    required String phoneNumber,
  });

  Future<OfficeModel> getOffice(String id);

  Future<void> updateOffice({
    required UpdateOfficeAction action,
    dynamic officeData,
  });
}

class OfficeRemoteDataSourceImpl implements OfficeRemoteDataSource {
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseAuth _auth;

  const OfficeRemoteDataSourceImpl({
    required FirebaseFirestore cloudStoreClient,
    required FirebaseAuth auth,
  })  : _cloudStoreClient = cloudStoreClient,
        _auth = auth;

  @override
  Future<void> addOffice({
    required String officeId,
    required String officeName,
    required String address,
    required double latitude,
    required double longitude,
    required String website,
    required String workingTime,
    required String phoneNumber,
  }) async {
    await _cloudStoreClient.collection('office').doc(officeId).set(
          OfficeModel(
            officeId: officeId,
            officeName: officeName,
            address: address,
            latitude: latitude,
            longitude: longitude,
            website: website,
            workingTime: workingTime,
            phoneNumber: phoneNumber,
          ).toMap(),
        );
  }

  // @override
  // Future<OfficeModel> getOffice() async {
  //   final result =
  //       await _cloudStoreClient.collection('office').doc('abc').get();
  //   return OfficeModel.fromMap(result.data()!);
  // }

  @override
  Future<OfficeModel> getOffice(String id) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final result = await _cloudStoreClient.collection('office').doc(id).get();
      return OfficeModel.fromMap(result.data()!);
      // return _cloudStoreClient.collection('office').get(id).then(
      //       (value) => value.docs
      //           .map((doc) => OfficeModel.fromMap(doc.data()))
      //           .toList(),
      //     );
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
        case UpdateOfficeAction.workingTime:
          await _updateOfficeData({'working_time': officeData as double});
        case UpdateOfficeAction.phoneNumber:
          await _updateOfficeData({'phone_number': officeData as double});
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
    await _cloudStoreClient
        .collection('office')
        .doc(data['office_id'])
        .update(data);
  }
}
