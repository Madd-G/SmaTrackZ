import 'package:smatrackz/core.dart';

class EditOfficeScreen extends StatelessWidget {
  const EditOfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-office';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? companyName;
    String? address;

    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 24.0,
              ),
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CompanyLoadedState) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          const Text('Anonymous Company',
                              style: CustomTextStyle.headingSemiBold),
                          const SizedBox(height: 25.0),
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
                    return Center(child: Text("Error: ${state.errorMessage}"));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoadedState) {
            return BottomAppBar(
              child: ElevatedButton(
                onPressed: () {
                  context.read<CompanyBloc>().add(
                        UpdateCompanyEvent(
                          companyName:
                              companyName ?? state.companyData["company_name"],
                          address: address ?? state.companyData["address"],
                          latitude: state.companyData["latitude"] ?? 0.0,
                          longitude: state.companyData["longitude"] ?? 0.0,
                        ),
                      );
                },
                child: const Text('Save'),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
