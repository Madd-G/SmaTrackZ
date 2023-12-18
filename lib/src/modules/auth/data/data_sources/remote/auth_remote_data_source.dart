import 'package:smatrackz/core.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String companyId,
    required String companyName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
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
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
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
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUserData(user.uid);

      // var dummy = {'company_id': '20231128-0546-8952-b316-aae819cea8bc'};
      if (userData.exists) {
        return UserModel.fromMap(userData.data()!);
        // return UserModel.fromMap(dummy);
      }

      // upload the user
      // await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return UserModel.fromMap(userData.data()!);
      // return UserModel.fromMap(dummy);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String companyName,
    required String password,
    required String companyId,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(companyName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      // await _setUserData(_authClient.currentUser!, email, companyId);
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
  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.companyName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'company_name': userData});
        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(userData as String);
          await _updateUserData({'email': userData});
        case UpdateUserAction.profilePicture:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profile_picture': url});
        case UpdateUserAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _authClient.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
        case UpdateUserAction.address:
          await _updateUserData({'address': userData as String});
        case UpdateUserAction.website:
          await _updateUserData({'website': userData as String});
        case UpdateUserAction.phoneNumber:
          await _updateUserData({'phone_number': userData as String});
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
        case UpdateUserAction.latitude:
          await _updateUserData({'latitude': userData as num});
        case UpdateUserAction.longitude:
          await _updateUserData({'longitude': userData as num});
        case UpdateUserAction.workStart:
          await _updateUserData({'work_start': userData as String});
        case UpdateUserAction.workEnd:
          await _updateUserData({'work_end': userData as String});
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

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('company').doc(uid).get();
  }

  /// get data start from here
  // Future<void> _setUserData(User user, String fallbackEmail,
  //     [String? companyId]) async {
  //   print('user.uid: ${user.uid}');
  //   await _cloudStoreClient.collection('company').doc(user.uid).set(
  //         // TODO: add role
  //         UserModel(
  //           companyId: user.uid,
  //           companyName: user.displayName ?? '',
  //           email: user.email ?? fallbackEmail,
  //           address: '',
  //           website: '',
  //           phoneNumber: '',
  //           profilePicture: user.photoURL ?? '',
  //           bio: '',
  //           latitude: 0,
  //           longitude: 0,
  //           workStart: '',
  //           workEnd: '',
  //           created: DateTime.now().toString(),
  //         ).toMap(),
  //       );
  // }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('company')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
