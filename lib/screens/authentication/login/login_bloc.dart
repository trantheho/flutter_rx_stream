
import 'package:flutter/cupertino.dart';
import 'package:flutter_rx_stream/base/bloc.dart';
import 'package:flutter_rx_stream/generated/l10n.dart';
import 'package:flutter_rx_stream/screens/main/main_app.dart';
import 'package:flutter_rx_stream/utils/app_helper.dart';
import 'package:flutter_rx_stream/utils/app_screen_name.dart';
import 'package:flutter_rx_stream/utils/app_validation.dart';

class LoginBloc extends AppBloc {
  final userNameWarning = BlocDefault<String>();
  final passwordWarning = BlocDefault<String>();
  final loading = BlocDefault<bool>();

  String username = '', password = '';
  BuildContext _context;
  TextEditingController _emailController;
  TextEditingController _passwordController;


  LoginBloc(){
    initLogic();
  }

  void initContext(BuildContext context){
    _context = context;
  }

  void initTextController(TextEditingController email, TextEditingController passwordController){
    _emailController = email;
    _passwordController = passwordController;
  }

  @override
  void dispose() {
    userNameWarning.dispose();
    passwordWarning.dispose();
    loading.dispose();
  }

  @override
  void initLogic() {
  }

  void login(){
    bool emailResult = false;
    emailResult = validEmail();

    if(emailResult){
      loading.push(true);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        loading.push(false);
        AppHelper.navigatePush(_context, AppScreenName.main, MainScreen());
      });
    }
  }

  bool validEmail(){
    if(!Validation.instance.emailValidate(username)){
      userNameWarning.push(S.of(_context).emailValid);
      return false;
    }
    else
      return true;
  }


}