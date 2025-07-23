import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/utils.dart';

class TimeInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  const TimeInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      keyboardType: TextInputType.text,
      style: textDecorationTextStyle(Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorStyle: const TextStyle(height: 0),
      ),
      validator: (x) => x != null && x.isNotEmpty ? null : '',
      onTap: () async {
        final time = await _pickTime(context);
        if (time != null) {
          final finalTime = DateTime(
            _dateTime.year,
            _dateTime.month,
            _dateTime.day,
            time.hour,
            time.minute,
          );
          var x = DateFormat('HH:mm:ss').format(finalTime);
          onChanged(x);
        }
      },
    );
  }
}

DateTime _dateTime = DateTime.now();
Future<TimeOfDay?> _pickTime(BuildContext context) => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _dateTime.hour,
        minute: _dateTime.minute,
      ),
    );
