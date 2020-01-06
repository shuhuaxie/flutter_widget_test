import 'package:flutter/material.dart';

class HitTestDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HitTestDemo')),
        body: HitTestPage(),
    );
  }
}

class HitTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () => {
              print('super.onTap...')
            },
            onSecondaryTapDown: (tap)=>{
              print('super.onSecondaryTapDown...')
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 40.0),
              color: Color(0xddffffff),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                          onTap: () => {
                            print('child.onTap...1')
                          },
                          onTapDown: (details)=>{
                            print('child.onTapDown...1')
                          },
                          onTapUp: (details)=>{
                            print('child.onTapUp...1')
                          },
                          child: Text(
                              'You have clicked the button this many time1:')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                          onTap: () => {
                            print('child.onTap...2')
                          },
                          child: Text(
                              'You have clicked the button this many time2:')),
                    )
                  ]),
            )));
  }
}

class HitTestPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("12121345", style: Theme.of(context).textTheme.title);
  }
}

class ListenerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListenerDemo')),
      body: ListenerStatefulWidget(),
    );
  }
}

class ListenerStatefulWidget extends StatefulWidget {
  ListenerStatefulWidget({Key key}) : super(key: key);

  @override
  _ListenerStatefulWidgetState createState() => _ListenerStatefulWidgetState();
}

class _ListenerStatefulWidgetState extends State<ListenerStatefulWidget> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    print('pointer id:'+ details.pointer.toString());
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(300.0, 200.0)),
      child: Listener(
        onPointerDown: _incrementDown,
        onPointerMove: _updateLocation,
        onPointerUp: _incrementUp,
        child:
        MyContainer(Container(
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'You have pressed or released in this area this many times:'),
              Text(
                '$_downCounter presses\n$_upCounter releases',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
              ),
            ],
          ),
        )),
      ),
    );
  }
}
// 测试stateless
class MyContainer extends StatelessWidget{
  final Widget myChild;
  MyContainer(this.myChild){
    print('MyContainer con');
  }
  @override
  Widget build(BuildContext context) {
    print('MyContainer build');
    return myChild;
  }

}
