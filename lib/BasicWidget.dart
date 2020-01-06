import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ColumnDemo')),
        body: Column(
          children: <Widget>[
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        ));
  }
}

class RowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RowDemo')),
        body: Row(
          children: <Widget>[
            Expanded(child: Text("1")),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        ));
  }
}

class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ListViewDemo')),
        body: ListView(
          children: <Widget>[
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        ));
  }
}

class TestRaiseButtonDemo extends StatefulWidget {
  @override
  MyRenderBoxState createState() {
    return MyRenderBoxState();
  }
}

class MyRenderBoxState extends State<TestRaiseButtonDemo> {
  double _elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyRenderPhysicalShapeDemo')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Slider(
                value: _elevation,
                onChanged: (value) => setState(() => _elevation = value),
              ),
              MyRenderBoxWidget(
                elevation: _elevation,
              )
            ]));
  }
}

class MyRenderBoxWidget extends LeafRenderObjectWidget {
  final _elevation;

  MyRenderBoxWidget({double elevation})
      : this._elevation = elevation,
        super();

  @override
  MyRenderBox createRenderObject(BuildContext context) {
    return MyRenderBox(
      elevation: _elevation,
    );
  }

  @override
  void updateRenderObject(BuildContext context, MyRenderBox renderObject) {
    renderObject..elevation = _elevation;
  }
}

class MyRenderBox extends RenderBox {
  MyRenderBox({
    double elevation = 0.0,
  })  : _elevation = elevation,
        super();

  @override
  PhysicalModelLayer get layer => super.layer;

  @override
  Path get _defaultClip => Path()..addRect(Offset.zero & size);

  @override
  void performLayout() {
    size = Size(100, 100);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    parent;
    final Rect offsetBounds = offset & size;
    final Path offsetPath = _defaultClip.shift(offset);
    layer ??= PhysicalModelLayer();
    layer
      ..clipPath = offsetPath
      ..clipBehavior = Clip.none
      ..elevation = elevation
      ..color = Color(0x61000000)
      ..shadowColor = Colors.black;
    context.pushLayer(layer, super.paint, offset,
        childPaintBounds: offsetBounds);
  }

  double get elevation => _elevation;
  double _elevation;

  set elevation(double value) {
    if (elevation == value) return;
    _elevation = value;
    markNeedsPaint();
  }
}

class FrogColor extends InheritedWidget {
  const FrogColor({
    Key key,
    @required this.color,
    @required Widget child,
  })  : assert(color != null),
        assert(child != null),
        super(key: key, child: child);

  final Color color;

  static FrogColor of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FrogColor) as FrogColor;
  }

  @override
  bool updateShouldNotify(FrogColor old) => color != old.color;
}

class InheritedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InheritedDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ShareWidget(
          //使用ShareWidget
          data: _counter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text('You have clicked the button this many time:'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _TextWidget(), //子widget中依赖ShareWidget
              ),
              RaisedButton(
                child: Text('Increment'),
                onPressed: () => setState(() => ++_counter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareWidget extends InheritedWidget {
  final int data;

  ShareWidget({@required this.data, Widget child}) : super(child: child);

  //定义一个方法，方便子树中的widget获取这个widget，进而获得共享数据。
  static ShareWidget of(BuildContext context) {
    /**
     * 获取最近的给定类型的Widget，该widget必须是InheritedWidget的子类，
     * 并向该widget注册传入的context，当该widget改变时，
     * 这个context会重新构建以便从该widget获得新的值。
     * 这就是child向InheritedWidget注册的方法。
     */
    return context.inheritFromWidgetOfExactType(ShareWidget);
  }

  /**
   * framework通过使用以前占据树中的这个位置的小部件作为参数调用这个函数来区分这些情况。
   */
  @override
  bool updateShouldNotify(ShareWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextWidgetState();
  }
}

class _TextWidgetState extends State<_TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareWidget.of(context).data.toString());
  }

  /**
   * 如果依赖的InheritedWidget改变了，framework将会调用这个方法来通知这个对象。
   * 在这个方法中调用BuildContext.inheritFromWidgetOfExactType是安全的。
   * 子类很少覆写这个方法，因为framework通常会在依赖的InheritedWidget改变后调用build方法，
   * 覆写这个方法通常用来做一些耗时的工作，比如网络请求
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }
}

class OverlayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OverlayDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OverlayPage(title: 'OverlayDemo'),
    );
  }
}

class OverlayPage extends StatefulWidget {
  OverlayPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OverlayState createState() => _OverlayState();
}

class _OverlayState extends State<OverlayPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    bool isShow = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text('You have clicked the button this many time:'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
//                child: _TextWidget(), //子widget中依赖ShareWidget
            ),
            RaisedButton(
              child: Text('Increment'),
              onPressed: () {
                isShow ? Toast.show(context, "h12") : Toast.close(context);
                isShow = !isShow;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Toast {
  static show(BuildContext context, String msg) {
    var overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return buildToastLayout(msg);
    });
    overlayState.insert(overlayEntry);
  }

  static close(BuildContext context) {
    var overlayState = Overlay.of(context);
    overlayState.dispose();
  }

  static LayoutBuilder buildToastLayout(String msg) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "${msg}",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.15,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}
