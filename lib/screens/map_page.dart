import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng mylatlong = LatLng(19.0457, 72.8892);
  String address = 'Chembur';
  final String apiKey =
      'AIzaSyCA_ShCCe9WKurHPNYgE40OGkxwullvink'; // Replace with API Key

  Set<Marker> hospitalMarkers = {
    Marker(
      markerId: MarkerId('hospital_fixed'),
      position: LatLng(19.0471, 72.9111),
      infoWindow: InfoWindow(title: 'Hospital'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };
  List<LatLng> hospitalLocations = [LatLng(19.0471, 72.9111)];
  List<LatLng> routeCoordinates = []; // List to hold route coordinates

  Future<void> fetchDirections(LatLng end) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${mylatlong.latitude},${mylatlong.longitude}&destination=${end.latitude},${end.longitude}&mode=driving&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        final points = data['routes'][0]['overview_polyline']['points'];
        routeCoordinates = decodePolyline(points);
      }
    } else {
      Fluttertoast.showToast(msg: 'Error fetching directions.');
    }
    setState(() {});
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polylineCoordinates = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      polylineCoordinates.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylineCoordinates;
  }

  setMarker(LatLng value) async {
    mylatlong = value;

    List<Placemark> result =
        await placemarkFromCoordinates(value.latitude, value.longitude);

    if (result.isNotEmpty) {
      address =
          '${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';
    }

    setState(() {});
    Fluttertoast.showToast(msg: '📍 ' + address);

    await fetchDirections(LatLng(19.0471, 72.9111)); // Fetch route to fixed hospital
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: mylatlong, zoom: 12),
        markers: {
          Marker(
            infoWindow: InfoWindow(title: address),
            position: mylatlong,
            draggable: true,
            markerId: MarkerId('1'),
            onDragEnd: (value) {
              setMarker(value);
            },
          ),
          ...hospitalMarkers, // Add hospital markers to the map
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('hospital_path'),
            points: routeCoordinates, // Path from user location to the nearest hospital
            color: Colors.blue,
            width: 5,
          ),
        },
        onTap: (value) {
          setMarker(value);
        },
      ),
    );
  }
}
