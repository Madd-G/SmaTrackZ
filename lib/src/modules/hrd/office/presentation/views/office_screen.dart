import 'package:smatrackz/core.dart';

// office_screen.dart
class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? companyName;
    String? address;
    double? latitude;
    double? longitude;

    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state is CompanyLoadedState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    right: 16.0,
                    bottom: 24.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: BlocBuilder<CompanyBloc, CompanyState>(
                      builder: (context, state) {
                        if (state is CompanyLoadedState) {
                          return Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Company name",
                                  ),
                                  initialValue:
                                      state.companyData["company_name"],
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
                                  id: 'location',
                                  latitude: state.companyData["latitude"],
                                  longitude: state.companyData["longitude"],
                                  onChanged: (latitude, longitude) {
                                    latitude = latitude;
                                    longitude = longitude;
                                  },
                                )
                              ],
                            ),
                          );
                        } else if (state is CompanyErrorState) {
                          return Center(
                              child: Text("Error: ${state.errorMessage}"));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
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
        } else if (state is CompanyInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
