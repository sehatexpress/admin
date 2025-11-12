import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';

import 'loader_widget.dart';

class DataViewWidget<T> extends ConsumerWidget {
  final Refreshable<AsyncValue<T>> provider;
  final Widget Function(T data) dataBuilder;
  final Widget? loading;

  const DataViewWidget({
    super.key,
    required this.provider,
    required this.dataBuilder,
    this.loading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(provider);
    return value.when(
      data: dataBuilder,
      loading: () => loading ?? const Center(child: LoaderWidget()),
      error: (error, stackTrace) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${error.toString()}', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.refresh(provider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
