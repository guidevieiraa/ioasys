import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isBig;
  final heightMain;

  const CustomAppBar({
    Key key,
    this.title,
    this.heightMain,
    this.isBig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper:
              isBig ? _AppBarClipper(childHeight: 100, isBig: false) : null,
          child: Container(
            padding: const EdgeInsets.only(top: 48),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: heightMain,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
        ),
        Positioned(
            bottom: heightMain != 200.0 ? 100 : 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/logo_home.png"),
                    ),
                  ),
                ),
                heightMain != 200.0
                    ? Text("Seja bem vindo ao empresas!",
                        style: TextStyle(color: Colors.white, fontSize: 23))
                    : Container()
              ],
            )),
      ],
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  final bool isBig;
  final double childHeight;

  _AppBarClipper({@required this.isBig, @required this.childHeight});

  @override
  Path getClip(Size size) {
    double height = isBig ? size.height - childHeight : size.height;
    Path path = Path();

    path.moveTo(0, height - 40);
    path.quadraticBezierTo(size.width / 2, height, size.width, height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
