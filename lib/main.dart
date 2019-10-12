import 'package:flutter/material.dart';
import 'WidgetsDemo.dart';

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
              ListItem('Opacity', OpacityDemo()),
              ListItem('ShaderMask', ShaderMaskDemo()),
              ListItem('ClipRect', ClipRectDemo()),
              ListItem('ClipRRect', ClipRRectDemo()),
              ListItem('ClipOval', ClipOvalDemo()),
              ListItem('ClipPath', ClipPathDemo()),
              ListItem('PhysicalModel', PhysicalModelDemo()),
              ListItem('PhysicalShape', PhysicalShapeDemo()),
              ListItem('Transform', TransformDemo()),
              ListItem('FittedBox', FittedBoxDemo()),
              ListItem('FractionalTranslation', FractionalTranslationDemo()),
              ListItem('RotatedBox', RotatedBoxDemo()),
              ListItem('Padding', PaddingDemo()),
              ListItem('Align', AlignDemo()),
              ListItem('SizedBox', SizedBoxDemo()),
              ListItem('ConstrainedBox', ConstrainedBoxDemo()),
              ListItem('FractionallySizedBox', FractionallySizedBoxDemo()),
              ListItem('IgnorePointer', IgnorePointerDemo()),
              ListItem('AbsorbPointer', AbsorbPointerDemo()),
              ListItem('MyRenderPhysicalShape & SingleChildRenderObjectWidget', MyRenderPhysicalShapeDemo()),
              ListItem('MyRenderBox & LeafRenderObjectWidget', MyRenderBoxDemo()),
            ],
          ),
        ),
      ),
    );
  }
}




