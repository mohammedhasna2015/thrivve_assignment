import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? localImagePath;
  final VoidCallback onEditTap;
  final String defaultAvatarAsset;
  final String editPhotoAsset;
  final bool isEditable;
  final double size;
  const ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.localImagePath,
    required this.onEditTap,
    required this.defaultAvatarAsset,
    required this.editPhotoAsset,
    this.isEditable = true,
    required this.size,
  });

  ImageProvider _resolveImageProvider() {
    // Priority: local file path > network url > default asset
    if (localImagePath != null && File(localImagePath!).existsSync()) {
      return FileImage(File(localImagePath!));
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(
        imageUrl!,
      );
    } else {
      return AssetImage(defaultAvatarAsset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEditable ? onEditTap : () {},
      child: Stack(
        children: [
          SizedBox(
            width: size.sp,
            height: size.sp,
            child: CircleAvatar(
              radius: 50.sp,
              backgroundImage: _resolveImageProvider(),
              // Optional: add a background color or error handling
              backgroundColor: Colors.grey[200],
            ),
          ),
          if (isEditable)
            Positioned(
              bottom: 10.sp,
              right: 0,
              child: SvgPicture.asset(
                editPhotoAsset,
                width: 18.sp,
                height: 18.sp,
              ),
            ),
        ],
      ),
    );
  }
}
