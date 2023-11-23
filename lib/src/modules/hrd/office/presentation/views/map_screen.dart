import 'package:smatrackz/core.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.position});

  static const routeName = '/map';

  final LatLng position;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker _marker = const Marker(markerId: MarkerId('markerId'));
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentPosition;
  MapType _mapType = MapType.normal;
  GoogleMapController? googleMapController;
  double _radiusValue = 10;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;
    Set<Circle> circles = {
      Circle(
        circleId: const CircleId('map'),
        center: (currentPosition == null) ? widget.position : currentPosition!,
        radius: _radiusValue,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red.withOpacity(0.1),
      )
    };
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: _mapType,
            initialCameraPosition: CameraPosition(
              target: widget.position,
              zoom: (_mapType == MapType.normal) ? 18.0 : 50.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _updateMarker(widget.position);
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition cp) {
              currentPosition = cp.target;
              setState(() {});
            },
            circles: circles,
            markers: {
              Marker(
                markerId: const MarkerId("source"),
                icon: locationIcon,
                position: (currentPosition == null)
                    ? widget.position
                    : currentPosition!,
              ),
            },
          ),
          Positioned(
            top: 50.0,
            right: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Latitude: ${currentPosition?.latitude} \n Longitude: ${currentPosition?.longitude}',
                  style: CustomTextStyle.textMediumSemiBold.copyWith(
                      color: (_mapType == MapType.normal)
                          ? AppColors.blackColor
                          : AppColors.whiteColor),
                ),
                const SizedBox(height: 5.0),
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
                const SizedBox(height: 5.0),
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
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.redColor,
                    onPressed: () {
                      visible = !visible;
                      setState(() {});
                    },
                    child: const Icon(Icons.radar_outlined, size: 30.0),
                  ),
                ),
                Visibility(
                  visible: visible,
                  child: Slider(
                    value: _radiusValue,
                    min: 1,
                    max: 250,
                    divisions: 250,
                    label: "radius: ${_radiusValue.round().toString()}m",
                    onChanged: (value) {
                      setState(() {
                        _radiusValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
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
        CameraPosition(target: widget.position, zoom: 18.0)));
  }
}
