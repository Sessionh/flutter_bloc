import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/bloc/user_bloc.dart';
import 'package:flutter_bloc/bloc/main_bloc.dart';
import 'package:flutter_bloc/model/main_model.dart';
import 'package:flutter_bloc/model/user_model.dart';
class User extends StatelessWidget{
  final MainModel mainModel;
  User({Key key, this.mainModel}):super(key: key);
  @override
  Widget build(BuildContext context) {
     return BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: UserApp(mainModel),
    );
  }
}
class UserApp extends StatelessWidget {
  final MainModel mainModel;
  UserApp(this.mainModel);

  @override
  Widget build(BuildContext context) {
    
    final UserBloc bloc = BlocProvider.of<UserBloc>(context);
    final MainBloc main = BlocProvider.of<MainBloc>(context);
    

    return StreamBuilder(
      initialData: UserModel.init(),
      stream: bloc.outList,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snap){
        var vm = snap.data;
        return Scaffold(
          body: LogoApp(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              mainModel.isLogin = false;
              main.setData(mainModel);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );

      },
    );
   
  }
}



class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  CurvedAnimation curve;

  initState() {
    super.initState();
    controller = new AnimationController(
       duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = new Tween(begin: 20.0, end: 300.0).animate(curve);
     
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: IconButton(
          iconSize: animation.value,
          icon: Icon(Icons.local_movies),
          onPressed: () {
            controller.forward();
           if (controller.isCompleted) {
             controller.reverse();
           } else {
             controller.forward();
           }
          },
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
