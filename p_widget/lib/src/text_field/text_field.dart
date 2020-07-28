import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';

/// 通用
/// [hint]: 默认提示内容
/// [bgColor]: 背景色
/// [textStyle]: 输入的字体样式
/// [hintStyle]: 默认文字字体样式
/// [cursorColor]: 光标颜色
/// [keyboardType]: 输入内容的格式
/// [contentPadding]: 内容 padding
/// [limitLength]: 限制文本输入长度
class MTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Color bgColor;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final Color cursorColor;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry contentPadding;
  final int limitLength;
  final int maxLines;
  final int minLines;
  final ValueChanged<String> onSubmitted;
  final Function(String) onChanged;
  final bool autofocus;
  final List<TextInputFormatter> inputFormatters;
  final TextAlign textAlign;

  MTextField({
    Key key,
    this.controller,
    this.hint,
    this.bgColor = const Color(0x00ffffff),
    this.textStyle,
    this.hintStyle,
    this.cursorColor = const Color(0xFF6D3EFF),
    this.keyboardType,
    this.contentPadding,
    this.limitLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.onSubmitted,
    this.onChanged,
    this.autofocus = false,
    this.inputFormatters,
    this.textAlign=TextAlign.start,
  }) : super(key: key);

  @override
  _MTextFieldState createState() => _MTextFieldState();
}

class _MTextFieldState extends State<MTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    initC();
    super.initState();
  }

  void initC() {
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      controller: _controller,
      cursorColor: widget.cursorColor,
      maxLengthEnforced: false,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        fillColor: widget.bgColor,
        filled: true,
        hintText: widget.hint,
        hintStyle: widget.hintStyle,
        border: InputBorder.none,
        contentPadding: widget.contentPadding ?? EdgeInsets.zero,
      ),
      style: widget.textStyle,
      onChanged: (value) {
        if (widget.limitLength == null) {
          widget.onChanged(value);
          return;
        } else {
          if (value.length > widget.limitLength) {
            var resultStr = value.substring(0, widget.limitLength);
            _controller.text = resultStr;
            widget.onChanged(resultStr);
          } else {
            widget.onChanged(value);
          }
        }
      },
      onSubmitted: widget.onSubmitted,
    );
  }
}
