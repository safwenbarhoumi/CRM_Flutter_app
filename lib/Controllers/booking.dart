import 'package:flutter/material.dart';
import '../Services/booking.dart';

class BookingController with ChangeNotifier {
  Map<String, List<String>> _availableTimes = {};
  Map<String, List<String>> get availableTimes => _availableTimes;

  Future<void> fetchAvailableTimes(String doctorId) async {
    try {
      _availableTimes = await BookingService.getAvailableTimes(doctorId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching available times: $e');
    }
  }

  Future<void> bookAppointment(
    BuildContext context,
    String doctorId,
    String patientId,
    String date,
    String time,
  ) async {
    try {
      await BookingService.makeAppointment(doctorId, patientId, date, time);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Your appointment was made successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error making appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
