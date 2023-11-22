import 'package:permission_handler/permission_handler.dart';
import 'package:smatrackz/core.dart';

class LocationPicker extends StatefulWidget {
  final String id;
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
    if (widget.latitude == null || widget.longitude == null) {
      getLocation();
    } else {
      latitude = widget.latitude;
      longitude = widget.longitude;
      loading = false;
    }
  }

  getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    loading = false;
    setState(() {});
  }

  bool isLocationPicked() {
    if (latitude != null && longitude != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;
    Set<Circle> circles = {
      Circle(
        circleId: const CircleId('map'),
        center: LatLng(latitude!, longitude!),
        radius: 10,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red.withOpacity(0.1),
      )
    };
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
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude!, longitude!),
                        zoom: 20.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {},
                      circles: circles,
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
                              "$latitude",
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
                              "$longitude",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
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

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                      position: LatLng(
                                          widget.latitude!, widget.longitude!)),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                        if (isLocationPicked())
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    position: LatLng(
                                        widget.latitude!, widget.longitude!),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: AppColors.whiteColor,
                                      size: 20.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Change',
                                      style: CustomTextStyle.textBigSemiBold
                                          .copyWith(
                                              color: AppColors.whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // SizedBox(
                        //   height: 30,
                        //   width: context.width * 0.45,
                        //   child: ElevatedButton.icon(
                        //     icon: const Icon(
                        //       Icons.location_on,
                        //       color: Colors.white,
                        //     ),
                        //     label: Text(
                        //       widget.enableEdit ? "Change" : "View",
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.black,
                        //     ),
                        //     onPressed: () async {
                        //       await Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => MapScreen(
                        //             position: LatLng(
                        //                 widget.latitude!, widget.longitude!),
                        //           ),
                        //         ),
                        //       );
                        //
                        //       loading = true;
                        //       setState(() {});
                        //
                        //       await Future.delayed(
                        //           const Duration(milliseconds: 200));
                        //
                        //       loading = false;
                        //       setState(() {});
                        //     },
                        //   ),
                        // ),
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
