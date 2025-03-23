import 'package:flutter/material.dart';

class CompleteProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Your Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 20),
              buildTextField("Full Name"),
              buildTextField("Last Name"),
              buildTextField("Speciality"),
              buildTextField("Description", maxLines: 3),
              buildTextField("Location"),
              buildTextField("Number of Experience",
                  keyboardType: TextInputType.number),
              buildTextField("Number of Patients",
                  keyboardType: TextInputType.number),
              buildTextField("Number of Ratings",
                  keyboardType: TextInputType.number),
              buildDropdownField("Gender", ["Male", "Female", "Other"]),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Profile Completed")),
                    );
                  }
                },
                child: Text("Complete Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: options.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {},
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }
}
