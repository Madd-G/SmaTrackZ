import 'package:smatrackz/core.dart';

class EditOfficeScreen extends StatelessWidget {
  const EditOfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-office';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? officeName;
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
              child: BlocBuilder<OfficeBloc, OfficeState>(
                builder: (context, state) {
                  if (state is OfficeInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OfficeLoadedState) {
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
                            initialValue: state.officeData["office_name"],
                            onChanged: (value) {
                              officeName = value;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Address",
                            ),
                            initialValue: state.officeData["address"],
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                          LocationPicker(
                            id: 'location',
                            latitude: state.officeData["latitude"],
                            longitude: state.officeData["longitude"],
                            onChanged: (latitude, longitude) {
                              latitude = latitude;
                              longitude = longitude;
                            },
                          )
                        ],
                      ),
                    );
                  } else if (state is OfficeErrorState) {
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
      bottomNavigationBar: BlocBuilder<OfficeBloc, OfficeState>(
        builder: (context, state) {
          if (state is OfficeLoadedState) {
            return BottomAppBar(
              child: ElevatedButton(
                onPressed: () {
                  context.read<OfficeBloc>().add(
                        UpdateOfficeEvent(
                          officeName:
                              officeName ?? state.officeData["office_name"],
                          address: address ?? state.officeData["address"],
                          latitude: state.officeData["latitude"] ?? 0.0,
                          longitude: state.officeData["longitude"] ?? 0.0,
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
