import 'package:smatrackz/core.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({super.key});

  static const routeName = '/office';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? companyName;
    String? address;
    double? latitude;
    double? longitude;
    Map<String, dynamic>? currentData;
    doSave() async {
      bool isValid = formKey.currentState!.validate();
      if (!isValid) {
        showInfoDialog("Please fill required fields");
        return;
      }

      await CompanyService().update(
        companyName: companyName ?? currentData?["company_name"],
        address: address ?? currentData?["address"],
        latitude: latitude ?? currentData?["latitude"],
        longitude: longitude ?? currentData?["longitude"],
      );

      Get.back();
    }

    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: CompanyService().companySnapshot(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text("Error");
                      if (snapshot.data == null) return Container();

                      Map<String, dynamic> currentData = {};
                      if (snapshot.data!.docs.isNotEmpty) {
                        currentData = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;
                        currentData = currentData;
                      }
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            QTextField(
                              label: "Company name",
                              validator: Validator.required,
                              value: currentData["company_name"],
                              onChanged: (value) {
                                companyName = value;
                              },
                            ),
                            QMemoField(
                              label: "Address",
                              validator: Validator.required,
                              value: currentData["address"],
                              onChanged: (value) {
                                address = value;
                              },
                            ),
                            QLocationPicker(
                              id: "location",
                              label: "Location",
                              latitude: currentData["latitude"],
                              longitude: currentData["longitude"],
                              onChanged: (latitude, longitude) {
                                latitude = latitude;
                                longitude = longitude;
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionButton(
        icon: Icons.save,
        label: "Save",
        onPressed: () {
          print('companyName: $companyName');
          print('address: $address');
          print('latitude: $latitude');
          print('longitude: $longitude');
          doSave();
        },
      ),
    );
  }
}
