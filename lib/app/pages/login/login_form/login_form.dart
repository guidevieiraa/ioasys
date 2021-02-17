import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ioasys/app/pages/login/login_controller.dart';
import 'package:ioasys/app/pages/login/login_form/login_form_model.dart';
import 'package:ioasys/widgets/custom_textfield.dart';
import 'package:ioasys/widgets/screen.dart';
import 'package:ioasys/widgets/shadow_button.dart';

class LoginForm extends StatefulWidget {
  final Function setBar;
  final Function loadding;
  const LoginForm({Key key, this.setBar, this.loadding}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ModularState<LoginForm, LoginController> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _focus2.addListener(_onFocusChange2);
  }

  FocusNode _focus = new FocusNode();
  FocusNode _focus2 = new FocusNode();

  void _onFocusChange() {
    widget.setBar(_focus.hasFocus);
  }

  void _onFocusChange2() {
    widget.setBar(_focus2.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 42,
        left: 42,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Email"),
                MyTextFormField(
                  focus: _focus,
                  isEmail: true,
                  validator: (String value) {
                    return "";
                  },
                  onSaved: (String value) {
                    model.email = value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Senha"),
                MyTextFormField(
                  focus: _focus2,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  isPassword: passwordVisible,
                  validator: (String value) {
                    return "Credencias incorretas";
                  },
                  onSaved: (String value) {
                    model.password = value;
                  },
                ),
              ],
            ),
            Container(
              height: 52,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
              child: ShadowButton(
                borderRadius: 12,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  color: Color(0xffE01E69),
                  onPressed: () async {
                    widget.loadding(true);
                    _formKey.currentState.save();
                    var res = await controller.login(
                        this.model.email, this.model.password);

                    if (res == false) {
                      _formKey.currentState.validate();
                    } else {
                      Navigator.pushNamed(context, '/home');
                    }
                    widget.loadding(false);
                  },
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
