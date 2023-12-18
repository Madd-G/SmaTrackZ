import 'package:smatrackz/core.dart';

abstract class ChatRemoteDataSource {
  const ChatRemoteDataSource();

  Future<void> sendMessage(Message message);

  // Should go to 'group >> groupDoc >> messages >> orderBy('timestamp')
  Stream<List<MessageModel>> getMessages(String groupId);

  // Should go to 'group'
  Stream<List<GroupModel>> getGroups();

  Future<void> joinGroup({required String groupId, required String userId});

  Future<void> leaveGroup({required String groupId, required String userId});

  Future<UserModel> getUserById(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Stream<List<GroupModel>> getGroups() {
    try {
      DataSourceUtils.authorizeUser(_auth);
      final groupStream =
          _firestore.collection('group').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => GroupModel.fromMap(doc.data()))
            .toList();
      });

      return groupStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        } else {
          throw ServerException(
            message: error.toString(),
            statusCode: '500',
          );
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String groupId) {
    try {
      DataSourceUtils.authorizeUser(_auth);
      final messagesStream = _firestore
          .collection('group')
          .doc(groupId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
      });

      return messagesStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        } else {
          throw ServerException(
            message: error.toString(),
            statusCode: '500',
          );
        }
      });
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw const ServerException(
          message: 'User not found',
          statusCode: '404',
        );
      }
      return UserModel.fromMap(userDoc.data()!);
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
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore.collection('group').doc(groupId).update({
        'members': FieldValue.arrayUnion([userId]),
      });

      await _firestore.collection('users').doc(userId).update({
        'group': FieldValue.arrayUnion([groupId]),
      });
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
  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore.collection('group').doc(groupId).update({
        'members': FieldValue.arrayRemove([userId]),
      });

      await _firestore.collection('users').doc(userId).update({
        'group': FieldValue.arrayRemove([groupId]),
      });
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
  Future<void> sendMessage(Message message) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final messageRef = _firestore
          .collection('group')
          .doc(message.groupId)
          .collection('messages')
          .doc();
      final messageToUpload =
          (message as MessageModel).copyWith(id: messageRef.id);
      await messageRef.set(messageToUpload.toMap());

      await _firestore.collection('group').doc(message.groupId).update({
        'last_message': message.message,
        'last_message_sender_name': _auth.currentUser!.displayName,
        'last_message_timestamp': message.timestamp,
      });
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
}
