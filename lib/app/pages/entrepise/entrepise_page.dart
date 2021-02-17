import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntrepisePage extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int color;

  const EntrepisePage(
      {Key key, this.title, this.description, this.image, this.color})
      : super(key: key);

  @override
  _EntrepisesPageState createState() => _EntrepisesPageState();
}

class _EntrepisesPageState extends State<EntrepisePage> {
  List colors = [
    Color(0xff79bbca),
    Color(0xff90bb81),
    Color(0xffEa9797),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 17.0,
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Icon(Icons.arrow_back, color: Colors.red))),
        ),
        elevation: 0,
        title: Text(
          widget.title,
          style: GoogleFonts.rubik(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
        ),
      ),
      body: Column(
        children: <Widget>[
          Banner(colors: colors, widget: widget),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key key,
    @required this.colors,
    @required this.widget,
  }) : super(key: key);

  final List colors;
  final EntrepisePage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .23,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: colors[widget.color],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: Hero(
                  tag: widget.title,
                  child: Image.network(
                    widget.image,
                    height: 75.0,
                    width: 75.0,
                  ),
                )),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: GoogleFonts.rubik(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
