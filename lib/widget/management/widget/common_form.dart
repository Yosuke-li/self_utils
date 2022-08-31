import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:self_utils/utils/array_helper.dart';
import 'package:self_utils/widget/management/common/function_util.dart';

FormColumn<T> buildTextFormColumn<T>(
    {required Widget title, required String text(T value)}) {
  return FormColumn<T>(
      title: title, builder: (_, T value) => Text(text(value)));
}

FormColumn<T> buildButtonFormColumn<T>(
    {required Widget title, required String text(T value), InFunc<T>? onTap}) {
  return FormColumn<T>(
    title: title,
    builder: (_, T value) =>
        ElevatedButton(
          child: Text(text(value)),
          onPressed: onTap == null
              ? null
              : () {
            onTap(value);
          },
        ),
  );
}

FormColumn<T> buildIconButtonFormColumn<T>(
    {required Widget title, IconData? icon, InFunc<T>? onTap}) {
  return FormColumn<T>(
      title: title,
      builder: (_, T value) =>
          IconButton(
            icon: Icon(icon),
            onPressed: onTap == null
                ? null
                : () {
              onTap(value);
            },
          ));
}

/// self methods
/// [ColorFunc] 用于选中状态下的column，
/// [WidgetBuilderFunc] builder新子类
/// [TapCallBack] 点击的回调
/// [DragCallBack] 拖拽的回调
typedef ColorFunc<T> = MaterialAccentColor? Function(T value);
typedef WidgetBuilderFunc<T> = Widget Function(BuildContext context, T value);
typedef TapCallBack<T> = void Function(T value);
typedef DragCallBack<T> = void Function(T value, int index);

class FormColumn<T> {
  final Widget title;
  final double? width;
  final ColorFunc<T>? color;
  final WidgetBuilderFunc<T> builder;

  FormColumn(
      {required this.title, required this.builder, this.width, this.color});


}

/// 点击的回调方法[onTapFunc]
///
///
/// 拖拽的回调方法[onDragFunc]，按需选择是否实现
/// [value]当前的值，[index]拖拽到当前位置的索引
///
/// 鼠标右键的回调方法[onMouseEvent]
/// [event]获取鼠标位置 [index]获取当前点击的索引
/// Future<void> onMouseEvent(PointerDownEvent event, int index) async {
///        Log.info(event);
///        Log.info(index);
///  }
///

class CommonForm<T> extends StatefulWidget {
  final List<FormColumn<T>> columns;
  final List<T> values;
  final bool canDrag;
  final TapCallBack<T>? onTapFunc; //点击回调
  final DragCallBack<T>? onDragFunc; //拖拽后的回调
  final double height;
  final Color? titleColor;
  final Color? formColor;

  // final RightMenuFunc? rightMenuFunc; // 鼠标右键方法

  const CommonForm({Key? key,
    required this.columns,
    required this.values,
    this.canDrag = false,
    this.onDragFunc,
    this.onTapFunc,
    this.titleColor,
    // this.rightMenuFunc,
    this.formColor,
    required this.height})
      : super(key: key);

  @override
  _CommonFormState<T> createState() => _CommonFormState<T>();
}

///
/// 通过[StreamBuilder]和[StreamController]实现列的拖拽。
/// 每一次拖拽触发一次[StreamController.sink]，
/// 并通过widget生态的[didUpdateWidget]进行更新，使用[RepaintBoundary]优化组件
///

class _CommonFormState<T> extends State<CommonForm<T>> {
  ScrollController hController = ScrollController();
  ScrollController vController = ScrollController();

  bool shouldReact = false;

  final StreamController<List<FormColumn<T>>> controller = StreamController<
      List<FormColumn<T>>>();
  List<FormColumn<T>> columns = <FormColumn<T>>[];

  @override
  void initState() {
    super.initState();
    columns = widget.columns;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CommonForm<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != this) {
      columns = widget.columns;
      controller.sink.add(columns);
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Widget buildTitleRow(List<FormColumn<T>> formList) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.canDrag
            ? formList
            .map((e) =>
            LongPressDraggable(
                child: DragTarget<FormColumn<T>>(
                  onAccept: (data) {
                    final index = columns.indexOf(e);
                    setState(() {
                      columns.remove(data);
                      columns.insert(index, data);
                      controller.sink.add(columns);
                    });
                  },
                  builder: (context, data, rejects) {
                    return warpWidget(
                        child: e.title,
                        width: e.width,
                        color: widget.titleColor);
                  },
                ),
                data: e,
                delay: const Duration(milliseconds: 300),
                feedback: warpWidget(
                    child: e.title,
                    width: e.width,
                    color: widget.titleColor)))
            .toList(growable: false)
            : formList
            .map(
              (e) =>
              warpWidget(
                  child: e.title, width: e.width, color: widget.titleColor),
        )
            .toList(growable: false),
      ),
    );
  }

  ///可拖拽
  Widget buildDragTitleRow(int index) {
    return LongPressDraggable(
      data: index,
      child: DragTarget<int>(
        onAccept: (data) {
          final temp = widget.values[data];
          setState(() {
            widget.values.remove(temp);
            widget.values.insert(index, temp);
          });
          widget.onDragFunc?.call(temp, index);
        },
        //绘制widget
        builder: (context, data, rejects) {
          return buildRow(ArrayHelper.get(widget.values, index)!,
              color: widget.formColor);
        },
      ),
      delay: const Duration(milliseconds: 100),
      feedback: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.red),
          color: Colors.red,
        ),
        child: buildRow(ArrayHelper.get(widget.values, index)!),
      ),
    );
  }

  ///实现table的每一行
  Widget buildRow(T value, {Color? color}) {
    return Listener(
      onPointerDown: (e) {
        shouldReact = e.kind == PointerDeviceKind.mouse &&
            e.buttons == kSecondaryMouseButton;
      },
      onPointerUp: (e) async {
        if (!shouldReact) return;
        shouldReact = false;

        final position = Offset(
          e.position.dx + Offset.zero.dx,
          e.position.dy + Offset.zero.dy,
        );
      },
      child: Container(
        decoration: BoxDecoration(color: color),
        child: GestureDetector(
          onTap: () {
            widget.onTapFunc?.call(value);
          },
          child: Row(
            children: widget.columns
                .map((e) =>
                warpWidget(
                    child: e.builder(context, value),
                    color: e.color?.call(value),
                    width: e.width))
                .toList(growable: false),
          ),
        ),
      ),
    );
  }

  Widget warpWidget({required Widget child, Color? color, double? width}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: const Color(0xE6797979)),
          color: color),
      height: 25,
      width: width ?? 125,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: RepaintBoundary(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (widget.canDrag == true) {
      for (int x = 0; x < widget.values.length; x++) {
        children.add(buildDragTitleRow(x));
      }
    } else {
      children.addAll(
          widget.values.map((e) => buildRow(e, color: widget.formColor)));
    }

    return StreamBuilder<List<FormColumn<T>>>(
      stream: controller.stream,
      initialData: columns,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RepaintBoundary(
          child: Scrollbar(
            controller: hController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: hController,
              child: Container(
                height: widget.height,
                child: Column(
                  children: [
                    buildTitleRow(snapshot.data as List<FormColumn<T>>),
                    Expanded(
                      child: Scrollbar(
                        controller: vController,
                        child: SingleChildScrollView(
                          controller: vController,
                          child: Column(
                            children: children,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
