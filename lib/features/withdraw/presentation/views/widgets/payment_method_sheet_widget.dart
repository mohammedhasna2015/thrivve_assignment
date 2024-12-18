import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/themes/images.dart';
import 'package:thrivve_assignment/core/utils/navigation_service.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/widgets/constrained_scroll_view_without_intrinsic_height.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';
import 'package:thrivve_assignment/widgets/image_loading.dart';

class PaymentMethodSheetWidget extends StatelessWidget {
  const PaymentMethodSheetWidget({
    Key? key,
    required this.listPaymentMethods,
    this.selectedPayment,
  }) : super(key: key);
  final List<PaymentEntity> listPaymentMethods;
  final PaymentEntity? selectedPayment;
  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Widget _builder() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.sp),
          topRight: Radius.circular(12.sp),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _closeAndTitleWidget(),
            SizedBox(height: 10.sp),
            _divider(),
            SizedBox(height: 10.sp),
            _listPaymentMethod(),
            SizedBox(height: 10.sp),
            _addPayment(),
            SizedBox(height: 48.sp),
          ],
        ),
      ),
    );
  }

  Widget _closeAndTitleWidget() {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        top: 7.sp,
        bottom: 7.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          CustomTextWidget(
            title: 'Choose payment method',
            size: 17,
            color: ThemeColors.black,
            fontWeight: FontWeight.w700,
          ),
          GestureDetector(
            onTap: _onClickClose,
            child: SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: CircleAvatar(
                backgroundColor: ThemeColors.colorC8C9CC.withOpacity(0.3),
                child: Icon(
                  Icons.close_outlined,
                  color: ThemeColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 0.2,
      color: ThemeColors.colorC8C9CC,
    );
  }

  Widget _listPaymentMethod() {
    return ConstrainedScrollViewWithOutIntrinsicHeight(
      maxHeight: 400,
      child: Container(
        color: ThemeColors.white,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(
            top: 16.sp,
            bottom: 16.sp,
            start: 16.w,
            end: 16.w,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: listPaymentMethods.length ?? 0,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = listPaymentMethods[index];
    final isSelected = item == selectedPayment;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onClickPayment(item),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _image(item),
              SizedBox(width: 10),
              _infoPayment(item),
            ],
          ),
          _radioSelection(isSelected),
        ],
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return SizedBox(height: 20.sp);
  }

  void _onClickPayment(PaymentEntity item) {
    NavigationService.instance.goBack(result: item);
  }

  void _onClickClose() {
    NavigationService.instance.goBack();
  }

  Widget _image(PaymentEntity item) {
    return ImageLoading(
      imageUrl: item.bankImage ?? '',
      width: 40.sp,
      height: 40.sp,
      borderRadius: 50.sp,
    );
  }

  Widget _infoPayment(PaymentEntity item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomTextWidget(
              title: item.bankName ?? '',
              fontWeight: FontWeight.bold,
              size: 15.sp,
              color: ThemeColors.black,
            ),
            if ((item.status ?? '').isNotEmpty)
              Container(
                margin: EdgeInsetsDirectional.only(
                  start: 10.sp,
                ),
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 10.sp,
                  vertical: 3.sp,
                ),
                decoration: BoxDecoration(
                  color: ThemeColors.primaryColor,
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: CustomTextWidget(
                  title: item.status ?? '',
                  height: 1.3,
                  color: ThemeColors.white,
                  size: 10,
                ),
              )
          ],
        ),
        SizedBox(height: 5.sp),
        CustomTextWidget(
          title: item.beneficiaryIban ?? '',
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _radioSelection(bool isSelected) {
    return Image.asset(
      isSelected ? Images.radioSelected : Images.radioNotSelected,
      width: 30.sp,
      height: 30.sp,
    );
  }

  Widget _addPayment() {
    return GestureDetector(
      onTap: _onClickAddPayment,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: CircleAvatar(
                backgroundColor: ThemeColors.colorC8C9CC.withOpacity(0.3),
                child: Icon(
                  Icons.add_circle_outline_outlined,
                  color: ThemeColors.black,
                ),
              ),
            ),
            SizedBox(width: 10.sp),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  title: 'Payment method ',
                  color: ThemeColors.black,
                  fontWeight: FontWeight.bold,
                  size: 15.sp,
                ),
                SizedBox(height: 5.sp),
                CustomTextWidget(
                  title: 'Add new payment Method',
                  color: ThemeColors.black,
                  size: 12.sp,
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: ThemeColors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickAddPayment() {}
}
