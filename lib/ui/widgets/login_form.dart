import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/login_bloc.dart';
import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/model/login_model.dart';


class LoginForm extends StatelessWidget{
  final formKey;
  LoginForm(this.formKey);
  
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return StreamBuilder(
       stream: loginBloc.outLoginList,
       initialData: LoginModel.initial(),
       builder:  (BuildContext context, AsyncSnapshot<LoginModel> snapshot){
         var vm = snapshot.data;
         
         return                 
         Form(
              key: formKey,
              onChanged: () {               
                
              },
              autovalidate: false, //开启验证input
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      new Container(
                      child: new Icon(Icons.person, color: Colors.black54),
                      width: 60.0,
                    ),
                    new Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: '用户名', border: InputBorder.none),
                          obscureText: false,
                          onSaved: (val) {
                              print(val);
                              vm.username = val;
                              print('33');
                              loginBloc.setData(vm);

                          },
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          enabled: vm.enabled, //是否允许用户输入
                          style: TextStyle(
                              color: vm.isDarkTheme
                                  ? Colors.white
                                  : Colors.black),
                        ),
                    )

                    ]
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 25.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.lightBlue.shade900),
                      ),
                    ),
                  ),
                  
                  Row(
                    children: <Widget>[
                      new Container(
                        child: new Icon(Icons.https, color: Colors.black54),
                        width: 60.0,
                      ),
                      new Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: '密码',
                            border: InputBorder.none
                          ),
                          focusNode:FocusNode(),
                          enabled: vm.enabled, //是否允许用户输入
                          onSaved: (val) {                             
                              vm.password = val;
                              loginBloc.setData(vm);
                          },
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText:  vm.obscureText, // 是否可见
                          style: TextStyle(
                              color: vm.isDarkTheme
                                  ? Colors.white
                                  : Colors.black
                          ),
                        ),
                      ),
                      new Container(
                        child: new IconButton(
                          icon: loginBloc.iconType(vm.iconTypePassword),
                          onPressed: () {
                            if (vm.iconTypePassword == 0) {
                              vm.iconTypePassword = 1;
                              vm.obscureText = false;
                            
                            } else {
                              vm.iconTypePassword = 0;
                              vm.obscureText = true;
                            }
                             loginBloc.setData(vm);

                          },

                        ),
                        
                        width: 60.0,
                      ),

                    ]
                  ),
                
                ],
              ),
            );
      }
  );
  }


}

class LoginForms extends StatelessWidget{
  final formKey;
  final LoginModel vm;
  LoginForms(this.formKey, this.vm);
  @override
  Widget build(BuildContext context){
     final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return Form(
              key: formKey,
              onChanged: () {               
                
              },
              autovalidate: false, //开启验证input
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      new Container(
                      child: new Icon(Icons.person, color: Colors.black54),
                      width: 60.0,
                    ),
                    new Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: '用户名', border: InputBorder.none),
                          obscureText: false,
                          onSaved: (val) {
                              vm.username = val;
                              loginBloc.setData(vm);

                          },
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          style: TextStyle(
                              color: vm.isDarkTheme
                                  ? Colors.white
                                  : Colors.black),
                        ),
                    )

                    ]
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 25.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.lightBlue.shade900),
                      ),
                    ),
                  ),
                  
                  Row(
                    children: <Widget>[
                      new Container(
                        child: new Icon(Icons.https, color: Colors.black54),
                        width: 60.0,
                      ),
                      new Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: '密码',
                            border: InputBorder.none
                          ),
                          enabled: false,
                          onSaved: (val) {
                              vm.password = val;
                              loginBloc.setData(vm);
                          },
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          style: TextStyle(
                              color: vm.isDarkTheme
                                  ? Colors.white
                                  : Colors.black
                          ),
                        ),
                      ),
                      new Container(
                        child: new IconButton(
                          icon: loginBloc.iconType(vm.iconTypePassword),
                          onPressed: () {
                            if (vm.iconTypePassword == 0) {
                              vm.iconTypePassword = 1;
                              vm.obscureText = false;
                            
                            } else {
                              vm.iconTypePassword = 0;
                              vm.obscureText = true;
                            }
                            loginBloc.setData(vm);

                          },

                        ),
                        
                        width: 60.0,
                      ),

                    ]
                  ),
                
                ],
              ),
            );

  }


}