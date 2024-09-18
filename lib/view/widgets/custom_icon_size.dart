import 'package:flutter/material.dart';

class SizedIcon extends StatelessWidget {
  final String name;
  final Color? color;
  const SizedIcon({super.key, required this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      color: color ?? const Color(0xff272727),
      width: 26,
      height: 26,
    );
  }
}
