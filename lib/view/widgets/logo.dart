import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "icons/logo/Union.png",
      width: 187,
      height: 180,
    );
  }
}
