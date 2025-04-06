import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/appointment_history_service.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  final String doctorId;
  final String patientId;

  const AppointmentHistoryScreen({
    Key? key,
    required this.doctorId,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider =
        Provider.of<AppointmentHistoryService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment History"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: historyProvider.fetchAppointmentHistory(doctorId, patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final historyList = historyProvider.history;

          if (historyList.isEmpty) {
            return const Center(child: Text("No history found."));
          }

          return ListView.builder(
            itemCount: historyList.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = historyList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.history, color: Colors.blueAccent),
                  title: Text(
                    item,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
