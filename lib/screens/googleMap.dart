import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapScreen extends StatefulWidget {

  late String targetLat;
  late String targetLong;

  MapScreen({Key? key, required this.targetLat, required this.targetLong}): super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};

  @override
  void initState(){
    super.initState();
    setState(() {
      _markers.add(Marker(markerId: MarkerId('Home'),
      position: LatLng(double.parse(widget.targetLat) ?? 0.0, double.parse(widget.targetLong))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Mağaza Konumu'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition:CameraPosition(
            target: LatLng(double.parse(widget.targetLat), double.parse(widget.targetLong)),
            zoom: 15.0,
          ),
          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
          markers: _markers,
        ) ,
      ),
    );
  }
}