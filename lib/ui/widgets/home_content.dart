import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/page/user.dart';

class HomeContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 83.0,
            // color: Color.fromRGBO(21, 21, 21, 0.8),
            child:  Column(
              children: <Widget>[
                iconRows(
                  context,
                  Icon(FontAwesomeIcons.assistiveListeningSystems),
                  Icon(FontAwesomeIcons.affiliatetheme),
                  'FLIGHT',
                  'FLIGHTs',
                  1,2
                ),
                Container(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                ),
                iconRows(
                  context,
                  Icon(FontAwesomeIcons.anchor),
                  Icon(FontAwesomeIcons.bug),
                  'FLIGHT1',
                  'FLIGHTs',
                  3,4
                ),
                Container(
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                ),
                iconRows(
                  context,
                  Icon(FontAwesomeIcons.asymmetrik),
                  Icon(FontAwesomeIcons.lightbulb),
                  'FLIGHT2',
                  'FLIGHTs',
                  5,6
                ),
              ],
            )
            
          );
  }
  iconRows(BuildContext context, Icon iconLeft,Icon iconRight,
            String textLeft, String textRight, int typeLeft, int typeRight) => Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height:  (MediaQuery.of(context).size.height - 85.0)/3,
                color: Color.fromRGBO(21, 21, 21, 0.8),
                child: Center(
                  child: iconState(iconLeft, textLeft, typeLeft, context),
                )
                
              ),
            ),
            Container(
                width: 1.0,
                height: 100.0,
            ),
            Expanded(
              child: Container(
                height:  (MediaQuery.of(context).size.height - 85.0)/3,
                color: Color.fromRGBO(21, 21, 21, 0.8),
                child: Center(
                  child: iconState(iconRight, textRight, typeRight, context),
                )
              ),
            )
          ],
        );
  iconState(Icon icon, String text, int type, BuildContext context) =>Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child:  
          LogoApps('', icon, type, (type) {
            print(type);
            if (type == 1) {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => User(),
                  ));
            }
          })
        ),
        Padding(
          padding: EdgeInsets.only(top: 78.0, left: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15.0,
              fontWeight: FontWeight.w300
            )
          ),
        )
        
      ],
    );
    
}

class LogoApps extends StatefulWidget {
  final String text;
  final Icon icon;
  final int type;
  final Function pageFul;
  LogoApps(this.text, this.icon, this.type, this.pageFul);
  _LogoAppState createState() => new _LogoAppState(text, icon, type, pageFul);
}

class _LogoAppState extends State<LogoApps> with SingleTickerProviderStateMixin {
  final String text;
  final Icon icon;
  final int type;
   final Function pageFul;
  _LogoAppState(this.text, this.icon, this.type, this.pageFul);
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 20.0, end: 59.0).animate(
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
    return IconButton(
            icon:  icon,
            color: Color.fromRGBO(114, 74, 158, 1.0),
            iconSize: animation.value,
            onPressed: () {
              pageFul(type);
            },
          );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
