import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ProfileEntity.dart';
import '../cubit/ProfileCubit.dart';
import '../cubit/ProfileState.dart';

class ProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _actualJobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errMessage)));
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileSuccess) {
              final profileData = state.profileData;
              _fullNameController.text = profileData.fullName;
              _phoneNumberController.text = profileData.phoneNumber;
              _emailController.text = profileData.email;
              _actualJobController.text = profileData.actualJob;
              _addressController.text = profileData.address;

              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profileData.photo),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: _actualJobController,
                      decoration:
                          const InputDecoration(labelText: 'Current Job'),
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedProfile = ProfileEntity(
                            fullName: _fullNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            email: _emailController.text,
                            photo: profileData.photo,
                            actualJob: _actualJobController.text,
                            address: _addressController.text,
                            darkMode: profileData.darkMode,
                          );
                          context
                              .read<ProfileCubit>()
                              .updateProfile(updatedProfile);
                        }
                      },
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              );
            }
            return Center(child: const Text('Failed to load profile.'));
          },
        ),
      ),
    );
  }
}
