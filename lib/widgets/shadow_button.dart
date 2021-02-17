import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double borderRadius;

  ShadowButton({@required this.child, @required this.height, this.borderRadius})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: this.child,
    );
  }
}
