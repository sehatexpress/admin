import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onPressed;

  const SubmitButton({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Text(
          title,
          style: context.text.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        icon: icon != null ? Icon(icon, color: Colors.white) : null,
        style: TextButton.styleFrom(
          backgroundColor: ColorConstants.primary,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
