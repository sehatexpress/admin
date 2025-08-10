// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../generic/data_view_widget.dart';

// class SelectWidget<T> extends ConsumerWidget {
//   final T? value;
//   final void Function(T?)? onChanged;
//   final Refreshable<AsyncValue<T>> provider;
//   final String label;
//   final String? Function(T?)? validator;
//   final DropdownMenuItem<T> Function(T item) itemBuilder;
//   final bool required;
//   const SelectWidget({
//     super.key,
//     required this.provider,
//     required this.label,
//     required this.itemBuilder,
//     this.value,
//     this.onChanged,
//     this.validator,
//     this.required = true,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return DataViewWidget(
//       provider: provider,
//       dataBuilder: (list) {
//         return DropdownButtonFormField<T>(
//           value: value,
//           items: list.map(itemBuilder).toList(),
//           onChanged: onChanged,
//           decoration: InputDecoration(labelText: label),
//           validator: required
//               ? (x) => x == null || x.isEmpty ? '' : null
//               : null,
//         );
//       },
//     );
//   }
// }
