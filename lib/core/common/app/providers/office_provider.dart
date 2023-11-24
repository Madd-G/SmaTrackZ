import 'package:smatrackz/core.dart';

class OfficeProvider extends ChangeNotifier {
  OfficeModel? _office;

  OfficeModel? get office => _office;

  void initOffice(OfficeModel? office) {
    if (_office != office) _office = office;
  }

  set office(OfficeModel? office) {
    if (_office != office) {
      _office = office;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}