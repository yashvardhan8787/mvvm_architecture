import 'package:flutter/material.dart';
import 'package:mvvm_architecture/res/app_colors.dart';

class RoundButtons extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButtons({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPress, // Disable button press when loading
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
          )
              : Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
