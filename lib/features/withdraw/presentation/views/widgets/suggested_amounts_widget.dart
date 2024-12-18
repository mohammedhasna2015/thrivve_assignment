import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';

class SuggestedAmountsWidget extends StatelessWidget {
  const SuggestedAmountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WithdrawProvider>(builder: (context, provider, child) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _itemSuggested(_, index, provider),
        separatorBuilder: separatorBuilder,
        itemCount: provider.amounts.length,
      );
    });
  }

  Widget _itemSuggested(
      BuildContext context, int index, WithdrawProvider provider) {
    final amount = provider.amounts[index];
    final isSelected = provider.indexSelectionSuggested == index;
    return GestureDetector(
      onTap: () => provider.setIndexSelectionSuggested(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 8.sp, vertical: 12.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: ThemeColors.color515151.withOpacity(0.3),
              border: isSelected
                  ? Border.all(color: ThemeColors.colorB211af)
                  : null,
            ),
            child: CustomTextWidget(
              title: "$amount SAR",
              color: ThemeColors.black,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return SizedBox(width: 10.sp);
  }
}
