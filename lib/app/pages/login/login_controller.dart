import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'Login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  int value = 0;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @action
  login(String email, String senha) async {
    final SharedPreferences prefs = await _prefs;
    var dio = Dio();
    dio.options.headers['access-token'] = '';
    dio.options.headers['client'] = '';
    dio.options.headers['uid'] = '';

    var payload = {"email": email, "password": senha};
    try {
      Response response = await dio.post(
          'https://empresas.ioasys.com.br/api/v1/users/auth/sign_in',
          data: payload);
      prefs.setString("access-token", response.headers['access-token'][0]);
      prefs.setString("uid", response.headers['uid'][0]);
      prefs.setString("client", response.headers['client'][0]);
      prefs.setBool("logado", true);
      return true;
    } catch (e) {
      return false;
    }
  }
}
