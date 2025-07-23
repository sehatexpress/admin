import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../providers/lists_provider.dart';
import '../generic/loader_widget.dart';
import 'text_input.dart';

class SelectCategoryList extends HookConsumerWidget {
  final List<String> addedList;
  final ValueNotifier<List<String>> selected;
  final bool single;
  final bool isAdd;

  const SelectCategoryList({
    super.key,
    this.addedList = const [],
    required this.selected,
    this.single = false,
    this.isAdd = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesNotifier = ref.watch(categoriesListProvider);
    final controller = useTextEditingController();
    final lists = useState<List<String>>([]);

    void handleSelect(String val) {
      if (single) {
        selected.value = [val];
      } else {
        final current = List<String>.from(selected.value);
        if (current.contains(val)) {
          current.remove(val);
        } else {
          current.add(val);
        }
        selected.value = current;
      }
    }

    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Categories', style: context.text.bodyMedium),
            if (isAdd)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                ),
                child: TextInput(
                  hintText: 'New Category',
                  controller: controller,
                  onSubmit: (x) {
                    final trimmed = x?.trim();
                    if (trimmed != null &&
                        trimmed.isNotEmpty &&
                        !lists.value.contains(trimmed)) {
                      lists.value = [...lists.value, trimmed];
                    }
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(minHeight: 50, maxHeight: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: categoriesNotifier.when(
            data: (data) {
              // Future.microtask(() {
              //   final updated = {...addedList, ...data}.toList();
              //   lists.value = updated;
              // });
              return SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: data.map((val) {
                    final name = val.name.toLowerCase();
                    final isSelected = selected.value.contains(name);
                    return GestureDetector(
                      onTap: () => handleSelect(name),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          Expanded(
                            child: Text(
                              name.capitalize,
                              style: context.text.labelSmall?.copyWith(
                                height: 1,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text('Error: ${error.toString()}'),
            ),
            loading: () => Center(
              child: LoaderWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
