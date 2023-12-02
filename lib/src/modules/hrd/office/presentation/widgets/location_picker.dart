import 'package:smatrackz/core.dart';

class LocationPicker extends StatefulWidget {
  final String id;
  final String officeId;
  final String buttonLabel;
  final String? label;
  final String? hint;
  final double? latitude;
  final double? longitude;
  final String? Function(double? latitude, double? longitude)? validator;
  final Function(double latitude, double longitude) onChanged;
  final bool enableEdit;

  const LocationPicker({
    Key? key,
    required this.id,
    required this.officeId,
    required this.buttonLabel,
    this.label,
    this.hint,
    this.latitude,
    this.longitude,
    this.validator,
    required this.onChanged,
    this.enableEdit = true,
  }) : super(key: key);

  @override
  LocationPickerState createState() => LocationPickerState();
}

class LocationPickerState extends State<LocationPicker> {
  double? latitude;
  double? longitude;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (!isLocationPicked()) {
      latitude = 0.0;
      longitude = 0.0;
    } else {
      latitude = widget.latitude;
      longitude = widget.longitude;
      loading = false;
    }
  }

  bool isLocationPicked() {
    if (latitude != 0.0 && longitude != 0.0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;
    return FormField(
      initialValue: false,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(latitude, longitude);
        }
        return null;
      },
      enabled: true,
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            errorText: field.errorText,
            border: InputBorder.none,
            helperText: widget.hint,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : (!isLocationPicked())
                            ? Container(
                                color: AppColors.greyColor.withOpacity(0.7),
                                child: const Center(
                                  child: Text(
                                      'Location information not provided',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: CustomTextStyle.textLargeSemiBold),
                                ),
                              )
                            : GoogleMap(
                                mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(latitude!, longitude!),
                                  zoom: 20.0,
                                ),
                                onMapCreated:
                                    (GoogleMapController controller) {},
                                // circles: circles,
                                myLocationButtonEnabled: false,
                                myLocationEnabled: false,
                                zoomControlsEnabled: false,
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("source"),
                                    icon: locationIcon,
                                    position: LatLng(latitude!, longitude!),
                                    // position: dummy,
                                  ),
                                },
                              ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: SizedBox(
                    height: 128,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Latitude:",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              (!isLocationPicked() || loading)
                                  ? "-"
                                  : latitude.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              "Longitude:",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              (!isLocationPicked() || loading)
                                  ? "-"
                                  : longitude.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        if (loading) const SizedBox(),
                        if (!isLocationPicked())
                          ElevatedButton.icon(
                            icon: const Icon(Icons.location_on),
                            label: const Text("Select"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () async {
                              if (!kIsWeb &&
                                  (Platform.isAndroid || Platform.isIOS)) {
                                if (!await Permission.location
                                    .request()
                                    .isGranted) {
                                  return;
                                }
                                return;
                              }

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => sl<OfficeBloc>(),
                                    child: MapScreen(
                                      officeId: widget.officeId,
                                      latitudeData: latitude!,
                                      longitudeData: longitude!,
                                      // position: LatLng(latitude!, longitude!),
                                    ),
                                  ),
                                ),
                              );

                              loading = true;
                              setState(() {});

                              await Future.delayed(
                                  const Duration(milliseconds: 200));

                              loading = false;
                              setState(() {});
                            },
                          ),
                        if (isLocationPicked())
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => sl<OfficeBloc>(),
                                    child: MapScreen(
                                      officeId: widget.officeId,
                                      latitudeData: latitude!,
                                      longitudeData: longitude!,
                                      // position: LatLng(latitude!, longitude!),
                                    ),
                                  ),
                                ),
                              );

                              loading = true;
                              setState(() {});

                              await Future.delayed(
                                  const Duration(milliseconds: 200));

                              loading = false;
                              setState(() {});
                            },
                            child: RoundedContainer(
                              containerColor: AppColors.blackColor,
                              radius: 10.0,
                              width: context.width * 0.45,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Center(
                                  child: Text(
                                    widget.buttonLabel,
                                    style: CustomTextStyle.textBigSemiBold
                                        .copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
