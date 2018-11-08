import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/model/login_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class LoginBloc implements BlocBase {
  PublishSubject<LoginModel> _loginController = PublishSubject<LoginModel>();

  Sink<LoginModel> get _inLoginList => _loginController.sink;

  Stream<LoginModel> get outLoginList => _loginController.stream;
   

  @override
  void dispose() {
    _loginController.close();
  }
  Icon iconType (int iconTypePassword) {
      if (iconTypePassword == 0) {
        return Icon(Icons.visibility_off,color: Colors.black54);
      } else {
        return Icon(Icons.remove_red_eye,color: Colors.black54);
      }
      
  }
  setData(vm){

    LoginModel _main =  LoginModel(
      type: vm.type,
      login: vm.login,
      signIn: vm.signIn,
      text: vm.text,
      isDarkTheme: vm.isDarkTheme,
      username: vm.username,
      password: vm.password,
      inputTop: vm.inputTop,
      iconTypePassword: vm.iconTypePassword,
      obscureText: vm.obscureText,
      loginLoadding: vm.loginLoadding,
      shadeHeight: vm.shadeHeight,
      shadeWidth: vm.shadeWidth,
      radiusLoading: vm.radiusLoading,
      offStage: vm.offStage,
      modelContent: vm.modelContent,
      );
    
        _inLoginList.add(_main);

  }
  
  
 
  
  
  
}
