import 'package:flutter/material.dart';

import '../../models/available_transit_model.dart';
import '../../models/near_stop_model.dart';

Widget buildTransitLineInfo(Stops stop) {
  Map<String, AvailableTransit> availableTransits = {};

  AvailableTransit? availableTransit = availableTransits[stop.globalStopId];
  if (availableTransit == null) return const Text('No Transit Found');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: availableTransit.routeDepartures.map((routeDeparture) {
      return Card(
        child: ListTile(
          title: Text('${routeDeparture.routeLongName} (${routeDeparture.routeShortName})'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: routeDeparture.itineraries.map((itinerary) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itinerary.scheduleItems.map((scheduleItem) {
                  return Text(
                    'Departure Time: ${DateTime.fromMillisecondsSinceEpoch(scheduleItem.departureTime * 1000)}',
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      );
    }).toList(),
  );
}