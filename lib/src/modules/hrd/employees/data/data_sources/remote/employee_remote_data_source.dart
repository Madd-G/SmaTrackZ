import 'package:smatrackz/core.dart';

abstract class EmployeeRemoteDataSource {
  const EmployeeRemoteDataSource();

  Future<void> addEmployee({
    required String email,
    required String companyName,
    required String password,
    required String companyId,
  });

  Future<void> updateEmployee({
    required UpdateEmployeeAction action,
    dynamic employeeData,
  });
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  const EmployeeRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> addEmployee({
    required String email,
    required String companyId,
    required String companyName,
    required String password,
  }) async {
    try {
      final employeeCredential = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await employeeCredential.user?.updateDisplayName(companyName);
      await employeeCredential.user?.updatePhotoURL(kDefaultAvatar);
      await _setEmployeeData(_authClient.currentUser!, email, companyId, companyName);
    } on FirebaseAuthException catch (e) {
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

  @override
  Future<void> updateEmployee({
    required UpdateEmployeeAction action,
    dynamic employeeData,
  }) async {
    try {
      switch (action) {
        case UpdateEmployeeAction.email:
          await _authClient.currentUser?.updateEmail(employeeData as String);
          await _updateEmployeeData({'email': employeeData});
        case UpdateEmployeeAction.companyName:
          await _authClient.currentUser?.updateDisplayName(employeeData as String);
          await _updateEmployeeData({'company_name': employeeData});
        case UpdateEmployeeAction.profilePicture:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');

          await ref.putFile(employeeData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateEmployeeData({'profile_picture': url});
        case UpdateEmployeeAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(employeeData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _authClient.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
        case UpdateEmployeeAction.bio:
          await _updateEmployeeData({'bio': employeeData as String});
        case UpdateEmployeeAction.address:
          await _updateEmployeeData({'address': employeeData as String});
        case UpdateEmployeeAction.phoneNumber:
          await _updateEmployeeData({'phone_number': employeeData as String});
        case UpdateEmployeeAction.workStart:
          await _updateEmployeeData({'work_start': employeeData as String});
        case UpdateEmployeeAction.workEnd:
          await _updateEmployeeData({'work_end': employeeData as String});
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

  // Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
  //   return _cloudStoreClient.collection('users').doc(uid).get();
  // }

  Future<void> _setEmployeeData(User user, String fallbackEmail, String companyId, String companyName) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          EmployeeModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            companyId: companyId ?? '',
            companyName: companyName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateEmployeeData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
