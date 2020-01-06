import 'package:flutter/material.dart';
import 'package:flutter_widget_test/test_gesture.dart';
import 'BasicWidget.dart';
import 'MockFlex.dart';
import 'navigator_test.dart';
import 'usefulWidget.dart';
import 'WidgetsDemo.dart';
import 'hite_test_demo.dart';
import 'lifeCycle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListItem('MockFlex', MockFlexDemo()),
              ListItem('Lifecycle', MyWidgetLifeCycleDemo()),
//              ListItem('Opacity', OpacityDemo()),
//              ListItem('Text', TextDemo()),
              ListItem('ColumnDemo', ColumnDemo()),
              ListItem('RowDemo', RowDemo()),
//              ListItem('ListView', ListViewDemo()),
//              ListItem('TextField', TextFieldDemo()),
//              ListItem('ShaderMask', ShaderMaskDemo()),
//              ListItem('ClipRect', ClipRectDemo()),
//              ListItem('ClipRRect', ClipRRectDemo()),
//              ListItem('ClipOval', ClipOvalDemo()),
//              ListItem('ClipPath', ClipPathDemo()),
//              ListItem('PhysicalModel', PhysicalModelDemo()),
//              ListItem('PhysicalShape', PhysicalShapeDemo()),
//              ListItem('Transform', TransformDemo()),
//              ListItem('FittedBox', FittedBoxDemo()),
//              ListItem('FractionalTranslation', FractionalTranslationDemo()),
//              ListItem('RotatedBox', RotatedBoxDemo()),
//              ListItem('Padding', PaddingDemo()),
//              ListItem('Align', AlignDemo()),
//              ListItem('SizedBox', SizedBoxDemo()),
//              ListItem('ConstrainedBox', ConstrainedBoxDemo()),
//              ListItem('FractionallySizedBox', FractionallySizedBoxDemo()),
//              ListItem('IgnorePointer', IgnorePointerDemo()),
//              ListItem('AbsorbPointer', AbsorbPointerDemo()),
//              ListItem('MyRenderPhysicalShape & SingleChildRenderObjectWidget', MyRenderPhysicalShapeDemo()),

              ListItem('MyRenderBox & LeafRenderObjectWidget', MyRenderBoxDemo()),
              ListItem('MyTestGestureDemo', MyTestGestureDemo()),
              ListItem('CustomPaint & TriangleWidget', TriangleDemo()),
              ListItem('navigator', FirstRoute()),
//              ListItem('MyRenderBox2 & LeafRenderObjectWidget & Layer', MyRenderBoxDemo2()),
              ListItem('TestRaiseButton', TestRaiseButtonDemo()),
              ListItem('InheritedDemo', InheritedDemo()),
              ListItem('OverlayDemo', OverlayDemo()),
              ListItem('HitTestDemo', HitTestDemo()),
              ListItem('ListenerDemo', ListenerDemo()),
            ],
          ),
        ),
      ),
    );
  }
}




