import 'package:flutter/material.dart';

abstract class WGBaseStatelessWidget extends StatelessWidget {
  final bool enable;
  final bool visible;
  final bool require;
  final bool requirePosition; //require隐藏时是否保留位置
  final String requireTips;
  final bool isPrint;

  const WGBaseStatelessWidget(
      {this.enable = true,
        this.visible = true,
        this.require = false,
        this.requirePosition = true,
        this.isPrint = false,
        this.requireTips = ""});

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
