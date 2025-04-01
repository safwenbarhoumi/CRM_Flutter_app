import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Controllers/loginController.dart';
import '../Complete_profile.dart';
import '../NavigationBottomBar.dart';
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _emailController,
                          hint: "Email",
                          icon: Icons.email,
                          isEmail: true),
                      CustomTextField(
                          controller: _passwordController,
                          hint: "Password",
                          icon: Icons.lock,
                          isPassword: true),
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
                Consumer<LoginController>(
                  builder: (context, loginController, child) {
                    return CustomButton(
                      text: loginController.isLoading ? "Loading..." : "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _selectedRole != null) {
                          bool success = await loginController.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _selectedRole!,
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login successful!")));
                            MaterialPageRoute(
                                builder: (context) => NavigationBottomBar());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Login failed. Try again.")));
                          }
                        }
                      },
                    );
                  },
                ),
                CustomButton(
                  text: "Go to Home",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            //CompleteProfile(), //
                            NavigationBottomBar(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
