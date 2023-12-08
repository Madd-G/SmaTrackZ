// import 'package:smatrackz/core.dart';
//
// class CompanyProvider extends ChangeNotifier {
//   CompanyModel? _company;
//
//   CompanyModel? get company => _company;
//
//   void initCompany(CompanyModel? company) {
//     if (_company != company) _company = company;
//   }
//
//   set company(CompanyModel? company) {
//     if (_company != company) {
//       _company = company;
//       Future.delayed(Duration.zero, notifyListeners);
//     }
//   }
// }