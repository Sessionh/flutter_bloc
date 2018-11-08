import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/bloc/main_bloc.dart';
import 'package:flutter_bloc/model/main_model.dart';
import 'package:flutter_bloc/bloc/login_bloc.dart';
import 'package:flutter_bloc/model/login_model.dart';
import 'package:flutter_bloc/libs/util.dart';
import 'package:flutter_bloc/common_widgets/Model.dart';
import 'package:flutter_bloc/ui/widgets/login_type.dart';
import 'package:flutter_bloc/ui/widgets/login_form.dart';

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
              print(mainModel.isLogin);
             

              
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
                                                    child:  LoginForm(formKey)
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
                                                    child: new Text('登陆${vm.username}'),
                                                    onPressed: () {
                                                      _forSubmitted(); // save form
                                                      print(vm.username);
                                                      
                                                       FocusScope.of(context).requestFocus(new FocusNode());
         
                                                        if (vm.username == '' &&  vm.password == '') {
                                                          vm.modelContent =  '用户名和密码不能为空';
                                                          vm.offStage = false;
                                                          loginBloc.setData(vm);

                                                        } else if (vm.username != '' && vm.password == '') {
                                                          vm.modelContent =  '密码不能为空';
                                                          vm.offStage = false;
                                                          loginBloc.setData(vm);

                                                        } else if (vm.username == '' && vm.password != '') {
                                                          vm.modelContent =  '用户名不能为空';
                                                          vm.offStage = false;
                                                          loginBloc.setData(vm);


                                                        } else {
                                                          vm.shadeHeight = MediaQuery.of(context).size.height;
                                                          vm.shadeWidth = MediaQuery.of(context).size.width;
                                                          vm.radiusLoading = 30.0;
                                                          vm.loginLoadding = true;
                                                          loginBloc.setData(vm);
                                                          
                                                      
                                                          Util.setTimeOut(2, () {
                                                            vm.shadeHeight = 0.0;
                                                            vm.shadeWidth = 0.0;
                                                            vm.radiusLoading = 0.0;
                                                            vm.loginLoadding = false;
                                                            loginBloc.setData(vm);
                                                            mainModel.isLogin = true;
                                                            bloc.setData(mainModel);
                                                            
                                                          
                                                            // Navigator.pushNamed(context, '/home');

                                                          });

                                                        }

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

