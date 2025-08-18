import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../models/delivery_partner_model.dart';
import '../../providers/lists_provider.dart';
import '../../services/delivery_partner_service.dart';
import '../../widgets/generic/data_view_widget.dart';

class DeliveryPartnerScreen extends HookConsumerWidget {
  const DeliveryPartnerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DataViewWidget(
        provider: deliveryPartnerListProvider,
        dataBuilder: (data) => ListView.separated(
          itemCount: data.length,
          separatorBuilder: (_, _) => const Divider(height: 0),
          itemBuilder: (_, i) => _DeliveryPartnerTile(
            user: data[i],
            onMenuSelect: (val) => _onMenuSelect(context, ref, val, data[i]),
          ),
        ),
      ),
      floatingActionButton: context.fabTo(
        () => context.showAppBottomSheet(
          child: SizedBox(
            height: 300,
            child: Center(child: Text("Add New Partner")),
          ),
          isScrollControlled: true,
        ),
      ),
    );
  }

  void _onMenuSelect(
    BuildContext context,
    WidgetRef ref,
    int value,
    DeliveryPartnerModel user,
  ) {
    switch (value) {
      case 0:
        context.showAppBottomSheet(
          child: SizedBox(
            height: 300,
            child: Center(child: Text("Add New Partner")),
          ),
          isScrollControlled: true,
        );
        break;
      case 1:
        // Update Password
        break;
      case 2:
        String status =
            user.verificationStatus == VerificationStatusEnum.pending
            ? VerificationStatusEnum.verified.name
            : VerificationStatusEnum.pending.name;
        ref
            .read(deliveryPartnerServiceProvider)
            .updateVerificationStatus(uid: user.uid, status: status);
        break;
      case 3:
        context
            .showGenericDialog(
              title: 'Delete Delivery Partner',
              content:
                  'Are you sure you want to delete ${user.name} as delivery partner?',
            )
            .then((res) {
              if (res == true) {
                // ref
                //     .read(cloudFunctionsServiceProvider)
                //     .deleteUser(user.uid, 'delivery');
              }
            });
        break;
    }
  }
}

class _DeliveryPartnerTile extends StatelessWidget {
  final DeliveryPartnerModel user;
  final ValueChanged<int> onMenuSelect;

  const _DeliveryPartnerTile({required this.user, required this.onMenuSelect});

  @override
  Widget build(BuildContext context) {
    final isPending = user.verificationStatus == VerificationStatusEnum.pending;
    final statusColor = isPending ? ColorConstants.primary : Colors.green;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.person,
                  color: ColorConstants.textColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.name,
                            style: typoConfig.textStyle.smallCaptionLabelMedium
                                .copyWith(height: 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(2).copyWith(right: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                user.averageRating?.toStringAsFixed(0) ?? '0',
                                style: typoConfig.textStyle.smallSmall.copyWith(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${user.email}, ${user.mobile}',
                      style: typoConfig.textStyle.smallSmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<int>(
                onSelected: onMenuSelect,
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 0, child: Text('Update Profile')),
                  const PopupMenuItem(value: 1, child: Text('Update Password')),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      isPending ? 'Verify Partner' : 'Unverify Partner',
                    ),
                  ),
                  const PopupMenuItem(value: 3, child: Text('Delete Partner')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isPending ? Icons.pending : Icons.check_circle_rounded,
                    size: 10,
                    color: statusColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    user.verificationStatus.name.toUpperCase(),
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      color: statusColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                'Total Delivery: ${user.totalDelivery}',
                style: typoConfig.textStyle.smallSmall,
              ),
              Text(
                user.createdAt?.formattedDate ?? '--:--',
                style: typoConfig.textStyle.smallSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
