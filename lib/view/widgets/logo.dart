import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "icons/logo/Union (3).png",
      width: 187.sp,
      height: 180.sp,
    );
  }
}
