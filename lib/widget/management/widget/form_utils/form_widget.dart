part of '../common_form.dart';

class FormSetting {
  static double width = 125;
}

FormColumn<T> buildTextFormColumn<T>(
    {required Widget title, required String Function(T value) text}) {
  return FormColumn<T>(
      title: title, builder: (_, T value) => Text(text(value)));
}

FormColumn<T> buildButtonFormColumn<T>(
    {required Widget title, required String Function(T value) text, InFunc<T>? onTap}) {
  return FormColumn<T>(
    title: title,
    builder: (_, T value) => ElevatedButton(
      onPressed: onTap == null
          ? null
          : () {
              onTap(value);
            },
      child: Text(text(value)),
    ),
  );
}

FormColumn<T> buildIconButtonFormColumn<T>(
    {required Widget title, IconData? icon, InFunc<T>? onTap}) {
  return FormColumn<T>(
      title: title,
      builder: (_, T value) => IconButton(
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
typedef ListWidgetBuilder<T> = List<Widget> Function(
    BuildContext context, T value);
typedef TapCallBack<T> = void Function(T value);
typedef DragCallBack<T> = void Function(T value, int index);

class FormColumn<T> {
  final Widget title;
  final double? width;
  final ColorFunc<T>? color;
  final Widget? extraBuilder;
  final WidgetBuilderFunc<T> builder;

  FormColumn(
      {required this.title,
      required this.builder,
      this.width,
      this.color,
      this.extraBuilder});
}

class FormChildColumn<T> {
  final Widget title;
  final double? width;
  final WidgetBuilderFunc<T> builder;

  FormChildColumn({
    required this.title,
    required this.builder,
    this.width,
  });
}
