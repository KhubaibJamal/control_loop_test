import 'package:control_loop_test/data/models/service_models.dart';
import 'package:control_loop_test/res/constants/constants.dart';
import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCategoryItem extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback? onTap;

  const ServiceCategoryItem({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70.rw(context),
        child: Column(
          children: [
            Container(
              height: 56.rh(context),
              width: 56.rw(context),
              decoration: const BoxDecoration(
                color: CustomColors.serviceChipBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: item.useImage
                  ? Image.asset(
                      item.icon,
                      width: 28.rw(context),
                      height: 28.rh(context),
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      item.icon,
                      width: 28.rw(context),
                      height: 28.rh(context),
                    ),
            ),
            SizedBox(height: 8.rh(context)),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.rf(context),
                color: CustomColors.primaryTextColor,
                fontFamily: Constants.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
