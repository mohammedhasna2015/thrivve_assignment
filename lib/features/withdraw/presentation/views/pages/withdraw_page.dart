import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/themes/images.dart';
import 'package:thrivve_assignment/di.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/views/widgets/suggested_amounts_widget.dart';
import 'package:thrivve_assignment/widgets/custom_button_widget.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';
import 'package:thrivve_assignment/widgets/image_loading.dart';

class WithdrawPage extends StatefulWidget {
  static const routeName = '/WithdrawPage';

  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<WithdrawProvider>().getSuggestedAmounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: ThemeColors.white,
      leadingWidth: 60.sp,
      leading: Row(
        children: [
          SizedBox(width: 16.w),
          CircleAvatar(
            backgroundColor: ThemeColors.colorC8C9CC,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: ThemeColors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<WithdrawProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleHeader(),
            SizedBox(height: 20),
            _inputAmounts(provider),
            SizedBox(height: 10),
            _titleMaxAmount(provider),
            SizedBox(height: 20),
            _suggestedAmounts(),
            SizedBox(height: 20),
            _paymentMethod(provider),
            SizedBox(height: 10),
            Spacer(),
            _noteBank(),
            SizedBox(height: 10),
            _divider(),
            SizedBox(height: 10),
            _continueButton(provider),
          ],
        );
      }),
    );
  }

  Widget _titleHeader() {
    return CustomTextWidget(
      title: "Enter the amount you want to withdraw",
      size: 20,
      fontWeight: FontWeight.bold,
      paddingEnd: 24.sp,
    );
  }

  Widget _inputAmounts(WithdrawProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          // SAR icon placeholder
          Images.saudiIcon,
          width: 20.sp,
        ),
        SizedBox(width: 10.sp),
        CustomTextWidget(
          title: 'SAR',
          color: ThemeColors.black.withOpacity(0.7),
          size: 12,
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 100.sp,
          child: TextField(
            controller: provider.inputWithDrawController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(
                  r'^\d*\.?\d{0,2}')), // Allow only numbers and up to 2 decimal places
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "0.00",
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              hintStyle: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
            onChanged: provider.onChangeInput,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _titleMaxAmount(WithdrawProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          title:
              "Your available balance is SAR ${provider.availableBalance.toStringAsFixed(2)}",
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _suggestedAmounts() {
    return Center(
      child: SizedBox(
        height: 45.sp,
        child: SuggestedAmountsWidget(),
      ),
    );
  }

  Widget _continueButton(WithdrawProvider provider) {
    return CustomButton(
      minimumSizeButton: 40.sp,
      padding: EdgeInsetsDirectional.symmetric(vertical: 8.sp),
      text: 'Continue',
      radius: 12.sp,
      onPressed: _onClickContinue,
      enabled: provider.inputWithDrawController.text.isNotEmpty,
      colorButton: ThemeColors.colorB211af,
      colorBorder: ThemeColors.colorB211af,
    );
  }

  void _onClickContinue() {
    getIt<WithdrawProvider>().withdrawRequest();
  }

  Widget _paymentMethod(WithdrawProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          size: 12,
          color: ThemeColors.black,
          title: 'Payment Method',
        ),
        SizedBox(height: 10.sp),
        GestureDetector(
          onTap: provider.openPaymentMethod,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border:
                  Border.all(color: ThemeColors.color7A7A7A.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Visibility(
              visible: provider.paymentEntity != null,
              child: _paymentSelection(provider.paymentEntity),
              replacement: _addPayment(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _noteBank() {
    return Row(
      children: [
        Icon(Icons.info_outline, color: Colors.grey),
        SizedBox(width: 8),
        Flexible(
          child: CustomTextWidget(
            title: "Bank withdrawals may take 12-24 hours to complete.",
            color: ThemeColors.color515151,
            size: 12,
          ),
        ),
      ],
    );
  }

  Widget _paymentSelection(PaymentEntity? paymentEntity) {
    return Row(
      children: [
        ImageLoading(
          imageUrl: paymentEntity?.bankImage ?? '',
          width: 40.sp,
          height: 40.sp,
          borderRadius: 50.sp,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              title: paymentEntity?.bankName ?? '',
              fontWeight: FontWeight.bold,
              size: 15.sp,
              color: ThemeColors.black,
            ),
            SizedBox(height: 5.sp),
            CustomTextWidget(
              title: paymentEntity?.beneficiaryIban ?? '',
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  Widget _addPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40.w,
          height: 40.w,
          child: CircleAvatar(
            backgroundColor: ThemeColors.colorC8C9CC.withOpacity(0.3),
            child: Icon(
              Icons.add_circle_outline_outlined,
              color: ThemeColors.black,
            ),
          ),
        ),
        SizedBox(
          width: 8.sp,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              title: 'Payment method selection',
              color: ThemeColors.black,
              fontWeight: FontWeight.bold,
              size: 15.sp,
            ),
            SizedBox(height: 5.sp),
            CustomTextWidget(
              title: 'Select your payment from sheet',
              color: ThemeColors.black,
              size: 12.sp,
            )
          ],
        )
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 0.2,
      color: ThemeColors.colorC8C9CC,
    );
  }
}
