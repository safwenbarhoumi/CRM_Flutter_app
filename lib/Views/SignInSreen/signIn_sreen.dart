import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Controllers/loginController.dart';
import '../AdminSpace/admin_dashboard.dart';
import '../NavigationBottomBarDoctor.dart';
import '../NavigationBottomBarPatient.dart';
import '../SignUpSreen/SignuUp_Sreen.dart';
import 'sign_in_widgets.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
  final List<String> _roles = ['Patient', 'Doctor', 'Admin'];
  bool _obscurePassword = true;

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _navigateBasedOnRole(String role) {
    Widget destination;
    switch (role) {
      case 'Doctor':
        destination = NavigationBottomBarDoctor();
        break;
      case 'Admin':
        destination = AdminDashboard();
        break;
      case 'Patient':
      default:
        destination = NavigationBottomBar();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Log In",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _emailController,
                          hint: "Email",
                          icon: Icons.email,
                          isEmail: true),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      RoleDropdown(
                        roles: _roles,
                        selectedRole: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Consumer<LoginController>(
                  builder: (context, loginController, child) {
                    return CustomButton(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _selectedRole != null) {
                          _showLoadingDialog(context);

                          bool success = await loginController.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _selectedRole!,
                          );

                          _hideLoadingDialog(context);

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login successful!")),
                            );
                            _navigateBasedOnRole(_selectedRole!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Login failed. Try again.")),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: "Go to Home",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationBottomBar(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Register()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
