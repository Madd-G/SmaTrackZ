import 'package:smatrackz/core.dart';

class CompanyProfilePhoto extends StatelessWidget {
  const CompanyProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      'https://img.freepik.com/free-psd/silver-letters-glass-building-facade_145275-162.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1703376000&semt=ais',
      height: (size.width>1000) ? 160.0 : 200.0,
      width: (size.width>1000) ? 240.0 : size.width * 0.75,
      fit: BoxFit.fill,
    );
  }
}
