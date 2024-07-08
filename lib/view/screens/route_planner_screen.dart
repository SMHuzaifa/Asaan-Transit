import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:test_map/models/plan_trip_model.dart';
import 'dart:convert';

class RoutePlanner extends StatefulWidget {
  const RoutePlanner({super.key});

  @override
  RoutePlannerState createState() => RoutePlannerState();
}

class RoutePlannerState extends State<RoutePlanner> {
  final TextEditingController _currentLocationController =
      TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  MapboxMapController? mapController;
  String accessToken =
      'sk.eyJ1IjoiaHV6YWlmYTc4NiIsImEiOiJjbHh4aXEzMnYxa2s1MmtzZDN2dmVxa3R5In0._P3ORpyYa9JnG4clEz678w';
  Position? _currentPosition;
  LatLng? _destinationPosition;
  LatLng? _currentPositio;
  List<LatLng> _routeCoordinates = [];
  String _distance = '';
  List<String> _instructions = [];

  @override
  void dispose() {
    _currentLocationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _currentPositio = LatLng(position.latitude, position.longitude);
        _currentLocationController.text =
            '${position.latitude}, ${position.longitude}';
      });

      // Get the address for the current position
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _currentLocationController.text = placemarks.first.name!;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getRoute() async {
    if (_currentPositio == null || _destinationPosition == null) return;

    const String apiKey =
        'f0d5b12a11f965dc220651982b6d8cf32c6217056a4f69ff8caa44041d0f4b19';
    final String url =
        'https://external.transitapp.com/v3/otp/plan?apiKey=$apiKey&fromPlace=${_currentPositio!.latitude},${_currentPositio!.longitude}&toPlace=${_destinationPosition!.latitude},${_destinationPosition!.longitude}';

    var headers = {
      'apiKey': apiKey,
    };

    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      final planTrip = PlanTrip.fromJson(data);

      setState(() {
        _routeCoordinates = [];
        for (var itinerary in planTrip.plan.itineraries) {
          for (var leg in itinerary.legs) {
            _routeCoordinates.addAll(_decodePolyline(leg.legGeometry.points));
          }
        }
        _distance =
            '${(planTrip.plan.itineraries.first.duration / 60).toStringAsFixed(2)} minutes';
        _instructions = [];
        for (var itinerary in planTrip.plan.itineraries) {
          for (var leg in itinerary.legs) {
            _instructions.add(leg.headsign);
          }
        }
      });

      mapController?.clearLines();
      mapController?.addLine(LineOptions(
        geometry: _routeCoordinates,
        lineColor: "#ff0000",
        lineWidth: 2.5,
      ));

      // Add markers for current position and destination
      if (_currentPositio != null) {
        mapController?.addSymbol(SymbolOptions(
            geometry:
                LatLng(_currentPositio!.latitude, _currentPositio!.longitude),
            iconImage: "marker-14", // Replace with your marker image
            iconSize: 3.5,
            iconColor: '#ff0000',
            textField: _currentLocationController.text));
      }

      if (_destinationPosition != null) {
        mapController?.addSymbol(SymbolOptions(
            geometry: _destinationPosition!,
            iconImage: "marker-15", // Replace with your marker image
            iconSize: 3.5,
            textField: _destinationController.text));
      }
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to load route');
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Route Planner'),
      ),
      body: Stack(
        children: [
          MapboxMap(
            accessToken: accessToken,
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                  45.51487167249841, -73.56092863046088), // Initial position
              zoom: 12.0,
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _currentLocationController,
                    decoration: InputDecoration(
                      labelText: 'Current Location',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: _getCurrentLocation,
                      ),
                    ),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        setState(() {
                          _currentPositio = const LatLng(45.51487167249841,
                              -73.56092863046088); // Example coordinates
                        });
                      }
                    },
                    readOnly: false,
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _destinationController,
                    decoration: const InputDecoration(labelText: 'Destination'),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        List<Location> locations =
                            await locationFromAddress(value);
                        if (locations.isNotEmpty) {
                          setState(() {
                            _destinationPosition = LatLng(
                                locations.first.latitude,
                                locations.first.longitude);
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: _getRoute,
                    child: const Text('Get Route'),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Distance: $_distance'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
