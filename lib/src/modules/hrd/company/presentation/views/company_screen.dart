import 'package:smatrackz/core.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  static const routeName = '/company';

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addCompanyFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<EmployeeBloc>().add(GetEmployeeEvent());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CompanyAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: Responsive.isDesktop(context) ? 50.0 : 16.0,
              right: Responsive.isDesktop(context) ? 50.0 : 16.0,
              bottom: Responsive.isDesktop(context) ? 24.0 : 8.0,
            ),
            child: Consumer<UserProvider>(
              builder: (_, provider, __) {
                final company = provider.user!;
                return Column(
                  children: [
                    SizedBox(
                        height: Responsive.isDesktop(context) ? 20.0 : 8.0),
                    CompanySection(
                        company: company,
                        nameController: nameController,
                        emailController: emailController,
                        addCompanyFormKey: addCompanyFormKey),
                    const SizedBox(height: 20.0),
                    EmployeesAndAttendanceSection(company: company),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
