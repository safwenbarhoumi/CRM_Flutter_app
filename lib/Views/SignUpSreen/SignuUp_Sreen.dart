import 'package:flutter/material.dart';
import 'package:happytech_clean_architecture/Models/signup.dart';
import 'package:provider/provider.dart';
import '../../Controllers/signup_provider.dart';
import '../../Services/signup.dart';
import '../SignInSreen/signIn_sreen.dart';
import 'register_widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedRole;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final List<String> _roles = ['PATIENT', 'DOCTOR', 'ADMIN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Create an account",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  CustomTextField(
                      controller: _firstNameController,
                      hint: "First Name",
                      icon: Icons.person),
                  CustomTextField(
                      controller: _lastNameController,
                      hint: "Last Name",
                      icon: Icons.person),
                  CustomTextField(
                      controller: _emailController,
                      hint: "Email",
                      icon: Icons.email,
                      isEmail: true),
                  CustomTextField(
                      controller: _phoneController,
                      hint: "Phone",
                      icon: Icons.phone,
                      isPhone: true),
                  RoleDropdown(
                    roles: _roles,
                    selectedRole: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),
                  PasswordField(
                      controller: _passwordController,
                      hint: "Password",
                      isPassword: true,
                      isVisible: _isPasswordVisible,
                      toggleVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }),
                  PasswordField(
                      controller: _confirmPasswordController,
                      hint: "Confirm Password",
                      isPassword: true,
                      isVisible: _isConfirmPasswordVisible,
                      toggleVisibility: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      }),
                  Consumer<SignUpProvider>(
                    builder: (context, signUpProvider, child) {
                      return Column(
                        children: [
                          if (signUpProvider.isLoading)
                            const CircularProgressIndicator(),
                          if (signUpProvider.errorMessage != null)
                            Text(signUpProvider.errorMessage!,
                                style: const TextStyle(color: Colors.red)),
                          CustomButton(
                            text: "Sign Up",
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  _selectedRole != null) {
                                final user = SignUpModel(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                  role: _selectedRole!,
                                );
                                signUpProvider.signUp(user, context);
                                /*try {
                                  final response = await SignUpService.signUp(user);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
                                }*/
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignIn()),
                      );
                    },
                    child: Text(
                      "Already have an account? Login",
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
      ),
    );
  }
}
