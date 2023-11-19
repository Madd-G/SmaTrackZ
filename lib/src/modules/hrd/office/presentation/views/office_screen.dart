import 'package:smatrackz/core.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? companyName;
    String? address;
    double? latitude;
    double? longitude;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyLoadedState) {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Company name",
                            ),
                            initialValue: state.companyData["company_name"],
                            onChanged: (value) {
                              companyName = value;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Address",
                            ),
                            initialValue: state.companyData["address"],
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                          LocationPicker(
                            id: "location",
                            label: "Location",
                            latitude: state.companyData["latitude"],
                            longitude: state.companyData["longitude"],
                            onChanged: (newLatitude, newLongitude) {
                                latitude = newLatitude;
                                longitude = newLongitude;
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (state is CompanyErrorState) {
                    return Text("Error: ${state.errorMessage}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            context.read<CompanyBloc>().add(
                  UpdateCompanyEvent(
                    companyName: companyName!,
                    address: address!,
                    latitude: latitude ?? 0.0,
                    longitude: longitude ?? 0.0,
                  ),
                );
          },
          child: const Text('Save'),
        ),
      ),
    );
  }
}
