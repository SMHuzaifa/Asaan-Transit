class NearStop {
  NearStop({
    required this.stops,
  });
  late final List<Stops> stops;

  NearStop.fromJson(Map<String, dynamic> json){
    stops = List.from(json['stops']).map((e)=>Stops.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['stops'] = stops.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Stops {
  Stops({
    required this.distance,
    required this.globalStopId,
    required this.locationType,
    this.parentStationGlobalStopId,
    required this.routeType,
    required this.rtStopId,
    required this.stopCode,
    required this.stopLat,
    required this.stopLon,
    required this.stopName,
    required this.wheelchairBoarding,
  });
  late final int distance;
  late final String globalStopId;
  late final int locationType;
  late final Null parentStationGlobalStopId;
  late final int routeType;
  late final String rtStopId;
  late final String stopCode;
  late final double stopLat;
  late final double stopLon;
  late final String stopName;
  late final int wheelchairBoarding;

  Stops.fromJson(Map<String, dynamic> json){
    distance = json['distance'];
    globalStopId = json['global_stop_id'];
    locationType = json['location_type'];
    parentStationGlobalStopId = null;
    routeType = json['route_type'];
    rtStopId = json['rt_stop_id'];
    stopCode = json['stop_code'];
    stopLat = json['stop_lat'];
    stopLon = json['stop_lon'];
    stopName = json['stop_name'];
    wheelchairBoarding = json['wheelchair_boarding'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['distance'] = distance;
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