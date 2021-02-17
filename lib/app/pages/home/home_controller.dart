import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @action
  init() async {
    final SharedPreferences prefs = await _prefs;
    var dio = Dio();
    dio.options.headers['content-type'] = "application/json; charset=utf-8";
    dio.options.headers['access-token'] = prefs.getString("access-token");
    dio.options.headers['client'] = prefs.getString("client");
    dio.options.headers['uid'] = prefs.getString("uid");
    try {
      Response response =
          await dio.get('https://empresas.ioasys.com.br/api/v1/enterprises');

      return response.data['enterprises'];
    } catch (e) {
      return false;
    }
  }

  @action
  fetchFilter(filter) async {
    final SharedPreferences prefs = await _prefs;
    var dio = Dio();
    dio.options.headers['content-type'] = "application/json; charset=utf-8";
    dio.options.headers['access-token'] = prefs.getString("access-token");
    dio.options.headers['client'] = prefs.getString("client");
    dio.options.headers['uid'] = prefs.getString("uid");
    try {
      Response response = await dio.get(
          'https://empresas.ioasys.com.br/api/v1/enterprises?name=$filter');

      return response.data['enterprises'];
    } catch (e) {
      return false;
    }
  }
}
