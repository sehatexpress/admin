import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class OtpInputField extends HookWidget {
  final int length;
  final void Function(String)? onCompleted;

  const OtpInputField({super.key, this.length = 4, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final controllers = useMemoized(
      () => List.generate(length, (_) => TextEditingController()),
      [length],
    );
    final focusNodes = useMemoized(
      () => List.generate(length, (_) => FocusNode()),
      [length],
    );

    useEffect(() {
      return () {
        for (final c in controllers) {
          c.dispose();
        }
        for (final f in focusNodes) {
          f.dispose();
        }
      };
    }, []);

    void onChanged(String value, int index) {
      if (value.isNotEmpty) {
        // Only allow digits
        if (!RegExp(r'^[0-9]$').hasMatch(value)) {
          controllers[index].clear();
          return;
        }

        // Move to next field
        if (index < length - 1) {
          focusNodes[index + 1].requestFocus();
        } else {
          focusNodes[index].unfocus();
        }
      } else {
        // Move back on delete
        if (index > 0) {
          focusNodes[index - 1].requestFocus();
        }
      }

      final code = controllers.map((c) => c.text).join();
      if (code.length == length) {
        onCompleted?.call(code);
      }
    }

    return Row(
      spacing: 8,
      children: List.generate(
        length,
        (index) => Expanded(
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            style: textDecorationTextStyle(
              ColorConstants.textColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(hintText: '0'),
            onChanged: (value) => onChanged(value, index),
          ),
        ),
      ),
    );
  }
}
