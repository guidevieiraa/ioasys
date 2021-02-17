import 'package:ioasys/app/pages/entrepise/entrepise_page.dart';
import 'package:ioasys/app/pages/home/home_controller.dart';
import 'package:ioasys/app/pages/home/home_page.dart';
import 'package:ioasys/app/pages/login/login_controller.dart';
import 'package:ioasys/app/pages/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:ioasys/app/app_widget.dart';
import 'package:ioasys/widgets/splash.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $HomeController,
        $LoginController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => Splash()),
        ModularRouter("/login", child: (_, args) => LoginPage()),
        ModularRouter("/home", child: (_, args) => HomePage()),
        ModularRouter("/entrepise",
            child: (_, args) => EntrepisePage(
                  color: args.data['color'],
                  image: args.data['image'],
                  description: args.data['description'],
                  title: args.data['title'],
                )),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
