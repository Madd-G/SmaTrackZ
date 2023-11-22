import 'package:smatrackz/core.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.position});

  static const routeName = '/map';

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor locationIcon = BitmapDescriptor.defaultMarker;
    Set<Circle> circles = {
      Circle(
        circleId: const CircleId('map'),
        center: position,
        radius: 10,
        fillColor: Colors.red.withOpacity(0.4),
        strokeColor: Colors.red.withOpacity(0.1),
      )
    };
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 50.0,
        ),
        onMapCreated: (GoogleMapController controller) {},
        circles: circles,
        markers: {
          Marker(
            markerId: const MarkerId("source"),
            icon: locationIcon,
            position: const LatLng(-7.608132, 109.4675174),
            // position: dummy,
          ),
        },
      ),
    );
  }
}
