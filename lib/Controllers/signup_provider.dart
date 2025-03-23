import 'package:flutter/material.dart';
import '../Models/signup.dart';
import '../services/signup.dart';

class SignUpProvider extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> signUp(SignUpModel user, BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final message = await _signUpService.signUp(user);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      errorMessage = e.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signup failed!")));
    }

    isLoading = false;
    notifyListeners();
  }
}
