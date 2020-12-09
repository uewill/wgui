import 'package:flutter/material.dart';
import 'package:wgui/widget/wg_base_stateful_widget.dart';

/// author : huang bo
/// time   : 2020/7/8 16:44
/// email  : huangbobob@163.com
/// desc   : 超长显示省略号文本控件，点击查看文本详情

class WGEllipsizeText extends WGBaseStatefulWidget {
  final Text text;

  WGEllipsizeText(this.text);

  @override
  WGBaseStatefulWidgetState<WGBaseStatefulWidget> getState() {
    return _WGEllipsizeTextState();
  }
}

class _WGEllipsizeTextState extends WGBaseStatefulWidgetState<WGEllipsizeText> {
  bool absorbing = true;

  @override
  void initState() {
    super.initState();
    //添加页面绘制完成监听
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        setState(() {
          absorbing = !_isExpansion(context, widget.text);
        });
      }
    });
  }

  @override
  void didUpdateWidget(WGEllipsizeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    //添加页面绘制完成监听（每次监听完成就会失效）
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        setState(() {
          absorbing = !_isExpansion(context, widget.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: GestureDetector(
        child: widget.text,
        onTap: () {
          if (!absorbing) {
            showDialog(context: context,child:
            SimpleDialog(title: Text("提示"),children: [
              Text(widget.text.data)
            ])
            );
//            DialogUtil.showAlertDialog(context,
//                content: widget.text.data,
//                title: StringRes.DETAIL_CONTENT.getText(context));
          }
        },
      ),
    );
  }

  ///判断文本是否超长
  bool _isExpansion(BuildContext context, Text text) {
    DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextPainter _textPainter = TextPainter(
        maxLines: text.maxLines,
        textScaleFactor:
        text.textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
        textAlign: widget.text.textAlign ?? TextAlign.start,
        text: text.textSpan ??
            TextSpan(
                text: text.data,
                style: text.style ?? defaultTextStyle.style.merge(text.style)),
        textDirection: text.textDirection ?? TextDirection.ltr)
      ..layout(maxWidth: context.size.width, minWidth: context.size.width);
    //这里判断 文本是否截断
    return _textPainter.didExceedMaxLines;
  }
}
