import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/bloc_provider.dart';
import 'package:flutter_bloc/bloc/main_bloc.dart';
import 'package:flutter_bloc/model/main_model.dart';
import 'package:flutter_bloc/model/home_model.dart';
import 'package:flutter_bloc/bloc/home_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/ui/widgets/home_content.dart';
class Home extends StatelessWidget {
  final MainModel mainModel;
  Home({Key key, @required this.mainModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<HomeBloc>(
      bloc: HomeBloc(),
      child: HomeApp(mainModel),
    );
  }
}
class HomeApp extends StatelessWidget {
 final MainModel mainModel;
  HomeApp(this.mainModel);
  
   @override
   Widget build(BuildContext context) {
     final MainBloc main = BlocProvider.of<MainBloc>(context);
     final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
     final _drawerKey = GlobalKey<ScaffoldState>();
    
     return  StreamBuilder(
      stream: bloc.outMoviesList,
      initialData: HomeModel.initData(),
      builder: (BuildContext context, AsyncSnapshot<HomeModel> snapshot){
        var vm = snapshot.data;
        return  Scaffold(
          key: _drawerKey,
          backgroundColor: Colors.black87,
          drawer: Drawer(
            child: Container(
              child: Text('333')
            )
          ),
          body: Column(
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top,
                  right: 5.0,
                ),
                height:83.0,
                child: new Row(
                  children: [
                      new Expanded(
                        flex: 3,
                        child: new Row(
                          children: <Widget>[
                            IconButton(
                              tooltip: 'Menu Icon',
                              icon: Icon(
                                  FontAwesomeIcons.alignLeft,
                                  size: 18.0,
                                  color: Colors.white
                              ),
                              onPressed: () {
                              _drawerKey.currentState.openDrawer();

                            },
                            ),
                            new Expanded(
                              child: LogoApp('Let`s Go'),
                              
                              // new Text(
                              //     'Let`s Go',
                              //     textAlign: TextAlign.center,
                              //     style: const TextStyle(
                              //         fontSize: 18.0,
                              //         fontFamily: 'Dosis',
                              //         fontWeight: FontWeight.w400,
                              //         color: Colors.white
                              //     )),
                            ),
                          ],
                        ),
                        ),
                        Stack(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(FontAwesomeIcons.bell),
                              iconSize: 20.0,
                              color: Colors.white,
                              tooltip: '告警',
                              onPressed: () {
                                mainModel.isLogin = false;
                                main.setData(mainModel);

                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 32.0, top: 6.0),
                              child:  Text(
                                  '3',
                                  style: TextStyle(color: Colors.blue),
                              ),
                            )
                           
                          ],
                        )
                      
                        
                      ],
                  ),
             ),
            HomeContent()

      ]
    )
          
         

        );

      },
    );
   }
}

class LogoApp extends StatefulWidget {
  final String text;
  LogoApp(this.text);
  _LogoAppState createState() => new _LogoAppState(text);
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  final String text;
  _LogoAppState(this.text);
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 33.0, end: 18.0).animate(
       CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        )
    )
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: animation.value,
              fontFamily: 'Dosis',
              fontWeight: FontWeight.w400,
              color: Colors.white
      ));
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}