import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            Text("4"),
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
    with MockContainerRenderObjectMixin<RenderBox, MockFlexParentData> {
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

  ChildType get firstChild => _firstChild;
}

class MockFlexParentData extends ContainerBoxParentData<RenderBox> {

}

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
