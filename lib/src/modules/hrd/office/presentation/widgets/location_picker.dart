import 'package:smatrackz/core.dart';

class LocationPicker extends StatefulWidget {
  final String id;
  final String? label;
  final String? hint;
  final String? Function(double? latitude, double? longitude)? validator;
  final Function(double latitude, double longitude) onChanged;
  final bool enableEdit;
  final OfficeModel office;

  const LocationPicker({
    Key? key,
    required this.id,
    this.label,
    this.hint,
    this.validator,
    required this.onChanged,
    this.enableEdit = true,
    required this.office,
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
      latitude = widget.office.latitude;
      longitude = widget.office.longitude;
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
            child: Column(
              children: [
                SizedBox(
                  width: context.width * 0.8,
                  height: context.width * 0.8,
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
                                  child: Text('LOCATION NOT SET YET',
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: CustomTextStyle.textLargeSemiBold),
                                ),
                              )
                            : Stack(
                                children: [
                                  GoogleMap(
                                    mapType: MapType.hybrid,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(latitude!, longitude!),
                                      zoom: 16.0,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {},
                                    myLocationButtonEnabled: false,
                                    myLocationEnabled: false,
                                    zoomControlsEnabled: false,
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId("source"),
                                        icon: locationIcon,
                                        position: LatLng(
                                          latitude!,
                                          longitude!,
                                        ),
                                      ),
                                    },
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    right: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              (!isLocationPicked() || loading)
                                                  ? "-"
                                                  : latitude.toString(),
                                              style: CustomTextStyle.textRegular
                                                  .copyWith(
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                            Text(
                                              (!isLocationPicked() || loading)
                                                  ? "-"
                                                  : longitude.toString(),
                                              style: CustomTextStyle.textRegular
                                                  .copyWith(
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context)
                          .pushNamed(MapScreen.routeName,
                              arguments: widget.office)
                          .then((value) => context.read<OfficeBloc>().add(
                              LoadOfficeEvent(
                                  officeId:
                                      context.userProvider.user!.companyId!)));
                    },
                    child: RoundedContainer(
                      containerColor: AppColors.blackColor,
                      radius: 10.0,
                      width: context.width * 0.45,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Center(
                          child: Text(
                            (isLocationPicked())
                                ? "VIEW LOCATION"
                                : "SET LOCATION",
                            style: CustomTextStyle.textBigSemiBold.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
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
