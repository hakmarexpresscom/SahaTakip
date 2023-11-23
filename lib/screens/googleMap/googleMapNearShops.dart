import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/constants.dart';

class MapScreenNearShops extends StatefulWidget {

  late String currentLat;
  late String currentLong;

  MapScreenNearShops({Key? key, required this.currentLat, required this.currentLong}): super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreenNearShops> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  final Iterable _markers = Iterable.generate(GoogleMapMarkerList.list.length, (index) {
    return Marker(
      markerId: MarkerId(GoogleMapMarkerList.list[index]['id']),
      position: LatLng(
          double.parse(GoogleMapMarkerList.list[index]['lat']),
          double.parse(GoogleMapMarkerList.list[index]['long'])
      ),
    );
  });



  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Yakın Mağazaların Konumu'),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: LatLng(double.parse(widget.currentLat), (double.parse(widget.currentLong))), zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        ),
    );
  }
}