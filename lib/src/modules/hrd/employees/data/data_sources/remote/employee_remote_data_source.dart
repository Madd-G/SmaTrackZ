import 'package:smatrackz/core.dart';

abstract class EmployeeRemoteDataSource {
  const EmployeeRemoteDataSource();

  Future<void> addEmployee({
    required String email,
    required EmployeeModel employee,
    required String password,
    required String companyId,
  });

  Future<void> updateEmployee({
    required UpdateEmployeeAction action,
    required String uid,
    dynamic employeeData,
  });

  Future<List<EmployeeEntity>> getEmployees();
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
    required EmployeeModel employee,
    required String password,
  }) async {
    try {
      final employeeCredential =
          await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await employeeCredential.user?.updateDisplayName(employee.username);
      await employeeCredential.user?.updatePhotoURL(kDefaultAvatar);
      await _setEmployeeData(
          _authClient.currentUser!, email, companyId, employee);
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
    required String uid,
    dynamic employeeData,
  }) async {
    try {
      switch (action) {
        case UpdateEmployeeAction.email:
          await _authClient.currentUser?.updateEmail(employeeData as String);
          await _updateEmployeeData({'email': employeeData}, uid);
        case UpdateEmployeeAction.username:
          await _authClient.currentUser
              ?.updateDisplayName(employeeData as String);
          await _updateEmployeeData({'username': employeeData}, uid);
        case UpdateEmployeeAction.profilePicture:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');

          await ref.putFile(employeeData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateEmployeeData({'profile_picture': url}, uid);
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
          await _updateEmployeeData({'bio': employeeData as String}, uid);
        case UpdateEmployeeAction.address:
          await _updateEmployeeData({'address': employeeData as String}, uid);
        case UpdateEmployeeAction.phoneNumber:
          await _updateEmployeeData(
              {'phone_number': employeeData as String}, uid);
        case UpdateEmployeeAction.workStart:
          await _updateEmployeeData(
              {'work_start': employeeData as String}, uid);
        case UpdateEmployeeAction.workEnd:
          await _updateEmployeeData({'work_end': employeeData as String}, uid);
        case UpdateEmployeeAction.role:
          await _updateEmployeeData({'role': employeeData as String}, uid);
        case UpdateEmployeeAction.uid:
          await _updateEmployeeData({'uid': employeeData as String}, uid);
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

  Future<void> _setEmployeeData(
      // TODO: ganti User karena User itu Company bukan current user data
      User user,
      String fallbackEmail,
      String companyId,
      EmployeeModel employee) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          EmployeeModel(
            // uid: user.uid,
            // email: user.email ?? fallbackEmail,
            // username: employee.username ?? '',
            // profilePicture: user.photoURL ?? '',
            // workStart: employee.workStart ?? '',
            // workEnd: employee.workEnd ?? '',
            // bio: employee.bio ?? '',
            // role: employee.role ?? '',
            // companyId: companyId ?? '',
            // createdAt: employee.createdAt ?? '',
            uid: user.uid,
            email: employee.email,
            username: employee.username,
            profilePicture: user.photoURL ?? '',
            workStart: '',
            workEnd: '',
            bio: '',
            role: employee.role ?? '',
            companyId: companyId,
            createdAt: employee.createdAt ?? '',
            groups: employee.groups ?? [],
          ).toMap(),
        );
  }

  Future<void> _updateEmployeeData(DataMap data, String uid) async {
    await _cloudStoreClient.collection('users').doc(uid).update(data);
  }

  @override
  Future<List<EmployeeEntity>> getEmployees() {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _cloudStoreClient.collection('users').get().then(
            (value) => value.docs
                .map((doc) => EmployeeModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      debugPrint('object ServerException');
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
