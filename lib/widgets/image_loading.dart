import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';

class ImageLoading extends StatelessWidget {
  const ImageLoading({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.child,
    this.loadingSize = 10,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.placeHolderWidget,
    this.colorBackgroundErrorWidget = ThemeColors.white,
    this.colorWidget,
    this.showBorderForPlaceHolder = false,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;
  final double loadingSize;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;
  final BoxFit? fit;
  final Color? colorWidget;
  final Color? colorBackgroundErrorWidget;
  final bool showBorderForPlaceHolder;
  // Method to determine if the image is an SVG
  bool _isSvgImage(String url) {
    if (url.isEmpty || url.contains('null')) return false;

    // Check file extension
    final extension = url.split('.').last.toLowerCase();
    if (extension == 'svg') return true;

    // Check MIME type or content type (if available in the URL)
    if (url.contains('.svg')) return true;

    // Additional checks can be added here if needed
    return false;
  }

  // Common placeholder widget
  Widget _buildPlaceholderWidget() {
    return placeHolderWidget ??
        SizedBox(
          height: height ?? 0 * 0.2,
          width: width ?? 0 * 0.2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: ThemeColors.primaryColor,
              strokeWidth: 2.sp,
            ),
          ),
        );
  }

  // Wrapper for consistent border radius
  Widget _wrapWithBorderRadius(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Handle empty or null URLs
    if (imageUrl.isEmpty || imageUrl.contains('null')) {
      return Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: colorBackgroundErrorWidget,
        ),
        child: placeHolderWidget,
      );
    }

    final processedUrl = imageUrl;

    // Determine image type and render accordingly
    return _isSvgImage(imageUrl)
        ? _wrapWithBorderRadius(
            SizedBox(
              height: height,
              width: width,
              child: SvgPicture.network(
                processedUrl,
                fit: fit ?? BoxFit.contain,
                width: width,
                height: height,
                color: colorWidget,
                placeholderBuilder: (context) =>
                    placeHolderWidget ?? _buildPlaceholderWidget(),
              ),
            ),
          )
        : _wrapWithBorderRadius(
            Image.network(
              processedUrl,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              color: colorWidget,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image has loaded
                }
                return placeHolderWidget ?? _buildPlaceholderWidget();
              },
              errorBuilder: (context, error, __) =>
                  errorWidget ??
                  const Icon(
                    Icons.image,
                    color: ThemeColors.red,
                  ),
            ),
          );
  }
}
