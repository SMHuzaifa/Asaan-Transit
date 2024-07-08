import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/available_transit_model.dart';
import '../../models/near_stop_model.dart';
import '../widgets/buildTransitLineInfo_widget.dart';

class NearbyStopsScreen extends StatefulWidget {
  const NearbyStopsScreen({super.key});

  @override
  NearbyStopsScreenState createState() => NearbyStopsScreenState();
}

class NearbyStopsScreenState extends State<NearbyStopsScreen> {
  final String apiKey =
      'f0d5b12a11f965dc220651982b6d8cf32c6217056a4f69ff8caa44041d0f4b19';
  final String apiUrl =
      'https://external.transitapp.com/v3/public/nearby_stops';
  List<Stops> _nearbyStops = [];
  final Map<String, AvailableTransit> _availableTransits = {};
  bool _isLoading = false;
  MapboxMapController? _mapController;
  String accessToken =
      'sk.eyJ1IjoiaHV6YWlmYTc4NiIsImEiOiJjbHh4aXEzMnYxa2s1MmtzZDN2dmVxa3R5In0._P3ORpyYa9JnG4clEz678w';

  @override
  void initState() {
    super.initState();
    _fetchNearbyStops();
  }

  Future<void> _fetchNearbyStops() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var headers = {'apiKey': apiKey};
      var uri = Uri.parse(
          '$apiUrl?lat=${position.latitude}&lon=${position.longitude}&apiKey=$apiKey');
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        NearStop nearStop = NearStop.fromJson(jsonResponse);

        setState(() {
          _nearbyStops = nearStop.stops;
        });

        await _fetchAvailableTransitLines();
        setState(() {
          _isLoading = false;
        });
        _addMarkers();
      } else {
        throw Exception('Failed to load nearby stops');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching nearby stops: $e');
    }
  }

  Future<void> _fetchAvailableTransitLines() async {
    for (var stop in _nearbyStops) {
      var uri = Uri.parse(
          'https://external.transitapp.com/v3/public/stop_departures?global_stop_id=${stop.globalStopId}&apiKey=$apiKey');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        AvailableTransit availableTransit =
            AvailableTransit.fromJson(jsonResponse);
        setState(() {
          _availableTransits[stop.globalStopId] = availableTransit;
        });
      } else {
        print('Failed to load transit lines for stop: ${stop.globalStopId}');
      }
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    _addMarkers();
  }

  void _addMarkers() {
    if (_mapController != null) {
      _mapController!.clearSymbols(); // Clear existing markers
      for (var stop in _nearbyStops) {
        _mapController!.addSymbol(SymbolOptions(
          geometry: LatLng(stop.stopLat, stop.stopLon),
          iconImage: 'marker-15', // Replace with your icon image asset
          textField: '${stop.stopName} (${stop.distance} meters)',
          iconSize: 2.5,
          textOffset: const Offset(0, 2),
        ));
      }
    }
  }

  void _onAddressSubmitted(String address) async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;

        var headers = {'apiKey': apiKey};
        var uri =
            Uri.parse('$apiUrl?lat=$latitude&lon=$longitude&apiKey=$apiKey');
        var response = await http.get(uri, headers: headers);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          NearStop nearStop = NearStop.fromJson(jsonResponse);

          setState(() {
            _nearbyStops = nearStop.stops;
          });

          await _fetchAvailableTransitLines();
          setState(() {
            _isLoading = false;
          });

          _mapController?.animateCamera(
            CameraUpdate.newLatLng(LatLng(latitude, longitude)),
          );
          _addMarkers();
        } else {
          throw Exception('Failed to load nearby stops');
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching nearby stops: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Nearby Stops'),
        backgroundColor: Colors.amber[800],
      ),

      body: Stack(
        children: [
          MapboxMap(
            accessToken: accessToken,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(45.526168077787894, -73.59506067289408),
              zoom: 15.0,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: TextField(
              onSubmitted: _onAddressSubmitted,
              decoration: InputDecoration(
                hintText: 'Enter address or coordinates',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              height: 200,
              child: ListView.builder(
                itemCount: _nearbyStops.length,
                itemBuilder: (context, index) {
                  Stops stop = _nearbyStops[index];
                  return ExpansionTile(
                    title: Text(stop.stopName),
                    children: [
                      buildTransitLineInfo(stop),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
