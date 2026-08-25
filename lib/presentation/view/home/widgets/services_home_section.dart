import 'package:control_loop_test/presentation/view/widgets/service_category_item.dart';
import 'package:control_loop_test/res/constants/demo_data.dart';
import 'package:control_loop_test/res/routes/routes.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class ServicesHomeSection extends StatelessWidget {
  const ServicesHomeSection({super.key});

  void _openCategory(BuildContext context, String title) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(
      context,
      RouteNames.serviceCategoryScreen,
      arguments: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    const services = DemoData.services;
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: services.take(4).map((item) {
            return ServiceCategoryItem(
              item: item,
              onTap: () => _openCategory(context, item.title),
            );
          }).toList(),
        ),
        SizedBox(height: 20.rh(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: services.skip(4).map((item) {
            return ServiceCategoryItem(
              item: item,
              onTap: () => _openCategory(context, item.title),
            );
          }).toList(),
        ),
      ],
    );
  }
}
