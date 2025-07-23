import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';

class TabBarWidget extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  final bool isScrollable;
  const TabBarWidget({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      controller: controller,
      padding: EdgeInsets.symmetric(horizontal: 16),
      labelColor: ColorConstants.primary,
      physics: const BouncingScrollPhysics(),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        color: ColorConstants.primary.withAlpha(51),
        borderRadius: BorderRadius.circular(20),
      ),
      splashBorderRadius: BorderRadius.circular(20),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      tabAlignment: isScrollable ? TabAlignment.start : null,
      tabs: tabs.map((e) => Tab(height: 36, text: e.capitalize)).toList(),
    );
  }
}
