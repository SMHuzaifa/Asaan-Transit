
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/plan_trip_model.dart';

final planTripProvider =
AutoDisposeFutureProvider.family<PlanTrip, String>((ref, params) async {
  final response = await http.get(Uri.parse(
      'https://external.transitapp.com/v3/otp/plan?fromPlace=$params&toPlace=45.526168077787894,-73.59506067289408&apiKey=f0d5b12a11f965dc220651982b6d8cf32c6217056a4f69ff8caa44041d0f4b19'));

  if (response.statusCode == 200) {
    return PlanTrip.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load transit data');
  }
});