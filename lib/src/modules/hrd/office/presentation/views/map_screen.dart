import 'package:smatrackz/core.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(this.office, {super.key});

  static const routeName = '/map';

  final OfficeModel office;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker _marker = const Marker(markerId: MarkerId('map-marker-id'));
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GlobalKey googleMapContainerKey = GlobalKey();
  MapType _mapType = MapType.normal;
  GoogleMapController? googleMapController;
  String googleApikey = "AIzaSyCdrEFiuZccbqDqVcHndteT_RkypJLZCDs";
  String location = "Search Location";
  double _radiusValue = 20;
  bool visible = false;

  double? latitude;
  double? longitude;
  bool loading = true;

  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    if (!isLocationPicked()) {
      getLocation();
    } else {
      latitude = widget.office.latitude;
      longitude = widget.office.longitude;
      loading = false;
      currentPosition = LatLng(latitude!, longitude!);
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
    currentPosition = LatLng(position.latitude, position.longitude);
    latitude = position.latitude;
    longitude = position.longitude;
    loading = false;
    setState(() {});
  }

  bool isLocationPicked() {
    if (widget.office.latitude != 0.0 && widget.office.longitude != 0.0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;
    Set<Circle> circles = {
      Circle(
        circleId: const CircleId('map-screen-circle'),
        center: currentPosition!,
        radius: _radiusValue,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red.withOpacity(0.1),
      )
    };
    return Scaffold(
      body: SizedBox(
        key: googleMapContainerKey,
        child: Stack(
          children: [
            GoogleMap(
              mapType: _mapType,
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: (_mapType == MapType.normal) ? 18.0 : 50.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _updateMarker(LatLng(latitude!, longitude!));
                _controller.complete(controller);
                googleMapController = controller;
              },
              onCameraMove: (CameraPosition cp) {
                currentPosition = cp.target;
                setState(() {});
              },
              circles: circles,
              markers: {
                Marker(
                  markerId: const MarkerId("source-marker-id"),
                  icon: locationIcon,
                  position: (currentPosition == null)
                      ? LatLng(latitude!, longitude!)
                      : currentPosition!,
                ),
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, top: 15.0, right: 15.0, bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              logo: const Text(''),
                              types: [],
                              strictbounds: false,
                              // components: [const Component(Component.country, 'idn')],
                              onError: (err) {
                                showInfoDialog(err.errorMessage!);
                              },
                            );

                            if (place != null) {
                              setState(() {
                                location = place.description.toString();
                              });

                              final plist = GoogleMapsPlaces(
                                apiKey: googleApikey,
                                apiHeaders: await const GoogleApiHeaders()
                                    .getHeaders(),
                              );
                              String placeId = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeId);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;
                              var newPosition = LatLng(lat, lang);

                              googleMapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                          target: newPosition, zoom: 17)));
                            }
                          },
                          child: Card(
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  title: Text(
                                    location,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  trailing: const Icon(Icons.search),
                                  dense: true,
                                )),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                            '${currentPosition!.latitude}, ${currentPosition!.longitude}'),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: FloatingActionButton(
                            backgroundColor: AppColors.greenColor,
                            onPressed: _changeMapStyle,
                            child: const Icon(
                              Icons.map,
                              size: 30.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: FloatingActionButton(
                            backgroundColor: AppColors.blueColor,
                            onPressed: _goToDefaultPosition,
                            child: const Icon(
                              Icons.home,
                              size: 30.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: FloatingActionButton(
                            backgroundColor: AppColors.redColor,
                            onPressed: () {
                              visible = !visible;
                              setState(() {});
                            },
                            child:
                                const Icon(Icons.radar_outlined, size: 30.0),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Visibility(
                          visible: visible,
                          child: Slider(
                            inactiveColor: Colors.blue,
                            activeColor: AppColors.primaryColor,
                            value: _radiusValue,
                            min: 1,
                            max: 250,
                            divisions: 250,
                            label:
                                "radius: ${_radiusValue.round().toString()}m",
                            onChanged: (value) {
                              setState(() {
                                _radiusValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<OfficeBloc>().add(
                              UpdateLocationEvent(
                                officeId: widget.office.officeId,
                                latitude: currentPosition!.latitude,
                                longitude: currentPosition!.longitude,
                              ),
                            );

                        Navigator.pop(context);
                      },
                      child: RoundedContainer(
                        radius: 10.0,
                        width: context.width * 0.65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'SET LOCATION',
                              style:
                                  CustomTextStyle.textLargeSemiBold.copyWith(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _marker = _marker.copyWith(positionParam: position);
    });
  }

  void _changeMapStyle() {
    setState(() {
      _mapType = _mapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  Future<void> _goToDefaultPosition() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        // CameraPosition(target: widget.position, zoom: 18.0)));
        CameraPosition(target: LatLng(latitude!, longitude!), zoom: 18.0)));
  }
}
