import 'package:smatrackz/core.dart';

class GetOffice {
  final OfficeRepository _repository;

  GetOffice(this._repository);

  Stream<DocumentSnapshot<Map<String, dynamic>>> call(String uid) {
    return _repository.getOfficeSnapshot();
  }
}
