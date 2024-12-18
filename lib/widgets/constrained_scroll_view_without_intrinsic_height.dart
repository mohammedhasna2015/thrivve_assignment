import 'package:flutter/material.dart';

class ConstrainedScrollViewWithOutIntrinsicHeight extends StatelessWidget {
  const ConstrainedScrollViewWithOutIntrinsicHeight({
    this.child,
    required this.maxHeight,
    this.controller,
    Key? key,
  }) : super(key: key);
  final Widget? child;
  final double maxHeight;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        controller: controller,
        child: child,
      ),
    );
  }
}
