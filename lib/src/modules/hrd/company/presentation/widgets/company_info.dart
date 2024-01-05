import 'package:smatrackz/core.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key, required this.company});

  final UserModel company;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.red,
      constraints: (size.width > 600)? BoxConstraints(minWidth: 0.0, maxWidth: size.width * 0.25) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CompanyInfoTile(
            icon: Icons.location_on,
            info: company.address,
          ),
          const SizedBox(height: 20.0),
          const CompanyInfoTile(
            icon: Ionicons.earth,
            info: 'website',
          ),
          const SizedBox(height: 20.0),
          const CompanyInfoTile(
            icon: Icons.access_time,
            info: "Office Timing",
          ),
          const SizedBox(height: 20.0),
          const CompanyInfoTile(
            icon: Icons.calendar_month_outlined,
            info: 'Working Days',
          ),
        ],
      ),
    );
  }
}
