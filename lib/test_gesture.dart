
import 'package:flutter/material.dart';

class MyTestGestureDemo extends StatefulWidget {
  @override
  MyTestGestureState createState() {
    return MyTestGestureState();
  }
}

class MyTestGestureState extends State<MyTestGestureDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyTestGestureDemo')),
        body: GestureDetector(
          onTap: ()=>
              print('parent tap...')
          ,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: ()=>
                  print('child tap...')
                ,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Color(0xffff0000),
                ),
              )
            ],
          ),
        ));
  }
}
