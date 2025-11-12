import 'package:admin/config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../providers/lists_provider.dart';
import '../../widgets/generic/data_view_widget.dart';

class CustomerQuriesScreen extends ConsumerWidget {
  const CustomerQuriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: customerQueriesListProvider,
      dataBuilder: (queries) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: queries.length,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          separatorBuilder: (context, i) => SizedBox(height: 10.0),
          itemBuilder: (context, i) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${queries[i].name},  ${queries[i].mobile}',
                        style: context.text.bodyMedium,
                      ),
                    ),
                    SizedBox(width: 4.0),
                  ],
                ),
                Text(
                  queries[i].message,
                  style: context.text.bodyMedium?.copyWith(
                    color: ColorConstants.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
