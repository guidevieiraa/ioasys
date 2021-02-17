import 'package:flutter/material.dart';
import 'package:ioasys/app/components/over/over.dart';

class CustomAppBarSearch extends StatefulWidget {
  final String title;
  final bool isBig;
  final heightMain;
  final Function setFilter;
  final String filterStr;

  const CustomAppBarSearch(
      {Key key,
      this.title,
      this.filterStr,
      this.heightMain,
      this.isBig,
      this.setFilter})
      : super(key: key);

  @override
  _CustomAppBarSearchState createState() => _CustomAppBarSearchState();
}

class _CustomAppBarSearchState extends State<CustomAppBarSearch> {
  FocusNode textSecondFocusNode = new FocusNode();
  final txt2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    txt2.value = txt2.value.copyWith(
      text: widget.filterStr,
      selection: TextSelection(
          baseOffset: widget.filterStr.length,
          extentOffset: widget.filterStr.length),
      composing: TextRange.empty,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            height: 250,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: widget.isBig
                      ? _AppBarClipper(childHeight: 100, isBig: false)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.only(top: 48),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 220,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(40.0, 0),
                  child: Image.asset(
                    "images/over_1.png",
                    height: 275.0,
                    width: 275.0,
                  ),
                ),
                Positioned(
                  left: 250.0,
                  bottom: 50,
                  child: Image.asset(
                    "images/over_2.png",
                    height: 235.0,
                    width: 235.0,
                  ),
                ),
                Positioned(
                  left: 180.0,
                  top: 45,
                  child: Image.asset(
                    "images/over_3.png",
                    height: 235.0,
                    width: 235.0,
                  ),
                ),
                Over(
                  img: "images/over_4.png",
                ),
                Center(
                    child: Transform.translate(
                  offset: Offset(0.0, 90),
                  child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          elevation: 10.0,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.search),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: TextField(
                                      focusNode: textSecondFocusNode,
                                      controller: txt2,
                                      onChanged: (text) {
                                        //Todo
                                        widget.setFilter(text);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            5.0, 0.0, 0.0, 0.0),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )),
              ],
            )));
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
