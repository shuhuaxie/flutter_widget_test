import 'package:flutter/material.dart';

class MyWidgetLifeCycleDemo extends StatefulWidget {
  MyWidgetLifeCycleDemo({Key key}) : super(key: key) {
    print('xie :' + runtimeType.toString() + " construction");
  }

  final String title = "Widget life cycle Demo";

  @override
  _MyWidgetLifeCycleState createState() => _MyWidgetLifeCycleState();
}

class _MyWidgetLifeCycleState extends State<MyWidgetLifeCycleDemo> {
  int _counter = 0;

  _MyWidgetLifeCycleState() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void didUpdateWidget(MyWidgetLifeCycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            BuildStatefulWidget(),
            SimplyStatelessWidget(),
            ChildStateFulWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BuildStatefulWidget extends StatefulWidget {
  BuildStatefulWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  State<StatefulWidget> createState() {
    return _BuildState();
  }
}

class _BuildState extends State<BuildStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return SimplyStatefulWidget();
  }

  _BuildState() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }

  @override
  void didUpdateWidget(BuildStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }
  @override
  void deactivate() {
    super.deactivate();
    print('xie :' + runtimeType.toString() + " deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('xie :' + runtimeType.toString() + " dispose");
  }
}

class SimplyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SimplyState();
  }

  SimplyStatefulWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }
}

class SimplyState extends State<SimplyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return Text(
      'simply text1:',
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('xie :' + runtimeType.toString() + " deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('xie :' + runtimeType.toString() + " dispose");
  }

  @override
  void didUpdateWidget(SimplyStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }
  SimplyState() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }


}

class SimplyStatelessWidget extends StatelessWidget {
  SimplyStatelessWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return Text(
      'simply text2:',
    );
  }
}

class ChildStateFulWidget extends StatefulWidget {
  ChildStateFulWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  State<StatefulWidget> createState() {
    return _ChildStateFulState();
  }
}

class _ChildStateFulState extends State<ChildStateFulWidget> {
  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return Column(
      children: <Widget>[SimplyStatefulWidget()],
    );
  }

  _ChildStateFulState() {
    print('xie :' + runtimeType.toString() + " construction");
  }
  @override
  void didUpdateWidget(ChildStateFulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }
  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }

  @override
  void deactivate() {
    super.deactivate();
    print('xie :' + runtimeType.toString() + " deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('xie :' + runtimeType.toString() + " dispose");
  }
}

class BuildUpStateFulWidget extends StatefulWidget {
  BuildUpStateFulWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  State<StatefulWidget> createState() {
    return _BuildUpStateFulState();
  }
}
class _BuildUpStateFulState extends State<BuildUpStateFulWidget> {
  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return BuildLowStateFulWidget();
  }

  _BuildUpStateFulState() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }
  @override
  void didUpdateWidget(BuildUpStateFulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }
  @override
  void deactivate() {
    super.deactivate();
    print('xie :' + runtimeType.toString() + " deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('xie :' + runtimeType.toString() + " dispose");
  }
}

class BuildLowStateFulWidget extends StatefulWidget {
  BuildLowStateFulWidget() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  State<StatefulWidget> createState() {
    return _BuildLowStateFulState();
  }
}
class _BuildLowStateFulState extends State<BuildLowStateFulWidget> {
  @override
  Widget build(BuildContext context) {
    print('xie :' + runtimeType.toString() + " build");
    return Column(
      children: <Widget>[SimplyStatefulWidget()],
    );
  }

  _BuildLowStateFulState() {
    print('xie :' + runtimeType.toString() + " construction");
  }

  @override
  void initState() {
    super.initState();
    print('xie :' + runtimeType.toString() + " initState");
  }

  @override
  void didUpdateWidget(BuildLowStateFulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('xie :' + runtimeType.toString() + " didUpdateWidget");
  }
  @override
  void deactivate() {
    super.deactivate();
    print('xie :' + runtimeType.toString() + " deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print('xie :' + runtimeType.toString() + " dispose");
  }
}