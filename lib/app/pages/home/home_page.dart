import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioasys/app/components/cards/cards_page.dart';
import 'package:ioasys/widgets/custom_app_bar_search.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    init();
  }

  List colors = [
    Color(0xff79bbca),
    Color(0xff90bb81),
    Color(0xffEa9797),
  ];
  int colorSelect = 0;

  List entrepises = [];

  init() async {
    var response = await controller.init();
    if (response != false) {
      setState(() {
        entrepises = response;
      });
    }
  }

  String filterStr = "";
  bool isLoading = false;

  setFilter(filter) async {
    setState(() {
      filterStr = filter;
      isLoading = true;
    });

    entrepises = [];
    var response = await controller.fetchFilter(filter);
    if (response != false) {
      setState(() {
        entrepises = response;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.grey[900],
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              body: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      CustomAppBarSearch(
                        setFilter: setFilter,
                        filterStr: filterStr,
                        isBig: false,
                        heightMain: 300.0,
                      ),
                      Transform.translate(
                          offset: Offset(350.0, 60),
                          child: GestureDetector(
                              onTap: () async {
                                final SharedPreferences prefs = await _prefs;
                                prefs.setBool("logado", false);

                                Navigator.pushNamed(context, '/login');
                              },
                              child: Icon(Icons.exit_to_app))),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          entrepises.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: entrepises.length,
                                  itemBuilder: (ctx, i) {
                                    colorSelect == 2
                                        ? colorSelect = 0
                                        : colorSelect++;

                                    return Cards(
                                        title: entrepises[i]['enterprise_name'],
                                        image: entrepises[i]['image'],
                                        description: entrepises[i]
                                            ['description'],
                                        id: entrepises[i]['id'],
                                        colorSelect: colorSelect);
                                  },
                                )
                              : Container(
                                  height: 400,
                                  child: Center(
                                      child: Text("NENHUM RESULTADO ENCONTRADO",
                                          style: GoogleFonts.rubik(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400))),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        isLoading: isLoading);
  }
}
