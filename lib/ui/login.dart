import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/bloc/main_bloc.dart';
import 'package:flutter_bloc/model/main_model.dart';
import 'package:flutter_bloc/bloc/login_bloc.dart';
import 'package:flutter_bloc/model/login_model.dart';
import 'package:flutter_bloc/common_widgets/Model.dart';
import 'package:flutter_bloc/ui/widgets/login_type.dart';

class Login extends StatelessWidget {
  final MainModel mainModel;
  Login({Key key, @required this.mainModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<LoginBloc>(
        bloc: LoginBloc(),
        child: LoginApp(mainModel),
    );
    
  } 
  
}

class LoginApp extends StatelessWidget {
  final MainModel mainModel;
  LoginApp(this.mainModel);
  final formKey = GlobalKey<FormState>();
  void _forSubmitted() {
    var _form = formKey.currentState;
    if (_form.validate()) {
      _form.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
   

    return   StreamBuilder(
            stream: loginBloc.outLoginList,
            initialData: LoginModel.initial(),
            builder: (BuildContext context, AsyncSnapshot<LoginModel> snapshot){
              var vm =  snapshot.data;
              loginForms() => Form(
                key: formKey,
                onChanged: () {               
                  
                },
                autovalidate: false, //开启验证input
                child: Column(
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
           

              
              return Scaffold(
                      body: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 600.0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 0.0),
                                      padding: EdgeInsets.only(top: 160.0),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      decoration: new  BoxDecoration(
                                        image:  DecorationImage(image: AssetImage('images/logos8.png'), fit: BoxFit.fill),
                                      ),
                                      child: new Column(
                                        children:  <Widget>[
                                          new Padding(
                                            padding: EdgeInsets.only(top: 50.0),
                                            child: LoginType(),
                                          ),
                                          
                                          new Stack(
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.only(top: 10.0),
                                                child: new Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  width: MediaQuery.of(context).size.width - 75.0,
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                    color: Colors.white,
                                                  ),
                                                  child: new Center(
                                                    child:  
                                                    loginForms(),
                                                  ),
                                                ),
                                              ),
                                                                                  
                                              
                                              new Container(
                                                width: MediaQuery.of(context).size.width - 75.0,
                                                padding: EdgeInsets.only(top: 20.0),
                                                child: new Padding(
                                                  padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 165.0),
                                                  child:  new CupertinoButton(
                                                    color: Colors.blue[400],
                                                    pressedOpacity: 0.0,
                                                    child: new Text('登陆'),
                                                    onPressed: () {
                                                      _forSubmitted(); // save form
                                                      loginBloc.loginSubmit(vm, context, bloc, mainModel);

                                                    }
                                                ),
                                                )
                                              
                                              ),
                                          

                                            ],

                                          ),
                                        
                                          
                                        ],
                                      ),
                                    )
                                        
                                      ],
                                    ),
                                  ),

                              ),
                              new Model(
                                isShow: vm.offStage,
                                title: '提示内容',
                                content: vm.modelContent,
                                but0nPressed: () {
                                  vm.offStage = true;
                                  loginBloc.setData(vm);
                              }),
                            
                              new Container(
                                height: vm.shadeHeight,
                                width: vm.shadeWidth,
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                child: new Center(
                                  child: new CupertinoActivityIndicator(
                                    animating: vm.loginLoadding,
                                    radius: vm.radiusLoading,
                                  ),
                                  ),
                              ),

                      ],
                  ),
                  
          );

        },
      );
  }
  
  
}

