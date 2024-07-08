class PlanTrip {
  final Plan plan;

  PlanTrip({required this.plan});

  factory PlanTrip.fromJson(Map<String, dynamic> json) {
    return PlanTrip(
      plan: Plan.fromJson(json['plan'] ?? {}),
    );
  }
}

class Plan {
  final List<Itineraries> itineraries;

  Plan({required this.itineraries});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      itineraries: (json['itineraries'] as List<dynamic>?)
          ?.map((item) => Itineraries.fromJson(item))
          .toList() ??
          [],
    );
  }
}

class From {
  double? lat;
  double? lon;
  String? name;
  String? vertexType;

  From({this.lat, this.lon, this.name, this.vertexType});

  From.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num).toDouble();
    lon = (json['lon'] as num).toDouble();
    name = json['name'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['name'] = name;
    data['vertexType'] = vertexType;
    return data;
  }
}

class Itineraries {
  final List<Leg> legs;
  final double duration;

  Itineraries({required this.legs, required this.duration});

  factory Itineraries.fromJson(Map<String, dynamic> json) {
    return Itineraries(
      legs: (json['legs'] as List<dynamic>?)
          ?.map((item) => Leg.fromJson(item))
          .toList() ??
          [],
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
    );
  }
}


class Leg {
  final String headsign;
  final LegGeometry legGeometry;

  Leg({required this.headsign, required this.legGeometry});

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      headsign: json['headsign'] as String? ?? 'No headsign',
      legGeometry: LegGeometry.fromJson(json['legGeometry'] ?? {}),
    );
  }
}

class IntermediateStops {
  IntermediateStops({
    required this.lat,
    required this.lon,
    required this.name,
    required this.stopCode,
    required this.stopId,
    required this.globalStopId,
    required this.stopIndex,
    required this.vertexType,
  });
  late final int lat;
  late final int lon;
  late final String name;
  late final String stopCode;
  late final String stopId;
  late final String globalStopId;
  late final int stopIndex;
  late final String vertexType;

  IntermediateStops.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
    stopCode = json['stopCode'];
    stopId = json['stopId'];
    globalStopId = json['globalStopId'];
    stopIndex = json['stopIndex'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['name'] = name;
    data['stopCode'] = stopCode;
    data['stopId'] = stopId;
    data['globalStopId'] = globalStopId;
    data['stopIndex'] = stopIndex;
    data['vertexType'] = vertexType;
    return data;
  }
}


class LegGeometry {
  final String points;

  LegGeometry({required this.points});

  factory LegGeometry.fromJson(Map<String, dynamic> json) {
    return LegGeometry(
      points: json['points'] as String? ?? '',
    );
  }
}

class To {
  To({
    required this.lat,
    required this.lon,
    required this.name,
    required this.stopCode,
    required this.stopId,
    required this.globalStopId,
    required this.stopIndex,
    required this.vertexType,
  });
  late final int lat;
  late final int lon;
  late final String name;
  late final String stopCode;
  late final String stopId;
  late final String globalStopId;
  late final int stopIndex;
  late final String vertexType;

  To.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
    stopCode = json['stopCode'];
    stopId = json['stopId'];
    globalStopId = json['globalStopId'];
    stopIndex = json['stopIndex'];
    vertexType = json['vertexType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['name'] = name;
    data['stopCode'] = stopCode;
    data['stopId'] = stopId;
    data['globalStopId'] = globalStopId;
    data['stopIndex'] = stopIndex;
    data['vertexType'] = vertexType;
    return data;
  }
}

class Transfers {
  Transfers({
    required this.bufferTime,
    required this.defaultMinimumTime,
    required this.minimumTimes,
  });
  late final int bufferTime;
  late final int defaultMinimumTime;
  late final List<MinimumTimes> minimumTimes;

  Transfers.fromJson(Map<String, dynamic> json){
    bufferTime = json['bufferTime'];
    defaultMinimumTime = json['defaultMinimumTime'];
    minimumTimes = List.from(json['minimumTimes']).map((e)=>MinimumTimes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bufferTime'] = bufferTime;
    data['defaultMinimumTime'] = defaultMinimumTime;
    data['minimumTimes'] = minimumTimes.map((e)=>e.toJson()).toList();
    return data;
  }
}

class MinimumTimes {
  MinimumTimes({
    required this.fromFeedId,
    required this.fromStopId,
    required this.minTime,
    required this.toFeedId,
    required this.toStopId,
  });
  late final int fromFeedId;
  late final int fromStopId;
  late final int minTime;
  late final int toFeedId;
  late final int toStopId;

  MinimumTimes.fromJson(Map<String, dynamic> json){
    fromFeedId = json['fromFeedId'];
    fromStopId = json['fromStopId'];
    minTime = json['minTime'];
    toFeedId = json['toFeedId'];
    toStopId = json['toStopId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromFeedId'] = fromFeedId;
    data['fromStopId'] = fromStopId;
    data['minTime'] = minTime;
    data['toFeedId'] = toFeedId;
    data['toStopId'] = toStopId;
    return data;
  }
}