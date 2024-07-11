import 'dart:ui';

import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {
  const Backdrop(this.inFront, this.behind, {Key? key, this.blur = 10}) : super(key: key);

  final Widget behind;
  final Widget inFront;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        behind,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: inFront,
          ),
        ),
      ],
    );
  }
}
