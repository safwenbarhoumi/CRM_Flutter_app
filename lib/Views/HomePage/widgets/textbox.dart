import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardAppearance: Brightness.dark,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.search,
          color: AppColors.black,
        ),
        hintText: AppText.searchDoctor,
        hintStyle: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AppColors.textGrey),
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
