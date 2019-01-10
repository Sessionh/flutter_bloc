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
              // mainModel.isLogin = false;
              // main.setData(mainModel);
              Navigator.pop(context);
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

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 33.0, end: 130.0).animate(
       CurvedAnimation(
          parent: controller,
          curve: Curves.bounceIn,
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
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: 200.0,
        width: 200.0,
        child: IconButton(
          icon: Icon(Icons.local_dining),
          iconSize: animation.value,
          color: Colors.red,
          onPressed: () {

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

void main() {
  runApp(new LogoApp());
}

class TransformationAnimationWidget extends StatefulWidget {
  @override
  TransformationAnimationWidgetState createState() =>
      TransformationAnimationWidgetState();
}

class TransformationAnimationWidgetState
    extends State<TransformationAnimationWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> transitionTween;
  Animation<BorderRadius> borderRadius;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          // Navigator.pop(context);
        }
      });

    transitionTween = Tween<double>(
      begin: 50.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return new Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: transitionTween.value,
                height: transitionTween.value,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: borderRadius.value,
                ),
              ),
            );
      },
    );
  }
}



class UserAPPss extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _HomeState();
    }
}

class _HomeState extends State<UserAPPss> with TickerProviderStateMixin {
  Animation<double> catAnimation; // declare instance variable
  AnimationController catController; // declare instance variable
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
    void initState() {
      super.initState();

      boxController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );

      boxAnimation = Tween(begin: 10 * 0.6, end: 10 * 0.65).animate(
        CurvedAnimation(
          parent: boxController,
          curve: Curves.easeInOut,
        )
      );

      boxAnimation.addStatusListener((status) { // status is of type AnimationStatus
        if (status == AnimationStatus.completed) {
          boxController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          boxController.forward();
        }
      });
      boxController.forward();

      catController = AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      );

      catAnimation = Tween(begin: -35.0, end: -80.0).animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn,
        ),
      );
    }

  // HELPER METHODS
  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        body: GestureDetector( // any child tapped will bubble up to the GestureDetector
          child: Center(
            child: Stack(
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
              overflow: Overflow.visible,
            ),
          ),
          onTap: onTap, // the onTap helper method will be invoked only when the GestureDector widget is invoked
        )
      );
    }

    Widget buildCatAnimation() {
      return AnimatedBuilder(
        animation: catAnimation, // catAnimation records the current value of the property being animated
        child: Image.network(
        'https://i.imgur.com/QwhZRyL.png'
       ),
        builder: (BuildContext context, Widget child) {
          return Positioned(
            child: child,
            top: catAnimation.value,
            right: 0.0,
            left: 0.0,
          );
        },
      );
    }

    Widget buildBox() {
      return Container(
        height: 200.0,
        width: 200.0,
        color: Colors.brown,
      );
    }

    Widget buildLeftFlap() {
      return Positioned(
        left: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              child: child,
              alignment: Alignment.topLeft,
              angle: boxAnimation.value,
            );
          },
        ),
      );
    }

    Widget buildRightFlap() {
      return Positioned(
        right: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              child: child,
              alignment: Alignment.topRight,
              angle: -boxAnimation.value,
            );
          },
        ),
      );
    }
}