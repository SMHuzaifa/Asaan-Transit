import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transit_model.dart';

class showData extends StatelessWidget {
  const showData({
    super.key,
    required this.route,
  });

  final Routes route;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          route.routeLongName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: route.itineraries?.map((itinerary) {
            final nextScheduleItem =
                itinerary.scheduleItems?.first;
            if (nextScheduleItem == null) {
              return const Text('No schedule available');
            }

            final scheduledTime =
            nextScheduleItem.scheduledDepartureTime != null
                ? DateTime.fromMillisecondsSinceEpoch(
                nextScheduleItem
                    .scheduledDepartureTime! *
                    1000)
                : null;
            final actualTime =
            nextScheduleItem.departureTime != null
                ? DateTime.fromMillisecondsSinceEpoch(
                nextScheduleItem.departureTime! * 1000)
                : null;

            final delay = (actualTime != null &&
                scheduledTime != null)
                ? actualTime.difference(scheduledTime).inMinutes
                : null;

            final formattedScheduledTime = scheduledTime != null
                ? DateFormat.Hm().format(scheduledTime)
                : 'N/A';
            final formattedActualTime = actualTime != null
                ? DateFormat.Hm().format(actualTime)
                : 'N/A';

            return Container(
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Scheduled Departure: $formattedScheduledTime'),
                  Text(
                      'Actual Departure: $formattedActualTime'),
                  Text('Delay: ${delay ?? 'N/A'} minutes'),
                ],
              ),

            );
          }).toList() ??
              [const Text('No itineraries available')],
        ),
      ],
    );
  }
}