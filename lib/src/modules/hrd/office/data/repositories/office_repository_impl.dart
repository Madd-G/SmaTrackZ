import 'package:smatrackz/core.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeRemoteDataSource _remoteDataSource;

  OfficeRepositoryImpl(this._remoteDataSource);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getOfficeSnapshot() {
    return _remoteDataSource.getOfficeSnapshot();
  }
}
