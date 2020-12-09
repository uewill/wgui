import 'package:flutter/material.dart';

abstract class WGBaseStatefulWidget extends StatefulWidget {
  final bool enable;
  final bool visible;
  final bool require;
  final bool requirePosition; //require隐藏时是否保留位置
  final String requireTips;
  final bool isPrint;

  const WGBaseStatefulWidget(
      {Key key,
        this.enable = true,
        this.visible = true,
        this.require = false,
        this.requirePosition = true,
        this.isPrint = false,
        this.requireTips = ""})
      : super(key: key);

  @override
  WGBaseStatefulWidgetState createState() {
    return getState();
  }

  WGBaseStatefulWidgetState getState();

  bool isValid() {
    return true;
  }

  String buildPrintTitle() {
    return "";
  }

  String buildPrintValue() {
    return "";
  }
}

abstract class WGBaseStatefulWidgetState<T extends WGBaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context);
}
