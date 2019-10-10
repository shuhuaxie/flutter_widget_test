import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class ListItem extends StatelessWidget {
  final String name;
  final Widget widget;

  const ListItem(
    this.name,
    this.widget, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => widget),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            name,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ),
    );
  }
}

class OpacityDemo extends StatefulWidget {
  @override
  _OpacityDemoState createState() {
    return _OpacityDemoState();
  }
}

class _OpacityDemoState extends State<OpacityDemo> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OpacityDemo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _opacity,
            onChanged: (value) => setState(() => _opacity = value),
          ),
          Opacity(
            // 只有一个不透明度的参数，动态设置即可实现动画
            opacity: _opacity,
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class ShaderMaskDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShaderMask(
        shaderCallback: (Rect bounds) {
          return RadialGradient(
            center: Alignment.topLeft,
            colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: Center(child: Text('I’m burning the memories')),
      ),
    );
  }
}

class BackdropFilterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints.expand(), child: FlutterLogo()),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              child: Text(
                'Frosted',
                style: Theme.of(context).textTheme.display3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipRectDemo extends StatefulWidget {
  @override
  _ClipRectDemoState createState() {
    return _ClipRectDemoState();
  }
}

class _ClipRectDemoState extends State<ClipRectDemo> {
  double _heightFactor = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClipRectDemo')),
      body: Column(
        children: <Widget>[
          Slider(
            value: _heightFactor,
            onChanged: (value) => setState(() => _heightFactor = value),
          ),
          ClipRect(
            // Align设置了heightFactor, 那么Align的高度为Container的_heightFactor倍
            // ClipRect之后, Container的下半部分就被剪掉了
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              heightFactor: _heightFactor,
              // Container的大小为整个body
              child: Container(
                height: 400.0,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipRRectDemo extends StatefulWidget {
  @override
  _ClipRRectDemoState createState() {
    return _ClipRRectDemoState();
  }
}

class _ClipRRectDemoState extends State<ClipRRectDemo> {
  double _cornerRadius = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClipRRectDemo')),
      body: Column(
        children: <Widget>[
          Slider(
            value: _cornerRadius,
            onChanged: (value) => setState(() => _cornerRadius = value),
          ),
          ClipRRect(
            // 控制圆角的角度
            borderRadius: BorderRadius.circular(_cornerRadius * 180),
            child: Container(
              height: 400.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class ClipOvalDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClipOvalDemo')),
      body: ClipOval(
        child: Container(
          height: 400.0,
          color: Colors.red,
        ),
      ),
    );
  }
}

class ClipPathDemo extends StatefulWidget {
  @override
  _ClipPathDemoState createState() {
    return _ClipPathDemoState();
  }
}

class _ClipPathDemoState extends State<ClipPathDemo> {
  double _heightFactor = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClipRectDemo')),
      body: Column(
        children: <Widget>[
          Slider(
            value: _heightFactor,
            onChanged: (value) => setState(() => _heightFactor = value),
          ),
          ClipPath(
            // Align设置了heightFactor, 那么Align的高度为Container的0.5倍
            // ClipRect之后, Container的下半部分就被剪掉了
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              heightFactor: _heightFactor,
              // Container的大小为整个body
              child: Container(
                height: 400.0,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhysicalModelDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PhysicalModelDemo')),
      body: PhysicalModel(
        color: Colors.red,
        shape: BoxShape.circle,
        shadowColor: Colors.blueAccent,
        elevation: 20.0,
        child: Container(),
      ),
    );
  }
}

class PhysicalShapeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PhysicalModelDemo')),
      body: PhysicalShape(
        color: Colors.red,
        clipper: ShapeBorderClipper(
          shape: CircleBorder(),
          textDirection: Directionality.of(context),
        ),
//        shape: BoxShape.circle,
        shadowColor: Colors.black,
        elevation: 10,
        child: Container(), //带上这个 填充界面，否则神马都没有。
      ),
    );
  }
}

class TransformDemo extends StatefulWidget {
  @override
  TransformDemoState createState() {
    return TransformDemoState();
  }
}

class TransformDemoState extends State<TransformDemo> {
  double _angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('TransformDemo')),
        body: Column(
          children: <Widget>[
            Slider(
              value: _angle,
              onChanged: (value) => setState(() => _angle = value),
            ),
            Transform.rotate(
              alignment: AlignmentDirectional.center,
              angle: _angle,
              child: Center(
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FittedBoxDemo extends StatefulWidget {
  @override
  FittedBoxDemoState createState() {
    return FittedBoxDemoState();
  }
}

class FittedBoxDemoState extends State<FittedBoxDemo> {
  BoxFit _fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FittedBoxDemo')),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.fill);
                },
                child: Text('fill'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.contain);
                },
                child: Text('contain'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.cover);
                },
                child: Text('cover'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.fitWidth);
                },
                child: Text('fitWidth'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.fitHeight);
                },
                child: Text('fitHeight'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.none);
                },
                child: Text('none'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() => _fit = BoxFit.scaleDown);
                },
                child: Text('scaleDown'),
              ),
            ],
          ),
          Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              color: Colors.red,
              child: FittedBox(
                fit: _fit,
                child: Image.asset('assets/rabbit.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FractionalTranslationDemo extends StatefulWidget {
  @override
  FractionalTranslationDemoState createState() {
    return FractionalTranslationDemoState();
  }
}

class FractionalTranslationDemoState extends State<FractionalTranslationDemo> {
  double _offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FractionalTranslationDemo')),
      body: Column(
        children: <Widget>[
          Slider(
            value: _offset,
            onChanged: (value) => setState(() => _offset = value),
          ),
          Container(
            color: Colors.blueAccent,
            child: GestureDetector(
              onTap: () => print('tapped!!!!'),
              child: FractionalTranslation(
                transformHitTests: true,
                translation: Offset(_offset, _offset),
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RotatedBoxDemo extends StatefulWidget {
  @override
  RotatedBoxDemoState createState() {
    return new RotatedBoxDemoState();
  }
}

class RotatedBoxDemoState extends State<RotatedBoxDemo> {
  int turns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RotatedBoxDemo')),
      body: GestureDetector(
        onTap: () {
          setState(() => ++turns);
        },
        child: RotatedBox(
          quarterTurns: turns,
          child: Center(
            child: Image.asset('images/canyinguanjia.png'),
          ),
        ),
      ),
    );
  }
}

class PaddingDemo extends StatefulWidget {
  @override
  PaddingDemoState createState() {
    return new PaddingDemoState();
  }
}

class PaddingDemoState extends State<PaddingDemo> {
  double _insets = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PaddingDemo')),
      body: Column(
        children: <Widget>[
          Slider(
            value: _insets,
            onChanged: (value) => setState(() => _insets = value),
          ),
          Container(
            color: Colors.blueAccent,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(_insets * 50.0),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlignDemo extends StatefulWidget {
  @override
  AlignDemoState createState() {
    return new AlignDemoState();
  }
}

class AlignDemoState extends State<AlignDemo> {
  AlignmentDirectional _directional = AlignmentDirectional.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AlignDemo')),
      body: Column(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 3.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.topStart;
                  });
                },
                child: Text('topStart'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.topCenter;
                  });
                },
                child: Text('topCenter'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.topEnd;
                  });
                },
                child: Text('topEnd'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.centerStart;
                  });
                },
                child: Text('centerStart'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.center;
                  });
                },
                child: Text('center'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.centerEnd;
                  });
                },
                child: Text('centerEnd'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.bottomStart;
                  });
                },
                child: Text('bottomStart'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.bottomCenter;
                  });
                },
                child: Text('bottomCenter'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _directional = AlignmentDirectional.bottomEnd;
                  });
                },
                child: Text('bottomEnd'),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Align(
                alignment: _directional,
                child: Text(
                  'i am text',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SizedBoxDemo')),
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class ConstrainedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ConstrainedBoxDemo')),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              color: Colors.blueAccent,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100.0, maxHeight: 200.0),
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class FractionallySizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FractionallySizedBoxDemo')),
      body: Container(
        color: Colors.blueAccent,
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.5,
              child: RaisedButton(
                onPressed: () {},
                child: Text('child1'),
              ),
            ),
            SizedBox(height: 8.0),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: RaisedButton(
                onPressed: () {},
                child: Text('child2'),
              ),
            ),
            SizedBox(height: 8.0),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: RaisedButton(
                onPressed: () {},
                child: Text('child2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IgnorePointerDemo extends StatefulWidget {
  @override
  _IgnorePointerDemoState createState() {
    return _IgnorePointerDemoState();
  }
}

class _IgnorePointerDemoState extends State<IgnorePointerDemo> {
  bool _ignore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IgnorePointerDemo')),
      body: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.center,
        child: Column(
          children: <Widget>[
            Switch(
              value: _ignore,
              onChanged: (value) {
                setState(() => _ignore = value);
              },
            ),
            IgnorePointer(
              ignoring: _ignore,
              child: RaisedButton(
                onPressed: () => print('clicked!!'),
                child: Text('ignore'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AbsorbPointerDemo extends StatefulWidget {
  @override
  _AbsorbPointerDemo createState() {
    return _AbsorbPointerDemo();
  }
}

class _AbsorbPointerDemo extends State<AbsorbPointerDemo> {
  bool _absorb = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AbsorbPointerDemo')),
      body: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.center,
        child: Column(
          children: <Widget>[
            Switch(
              value: _absorb,
              onChanged: (value) {
                setState(() => _absorb = value);
              },
            ),
            GestureDetector(
              onTap: () => print('tap in GestureDetector'),
              child: AbsorbPointer(
                absorbing: _absorb,
                child: RaisedButton(
                  onPressed: () => print('tap in RaisedButton'),
                  child: Text('absorb'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRenderPhysicalShapeDemo extends StatefulWidget {
  @override
  MyRenderPhysicalShapeState createState() {
    return MyRenderPhysicalShapeState();
  }
}

class MyRenderPhysicalShapeState extends State<MyRenderPhysicalShapeDemo> {
  double _insets = 0.0;
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyRenderPhysicalShapeDemo')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Slider(
                value: _insets,
                onChanged: (value) => setState(() => _insets = value),
              ),
              Slider(
                value: _opacity,
                onChanged: (value) => setState(() => _opacity = value),
              ),
              Opacity(
                // 只有一个不透明度的参数，动态设置即可实现动画
                opacity: _opacity,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.red,
                ),
              ),
              MyPhysicalShape(
                insets: _insets,
                child: Container(
                  width: 50,
                  height: 50,
                ),
              )
            ]));
  }
}

class MyPhysicalShape extends SingleChildRenderObjectWidget {
  final _insets;

  MyPhysicalShape({double insets, Widget child})
      : this._insets = insets,
        super(child: child);

  @override
  RenderPhysicalShape createRenderObject(BuildContext context) {
    print('xie _insets:' + _insets.toString());
    return RenderPhysicalShape(
      clipBehavior: Clip.none,
      // 0x61000000
      color: Color(0x61000000),
      clipper: ShapeBorderClipper(
        shape: CircleBorder(),
        textDirection: Directionality.of(context),
      ),
//        shape: BoxShape.circle,
      // 0xff000000
      shadowColor: Colors.black,
      // 2 ~ 0
      elevation: _insets * 2,
    );
  }
}
