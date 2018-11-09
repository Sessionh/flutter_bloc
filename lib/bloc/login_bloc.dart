import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/model/login_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/libs/util.dart';

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
  loginSubmit(vm, context, bloc, mainModel) { //点击登陆
    print(vm.username);
    if (vm.username == '' &&  vm.password == '') {
        vm.modelContent =  '用户名和密码不能为空';
        vm.offStage = false;
        setData(vm);

      } else if (vm.username != '' && vm.password == '') {
        vm.modelContent =  '密码不能为空';
        vm.offStage = false;
        setData(vm);

      } else if (vm.username == '' && vm.password != '') {
        vm.modelContent =  '用户名不能为空';
        vm.offStage = false;
        setData(vm);


      } else {
        vm.shadeHeight = MediaQuery.of(context).size.height;
        vm.shadeWidth = MediaQuery.of(context).size.width;
        vm.radiusLoading = 30.0;
        vm.loginLoadding = true;
        setData(vm);
        
    
        Util.setTimeOut(2, () {
          vm.shadeHeight = 0.0;
          vm.shadeWidth = 0.0;
          vm.radiusLoading = 0.0;
          vm.loginLoadding = false;
          setData(vm);
          mainModel.isLogin = true;
          bloc.setData(mainModel);
          
        
          // Navigator.pushNamed(context, '/home');

        });

      } 
      FocusScope.of(context).requestFocus(new FocusNode());
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
