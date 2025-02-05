import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/SignupCubit.dart';
import 'SignupState.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset('assets/logo/crm.png', height: 100),
                const Text("Sign Up",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Create your account to get started",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                          _fullNameController, "Full Name", Icons.person),
                      _buildPhoneField(),
                      _buildTextField(_emailController, "Email", Icons.email,
                          isEmail: true),
                      _buildPasswordField(
                          _passwordController, "Password", true),
                      _buildPasswordField(_confirmPasswordController,
                          "Confirm Password", false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSignupButton(context),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: const Text("Log In",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hint';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          hintText: "Phone Number",
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }
          //else if (!RegExp(r'^\d{8}\$').hasMatch(value)) {
          //  return 'Phone number must be exactly 8 digits';
          // }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String hint, bool isPasswordField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText:
            isPasswordField ? !_isPasswordVisible : !_isConfirmPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(isPasswordField
                ? (_isPasswordVisible ? Icons.visibility : Icons.visibility_off)
                : (_isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off)),
            onPressed: () {
              setState(() {
                if (isPasswordField) {
                  _isPasswordVisible = !_isPasswordVisible;
                } else {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                }
              });
            },
          ),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hint';
          }
          if (isPasswordField &&
              _confirmPasswordController.text.isNotEmpty &&
              _confirmPasswordController.text != value) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushNamed(context, '/home');
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: Colors.blueAccent.withOpacity(0.5),
      ),
      child: const Text("Sign Up",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
