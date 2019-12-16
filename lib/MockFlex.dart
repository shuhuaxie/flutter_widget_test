import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MockFlexDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RowDemo')),
        body: MockFlex(
          children: <Widget>[
            Text("1"),
            Text("2"),
            Text("3"),
            GestureDetector(
                onTap: () {
                  print('xie onTap...');
//                  Fluttertoast.showToast(
//                      msg: "3",
//                      toastLength: Toast.LENGTH_SHORT,
//                      gravity: ToastGravity.CENTER,
//                      timeInSecForIos: 1,
//                  );
                },
                child: Text("4")),
          ],
        ));
  }
}

class MockFlex extends MultiChildRenderObjectWidget {
  MockFlex({List<Widget> children}) : super(children: children);

  @override
  MockRenderFlex createRenderObject(BuildContext context) {
    return MockRenderFlex();
  }

  @override
  MultiChildRenderObjectElement createElement() {
    return MockMultiChildRenderObjectElement(this);
  }
}

class MockRenderFlex extends RenderBox
    with
        MockContainerRenderObjectMixin<RenderBox, MockFlexParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MockFlexParentData> {
  MockRenderFlex({List<RenderBox> children}) : super();

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MockFlexParentData)
      child.parentData = MockFlexParentData();
  }

  @override
  void performLayout() {
    RenderBox child = firstChild;
    double crossSize = 0.0;
    double allocatedSize =
        0.0; // Sum of the sizes of the non-flexible children.
    double minChildExtent = 0;
    final double maxChildExtent = double.infinity;
    while (child != null) {
      final MockFlexParentData childParentData = child.parentData;
      BoxConstraints innerConstraints;

      innerConstraints = BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: minChildExtent,
          maxHeight: maxChildExtent);
      child.layout(innerConstraints, parentUsesSize: true);
      final double childSize = child.size.height;
      assert(childSize <= maxChildExtent);
      allocatedSize += childSize;
      childParentData.offset = Offset(0, allocatedSize);
      child = childParentData.nextSibling;
    }
    crossSize = constraints.maxWidth;
    final double idealSize = allocatedSize;
    size = constraints.constrain(Size(crossSize, idealSize));

    // Align items along the main axis.
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool debugValidateChild(RenderObject child) {
    // TODO: implement debugValidateChild
    return true;
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    print('xie hitTest');
    return super.hitTest(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    print('xie hit Test children');
    RenderBox child = lastChild;
    int index = 0;
    while (child != null) {
      print('xie child' + index.toString());
      index++;
      final MockFlexParentData childParentData = child.parentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          print("xie hello test");
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      print('xie isHit:' + isHit.toString());
      if (isHit) return true;
      child = childParentData.previousSibling;
      print('xie child type:' + child.runtimeType.toString());
    }
    return false;
//    return defaultHitTestChildren(result, position: position);
  }

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    print('xie event:' + event.runtimeType.toString());
  }

}

mixin MockContainerRenderObjectMixin<ChildType extends RenderObject,
    ParentDataType extends ContainerParentDataMixin<ChildType>> on RenderBox {
  int _childCount = 0;

  ChildType _firstChild;
  ChildType _lastChild;

  void insert(ChildType child, {ChildType after}) {
    assert(child != this, 'A RenderObject cannot be inserted into itself.');
    assert(after != this,
        'A RenderObject cannot simultaneously be both the parent and the sibling of another RenderObject.');
    assert(child != after, 'A RenderObject cannot be inserted after itself.');
    assert(child != _firstChild);
    assert(child != _lastChild);
    adoptChild(child);
    _insertIntoChildList(child, after: after);
  }

  void _insertIntoChildList(ChildType child, {ChildType after}) {
    final ParentDataType childParentData = child.parentData;
    assert(childParentData.nextSibling == null);
    assert(childParentData.previousSibling == null);
    _childCount += 1;
    assert(_childCount > 0);
    if (after == null) {
      // insert at the start (_firstChild)
      childParentData.nextSibling = _firstChild;
      if (_firstChild != null) {
        final ParentDataType _firstChildParentData = _firstChild.parentData;
        _firstChildParentData.previousSibling = child;
      }
      _firstChild = child;
      _lastChild ??= child;
    } else {
      assert(_firstChild != null);
      assert(_lastChild != null);
//      assert(_debugUltimatePreviousSiblingOf(after, equals: _firstChild));
//      assert(_debugUltimateNextSiblingOf(after, equals: _lastChild));
      final ParentDataType afterParentData = after.parentData;
      if (afterParentData.nextSibling == null) {
        // insert at the end (_lastChild); we'll end up with two or more children
        assert(after == _lastChild);
        childParentData.previousSibling = after;
        afterParentData.nextSibling = child;
        _lastChild = child;
      } else {
        // insert in the middle; we'll end up with three or more children
        // set up links from child to siblings
        childParentData.nextSibling = afterParentData.nextSibling;
        childParentData.previousSibling = after;
        // set up links from siblings to child
        final ParentDataType childPreviousSiblingParentData =
            childParentData.previousSibling.parentData;
        final ParentDataType childNextSiblingParentData =
            childParentData.nextSibling.parentData;
        childPreviousSiblingParentData.nextSibling = child;
        childNextSiblingParentData.previousSibling = child;
        assert(afterParentData.nextSibling == child);
      }
    }
  }

  void add(ChildType child) {
    insert(child, after: _lastChild);
  }

  /// Add all the children to the end of this render object's child list.
  void addAll(List<ChildType> children) {
    children?.forEach(add);
  }

  void _removeFromChildList(ChildType child) {
    final ParentDataType childParentData = child.parentData;
//    assert(_debugUltimatePreviousSiblingOf(child, equals: _firstChild));
//    assert(_debugUltimateNextSiblingOf(child, equals: _lastChild));
    assert(_childCount >= 0);
    if (childParentData.previousSibling == null) {
      assert(_firstChild == child);
      _firstChild = childParentData.nextSibling;
    } else {
      final ParentDataType childPreviousSiblingParentData =
          childParentData.previousSibling.parentData;
      childPreviousSiblingParentData.nextSibling = childParentData.nextSibling;
    }
    if (childParentData.nextSibling == null) {
      assert(_lastChild == child);
      _lastChild = childParentData.previousSibling;
    } else {
      final ParentDataType childNextSiblingParentData =
          childParentData.nextSibling.parentData;
      childNextSiblingParentData.previousSibling =
          childParentData.previousSibling;
    }
    childParentData.previousSibling = null;
    childParentData.nextSibling = null;
    _childCount -= 1;
  }

  /// Remove this child from the child list.
  ///
  /// Requires the child to be present in the child list.
  void remove(ChildType child) {
    _removeFromChildList(child);
    dropChild(child);
  }

  /// Remove all their children from this render object's child list.
  ///
  /// More efficient than removing them individually.
  void removeAll() {
    ChildType child = _firstChild;
    while (child != null) {
      final ParentDataType childParentData = child.parentData;
      final ChildType next = childParentData.nextSibling;
      childParentData.previousSibling = null;
      childParentData.nextSibling = null;
      dropChild(child);
      child = next;
    }
    _firstChild = null;
    _lastChild = null;
    _childCount = 0;
  }

  /// Move the given `child` in the child list to be after another child.
  ///
  /// More efficient than removing and re-adding the child. Requires the child
  /// to already be in the child list at some position. Pass null for `after` to
  /// move the child to the start of the child list.
  void move(ChildType child, {ChildType after}) {
    assert(child != this);
    assert(after != this);
    assert(child != after);
    assert(child.parent == this);
    final ParentDataType childParentData = child.parentData;
    if (childParentData.previousSibling == after) return;
    _removeFromChildList(child);
    _insertIntoChildList(child, after: after);
    markNeedsLayout();
  }

  /// The previous child before the given child in the child list.
  ChildType childBefore(ChildType child) {
    assert(child != null);
    assert(child.parent == this);
    final ParentDataType childParentData = child.parentData;
    return childParentData.previousSibling;
  }

  /// The next child after the given child in the child list.
  ChildType childAfter(ChildType child) {
    assert(child != null);
    assert(child.parent == this);
    final ParentDataType childParentData = child.parentData;
    return childParentData.nextSibling;
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> children = <DiagnosticsNode>[];
    if (firstChild != null) {
      ChildType child = firstChild;
      int count = 1;
      while (true) {
        children.add(child.toDiagnosticsNode(name: 'child $count'));
        if (child == lastChild) break;
        count += 1;
        final ParentDataType childParentData = child.parentData;
        child = childParentData.nextSibling;
      }
    }
    return children;
  }

  int get childCount => _childCount;

  ChildType get lastChild => _lastChild;

  ChildType get firstChild => _firstChild;

  // RenderObjectElement.deactivate
  // A RenderObject was still attached when attempting to deactivate its RenderObjectElement

  @override
  void detach() {
    super.detach();
    ChildType child = _firstChild;
    while (child != null) {
      child.detach();
      final ParentDataType childParentData = child.parentData;
      child = childParentData.nextSibling;
    }
  }
}

class MockFlexParentData extends ContainerBoxParentData<RenderBox> {}

class MockMultiChildRenderObjectElement extends MultiChildRenderObjectElement {
  MockMultiChildRenderObjectElement(MultiChildRenderObjectWidget widget)
      : super(widget);

  @override
  void insertChildRenderObject(RenderObject child, Element slot) {
    final MockContainerRenderObjectMixin<RenderObject,
            ContainerParentDataMixin<RenderObject>> renderObject =
        this.renderObject;
    renderObject.insert(child, after: slot?.renderObject);
  }
}
