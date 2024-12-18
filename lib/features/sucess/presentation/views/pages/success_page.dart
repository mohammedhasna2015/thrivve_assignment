import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/features/sucess/presentation/views/arguments/success_page_arguments.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';

class SuccessPage extends StatefulWidget {
  static const routeName = '/SuccessPage';
  const SuccessPage({
    super.key,
    required this.arguments,
  });
  final SuccessPageArguments? arguments;
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _iconAnimation,
            builder: (context, child) {
              return Container(
                width: 100 * _iconAnimation.value,
                height: 100 * _iconAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50 * _iconAnimation.value,
                ),
              );
            },
          ),
          SizedBox(height: 24.sp),
          AnimatedBuilder(
            animation: _textAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _textAnimation.value,
                child: CustomTextWidget(
                  paddingStart: 16.w,
                  paddingEnd: 16.w,
                  title: widget.arguments?.title ?? '',
                  size: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.black,
                ),
              );
            },
          ),
          SizedBox(height: 16.sp),
          CustomTextWidget(
            title: widget.arguments?.body ?? '',
            textAlign: TextAlign.center,
            paddingStart: 16.w,
            paddingEnd: 16.w,
            color: ThemeColors.color7A7A7A,
          ),
        ],
      ),
    );
  }
}
