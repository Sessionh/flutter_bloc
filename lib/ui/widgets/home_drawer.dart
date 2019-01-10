import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final String title;
  HomeDrawer(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.7),
      child:  Column(
      children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 36.0),
            padding: EdgeInsets.all(12.5),
            width: 160.0,
            height: 160.0,
            decoration: new  BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: new  BoxDecoration(
                  image:  DecorationImage(image: AssetImage('images/user.png'), fit: BoxFit.fill),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
             
          ),
          )
        ],
      ),
    );
    
   
  }
}