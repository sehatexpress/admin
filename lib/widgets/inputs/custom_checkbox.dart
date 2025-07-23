import 'package:flutter/material.dart';

import '../../config/extensions.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final Function() onTap;
  const CustomCheckbox({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: value == true
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: value
                ? const Icon(
                    Icons.check,
                    size: 11,
                    color: Colors.white,
                  )
                : const SizedBox(),
          ),
          Text(
            title,
            style: context.text.labelSmall?.copyWith(
              height: 1,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
