import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ioasys/app/pages/login/login_form/login_form.dart';
import 'package:ioasys/widgets/custom_app_bar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool logado = false;

  init() async {
    final SharedPreferences prefs = await _prefs;
    logado = prefs.getBool("logado");
    if (logado != null && logado == true) {
      Navigator.pushNamed(context, '/home');
    }
  }

  double heightMain = 300.0;

  setBar(bar) {
    if (bar == true) {
      heightMain = 200.0;
    } else {
      heightMain = 300.0;
    }
    setState(() {});
  }

  bool isLoading = false;

  setLoadding(loadding) {
    setState(() {
      isLoading = loadding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          heightMain = 200.0;
          setState(() {});
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: WillPopScope(
            // ignore: missing_return
            onWillPop: () async {
              heightMain = 200.0;
              setState(() {});
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: LoadingOverlay(
                  color: Colors.grey[900],
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          CustomAppBar(
                            heightMain: heightMain,
                            isBig: true,
                          ),
                        ],
                      ),
                      LoginForm(setBar: setBar, loadding: setLoadding),
                    ],
                  ),
                  isLoading: isLoading),
            )));
  }
}
