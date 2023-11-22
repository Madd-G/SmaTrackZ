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
  LatLng? currentPosition;

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;

    Set<Circle> circles = {
      Circle(
        circleId: const CircleId('map'),
        center: (currentPosition == null) ? widget.position : currentPosition!,
        radius: 10,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red.withOpacity(0.1),
      )
    };
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: widget.position,
              zoom: 50.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _updateMarker(widget.position);
            },
            onCameraMove: (CameraPosition cp) {
              LatLng center = cp.target;
              debugPrint(center.toString());
              currentPosition = center;
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
            child: Text(
              'Curent latitude: ${currentPosition?.latitude} \n Curent longitude: ${currentPosition?.longitude}',
              style: CustomTextStyle.textMediumSemiBold
                  .copyWith(color: AppColors.whiteColor),
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
}
