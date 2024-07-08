import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/transit_model.dart';
import '../widgets/show_transit_data_widget.dart';

class TransitScreen extends ConsumerWidget {
  const TransitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transitAsyncValue = ref.watch(transitProvider);

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.amber[800],
        title: const Text('Real-Time Transit Updates'),
      ),
      body: transitAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (transit) => ListView.builder(
          itemCount: transit.routes?.length ?? 0,
          itemBuilder: (context, index) {
            final route = transit.routes![index];
            return Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: showData(route: route),
            );
          },
        ),
      ),
    );
  }
}

