import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cards extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int colorSelect;
  final int id;
  const Cards({
    Key key,
    this.colorSelect,
    this.title,
    this.description,
    this.image,
    this.id,
  }) : super(key: key);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<Cards> {
  List colors = [
    Color(0xff79bbca),
    Color(0xff90bb81),
    Color(0xffEa9797),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: GestureDetector(
            onTap: () async {
              Navigator.pushNamed(
                context,
                '/entrepise',
                arguments: {
                  "title": widget.title,
                  "description": widget.description,
                  "image":
                      "https://source.unsplash.com/random/200x200?sig=${widget.id}",
                  "color": widget.colorSelect,
                },
              );
            },
            child: Container(
                height: MediaQuery.of(context).size.height * .23,
                width: MediaQuery.of(context).size.width * .95,
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[widget.colorSelect],
                      borderRadius: BorderRadius.circular(10),
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
                              "https://source.unsplash.com/random/200x200?sig=${widget.id}",
                              height: 75.0,
                              width: 75.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
