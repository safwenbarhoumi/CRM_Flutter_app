import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final List<String> _roles = ['Patient', 'Doctor', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Text("Sign Up",
                        style: TextStyle(
                            fontSize: 28.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text("Create your account to get started",
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Signup successful!')));
                            Navigator.pushNamed(context, '/home');
                          }
                        }),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(fontSize: 14.sp)),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn())),
                          child: Text(" Log In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp)),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
