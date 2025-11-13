import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../inputs/text_input.dart';

class AddNutritionWidget extends StatelessWidget {
  final ValueNotifier<Map<String, String>> nutritions;
  const AddNutritionWidget({super.key, required this.nutritions});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nutritions',
              style: context.text.labelMedium?.copyWith(
                color: ColorConstants.textColor,
              ),
            ),
            SizedBox(
              height: 28,
              child: TextButton.icon(
                onPressed: () {
                  final hasEmptyField = nutritions.value.entries.any(
                    (e) => e.key.trim().isEmpty || e.value.trim().isEmpty,
                  );
                  if (hasEmptyField) {
                    context.showSnackbar(
                      'Please fill all existing fields firs',
                    );
                    return;
                  }
                  final updated = Map<String, String>.from(nutritions.value);
                  updated[""] = "";
                  nutritions.value = updated;
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: ColorConstants.primary.withAlpha(30),
                ),
                icon: Icon(Icons.add, size: 14),
                label: Text(
                  'Add',
                  style: context.text.labelSmall?.copyWith(
                    height: 1,
                    fontSize: 10,
                    color: ColorConstants.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        ...nutritions.value.entries.map((entry) {
          final keyController = TextEditingController(text: entry.key);
          final valueController = TextEditingController(text: entry.value);
          return Row(
            spacing: 8,
            children: [
              Expanded(
                child: TextInputWidget(
                  hintText: 'Key',
                  controller: keyController,
                  onChanged: (newKey) {
                    if (newKey == null || newKey.trim().isEmpty) return;
                    final updated = Map<String, String>.from(nutritions.value);
                    final oldValue = updated.remove(entry.key);
                    final lowerKey = newKey.toLowerCase().trim();
                    if (lowerKey.isNotEmpty) {
                      updated[lowerKey] = oldValue ?? "";
                    }
                    nutritions.value = updated;
                  },
                ),
              ),
              Expanded(
                child: TextInputWidget(
                  hintText: 'Value',
                  controller: valueController,
                  onChanged: (newValue) {
                    if (newValue == null || newValue.trim().isEmpty) return;
                    final updated = Map<String, String>.from(nutritions.value);
                    updated[entry.key] = newValue.trim().toLowerCase();
                    nutritions.value = updated;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                onPressed: () {
                  final updated = Map<String, String>.from(nutritions.value);
                  updated.remove(entry.key);
                  nutritions.value = updated;
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
