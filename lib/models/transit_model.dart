import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
class Transit {
  List<Routes>? routes;

  Transit({this.routes});

  Transit.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Routes {
  String? globalRouteId;
  List<Itineraries>? itineraries;
  String? modeName;
  String? realTimeRouteId;
  String? routeColor;
  String? routeLongName;
  String? routeNetworkId;
  String? routeNetworkName;
  String? routeShortName;
  String? routeTextColor;
  int? routeType;
  String? sortingKey;
  String? ttsLongName;
  String? ttsShortName;

  Routes(
      {this.globalRouteId,
        this.itineraries,
        this.modeName,
        this.realTimeRouteId,
        this.routeColor,
        this.routeLongName,
        this.routeNetworkId,
        this.routeNetworkName,
        this.routeShortName,
        this.routeTextColor,
        this.routeType,
        this.sortingKey,
        this.ttsLongName,
        this.ttsShortName});

  Routes.fromJson(Map<String, dynamic> json) {
    globalRouteId = json['global_route_id'];
    if (json['itineraries'] != null) {
      itineraries = <Itineraries>[];
      json['itineraries'].forEach((v) {
        itineraries!.add(Itineraries.fromJson(v));
      });
    }
    modeName = json['mode_name'];
    realTimeRouteId = json['real_time_route_id'];
    routeColor = json['route_color'];
    routeLongName = json['route_long_name'];
    routeNetworkId = json['route_network_id'];
    routeNetworkName = json['route_network_name'];
    routeShortName = json['route_short_name'];
    routeTextColor = json['route_text_color'];
    routeType = json['route_type'];
    sortingKey = json['sorting_key'];
    ttsLongName = json['tts_long_name'];
    ttsShortName = json['tts_short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['global_route_id'] = globalRouteId;
    if (itineraries != null) {
      data['itineraries'] = itineraries!.map((v) => v.toJson()).toList();
    }
    data['mode_name'] = modeName;
    data['real_time_route_id'] = realTimeRouteId;
    data['route_color'] = routeColor;
    data['route_long_name'] = routeLongName;
    data['route_network_id'] = routeNetworkId;
    data['route_network_name'] = routeNetworkName;
    data['route_short_name'] = routeShortName;
    data['route_text_color'] = routeTextColor;
    data['route_type'] = routeType;
    data['sorting_key'] = sortingKey;
    data['tts_long_name'] = ttsLongName;
    data['tts_short_name'] = ttsShortName;
    return data;
  }
}

class Itineraries {
  String? branchCode;
  ClosestStop? closestStop;
  String? directionHeadsign;
  int? directionId;
  String? headsign;
  String? mergedHeadsign;
  List<ScheduleItems>? scheduleItems;

  Itineraries(
      {this.branchCode,
        this.closestStop,
        this.directionHeadsign,
        this.directionId,
        this.headsign,
        this.mergedHeadsign,
        this.scheduleItems});

  Itineraries.fromJson(Map<String, dynamic> json) {
    branchCode = json['branch_code'];
    closestStop = json['closest_stop'] != null
        ? ClosestStop.fromJson(json['closest_stop'])
        : null;
    directionHeadsign = json['direction_headsign'];
    directionId = json['direction_id'];
    headsign = json['headsign'];
    mergedHeadsign = json['merged_headsign'];
    if (json['schedule_items'] != null) {
      scheduleItems = <ScheduleItems>[];
      json['schedule_items'].forEach((v) {
        scheduleItems!.add(ScheduleItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_code'] = branchCode;
    if (closestStop != null) {
      data['closest_stop'] = closestStop!.toJson();
    }
    data['direction_headsign'] = directionHeadsign;
    data['direction_id'] = directionId;
    data['headsign'] = headsign;
    data['merged_headsign'] = mergedHeadsign;
    if (scheduleItems != null) {
      data['schedule_items'] =
          scheduleItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClosestStop {
  String? globalStopId;
  int? locationType;
  Null parentStationGlobalStopId;
  int? routeType;
  String? rtStopId;
  String? stopCode;
  double? stopLat;
  double? stopLon;
  String? stopName;
  int? wheelchairBoarding;

  ClosestStop(
      {this.globalStopId,
        this.locationType,
        this.parentStationGlobalStopId,
        this.routeType,
        this.rtStopId,
        this.stopCode,
        this.stopLat,
        this.stopLon,
        this.stopName,
        this.wheelchairBoarding});

  ClosestStop.fromJson(Map<String, dynamic> json) {
    globalStopId = json['global_stop_id'];
    locationType = json['location_type'];
    parentStationGlobalStopId = json['parent_station_global_stop_id'];
    routeType = json['route_type'];
    rtStopId = json['rt_stop_id'];
    stopCode = json['stop_code'];
    stopLat = json['stop_lat'];
    stopLon = json['stop_lon'];
    stopName = json['stop_name'];
    wheelchairBoarding = json['wheelchair_boarding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['global_stop_id'] = globalStopId;
    data['location_type'] = locationType;
    data['parent_station_global_stop_id'] = parentStationGlobalStopId;
    data['route_type'] = routeType;
    data['rt_stop_id'] = rtStopId;
    data['stop_code'] = stopCode;
    data['stop_lat'] = stopLat;
    data['stop_lon'] = stopLon;
    data['stop_name'] = stopName;
    data['wheelchair_boarding'] = wheelchairBoarding;
    return data;
  }
}

class ScheduleItems {
  int? departureTime;
  bool? isCancelled;
  bool? isRealTime;
  String? rtTripId;
  int? scheduledDepartureTime;
  String? tripSearchKey;
  int? wheelchairAccessible;

  ScheduleItems(
      {this.departureTime,
        this.isCancelled,
        this.isRealTime,
        this.rtTripId,
        this.scheduledDepartureTime,
        this.tripSearchKey,
        this.wheelchairAccessible});

  ScheduleItems.fromJson(Map<String, dynamic> json) {
    departureTime = json['departure_time'];
    isCancelled = json['is_cancelled'];
    isRealTime = json['is_real_time'];
    rtTripId = json['rt_trip_id'];
    scheduledDepartureTime = json['scheduled_departure_time'];
    tripSearchKey = json['trip_search_key'];
    wheelchairAccessible = json['wheelchair_accessible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departure_time'] = departureTime;
    data['is_cancelled'] = isCancelled;
    data['is_real_time'] = isRealTime;
    data['rt_trip_id'] = rtTripId;
    data['scheduled_departure_time'] = scheduledDepartureTime;
    data['trip_search_key'] = tripSearchKey;
    data['wheelchair_accessible'] = wheelchairAccessible;
    return data;
  }
}
final transitProvider = StreamProvider<Transit>((ref) async* {
  while (true) {
    final response = await http.get(Uri.parse('https://external.transitapp.com/v3/public/nearby_routes?apikey=f0d5b12a11f965dc220651982b6d8cf32c6217056a4f69ff8caa44041d0f4b19&lat=45.526168077787894&lon=-73.59506067289408'));
    if (response.statusCode == 200) {
      yield Transit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transit data');
    }
    await Future.delayed(const Duration(seconds: 30)); // Fetch data every 30 seconds
  }
});