import 'package:flutter/material.dart';

class Over extends StatelessWidget {
  final String img;
  const Over({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 240.0,
      top: 45,
      child: Image.asset(
        img,
        height: 235.0,
        width: 235.0,
      ),
    );
  }
}
