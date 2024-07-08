class AvailableTransit {
  AvailableTransit({
    required this.routeDepartures,
  });
  late final List<RouteDepartures> routeDepartures;

  AvailableTransit.fromJson(Map<String, dynamic> json){
    routeDepartures = List.from(json['route_departures']).map((e)=>RouteDepartures.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['route_departures'] = routeDepartures.map((e)=>e.toJson()).toList();
    return data;
  }
}

class RouteDepartures {
  RouteDepartures({
    required this.globalRouteId,
    required this.itineraries,
    required this.routeLongName,
    required this.routeShortName,
    required this.routeType,
    required this.routeColor,
    required this.routeTextColor,
    required this.routeNetworkName,
    required this.routeNetworkId,
    required this.ttsLongName,
    required this.ttsShortName,
    required this.sortingKey,
    required this.modeName,
    required this.realTimeRouteId,
  });
  late final String globalRouteId;
  late final List<Itineraries> itineraries;
  late final String routeLongName;
  late final String routeShortName;
  late final int routeType;
  late final String routeColor;
  late final String routeTextColor;
  late final String routeNetworkName;
  late final String routeNetworkId;
  late final String ttsLongName;
  late final String ttsShortName;
  late final String sortingKey;
  late final String modeName;
  late final String realTimeRouteId;

  RouteDepartures.fromJson(Map<String, dynamic> json){
    globalRouteId = json['global_route_id'];
    itineraries = List.from(json['itineraries']).map((e)=>Itineraries.fromJson(e)).toList();
    routeLongName = json['route_long_name'];
    routeShortName = json['route_short_name'];
    routeType = json['route_type'];
    routeColor = json['route_color'];
    routeTextColor = json['route_text_color'];
    routeNetworkName = json['route_network_name'];
    routeNetworkId = json['route_network_id'];
    ttsLongName = json['tts_long_name'];
    ttsShortName = json['tts_short_name'];
    sortingKey = json['sorting_key'];
    modeName = json['mode_name'];
    realTimeRouteId = json['real_time_route_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['global_route_id'] = globalRouteId;
    data['itineraries'] = itineraries.map((e)=>e.toJson()).toList();
    data['route_long_name'] = routeLongName;
    data['route_short_name'] = routeShortName;
    data['route_type'] = routeType;
    data['route_color'] = routeColor;
    data['route_text_color'] = routeTextColor;
    data['route_network_name'] = routeNetworkName;
    data['route_network_id'] = routeNetworkId;
    data['tts_long_name'] = ttsLongName;
    data['tts_short_name'] = ttsShortName;
    data['sorting_key'] = sortingKey;
    data['mode_name'] = modeName;
    data['real_time_route_id'] = realTimeRouteId;
    return data;
  }
}

class Itineraries {
  Itineraries({
    required this.directionId,
    required this.headsign,
    required this.directionHeadsign,
    required this.mergedHeadsign,
    required this.scheduleItems,
    required this.branchCode,
    required this.closestStop,
  });
  late final int directionId;
  late final String headsign;
  late final String directionHeadsign;
  late final String mergedHeadsign;
  late final List<ScheduleItems> scheduleItems;
  late final String branchCode;
  late final ClosestStop closestStop;

  Itineraries.fromJson(Map<String, dynamic> json){
    directionId = json['direction_id'];
    headsign = json['headsign'];
    directionHeadsign = json['direction_headsign'];
    mergedHeadsign = json['merged_headsign'];
    scheduleItems = List.from(json['schedule_items']).map((e)=>ScheduleItems.fromJson(e)).toList();
    branchCode = json['branch_code'];
    closestStop = ClosestStop.fromJson(json['closest_stop']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['direction_id'] = directionId;
    data['headsign'] = headsign;
    data['direction_headsign'] = directionHeadsign;
    data['merged_headsign'] = mergedHeadsign;
    data['schedule_items'] = scheduleItems.map((e)=>e.toJson()).toList();
    data['branch_code'] = branchCode;
    data['closest_stop'] = closestStop.toJson();
    return data;
  }
}

class ScheduleItems {
  ScheduleItems({
    required this.departureTime,
    required this.isCancelled,
    required this.isRealTime,
    required this.rtTripId,
    required this.scheduledDepartureTime,
    required this.wheelchairAccessible,
    required this.tripSearchKey,
  });
  late final int departureTime;
  late final bool isCancelled;
  late final bool isRealTime;
  late final String rtTripId;
  late final int scheduledDepartureTime;
  late final int wheelchairAccessible;
  late final String tripSearchKey;

  ScheduleItems.fromJson(Map<String, dynamic> json){
    departureTime = json['departure_time'];
    isCancelled = json['is_cancelled'];
    isRealTime = json['is_real_time'];
    rtTripId = json['rt_trip_id'];
    scheduledDepartureTime = json['scheduled_departure_time'];
    wheelchairAccessible = json['wheelchair_accessible'];
    tripSearchKey = json['trip_search_key'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['departure_time'] = departureTime;
    data['is_cancelled'] = isCancelled;
    data['is_real_time'] = isRealTime;
    data['rt_trip_id'] = rtTripId;
    data['scheduled_departure_time'] = scheduledDepartureTime;
    data['wheelchair_accessible'] = wheelchairAccessible;
    data['trip_search_key'] = tripSearchKey;
    return data;
  }
}

class ClosestStop {
  ClosestStop({
    required this.distance,
    required this.globalStopId,
    required this.locationType,
    required this.parentStationGlobalStopId,
    required this.routeType,
    required this.stopLat,
    required this.stopLon,
    required this.stopName,
    required this.stopCode,
    required this.rtStopId,
    required this.wheelchairBoarding,
  });
  late final int distance;
  late final String globalStopId;
  late final int locationType;
  late final String parentStationGlobalStopId;
  late final int routeType;
  late final double stopLat;
  late final double stopLon;
  late final String stopName;
  late final String stopCode;
  late final String rtStopId;
  late final int wheelchairBoarding;

  ClosestStop.fromJson(Map<String, dynamic> json){
    distance = json['distance'];
    globalStopId = json['global_stop_id'];
    locationType = json['location_type'];
    parentStationGlobalStopId = json['parent_station_global_stop_id'];
    routeType = json['route_type'];
    stopLat = json['stop_lat'];
    stopLon = json['stop_lon'];
    stopName = json['stop_name'];
    stopCode = json['stop_code'];
    rtStopId = json['rt_stop_id'];
    wheelchairBoarding = json['wheelchair_boarding'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['distance'] = distance;
    data['global_stop_id'] = globalStopId;
    data['location_type'] = locationType;
    data['parent_station_global_stop_id'] = parentStationGlobalStopId;
    data['route_type'] = routeType;
    data['stop_lat'] = stopLat;
    data['stop_lon'] = stopLon;
    data['stop_name'] = stopName;
    data['stop_code'] = stopCode;
    data['rt_stop_id'] = rtStopId;
    data['wheelchair_boarding'] = wheelchairBoarding;
    return data;
  }
}