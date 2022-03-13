import 'package:flutter/material.dart';

/// 滚轮控件
/// 最多支持两个数据源
///
/// ```dart
/// List<String> _rights = ['12', '1', '123', '123'];
///
/// showModalBottomSheet(
///   context: context,
///   builder: (context) {
///     return Container(
///       height: 220,
///       child: WheelWidget(
///         data: _rights,
///         onSelected: (index) {
///           print('$index');
///         },
///       ),
///     );
///   },
/// );
/// ```
///
class WheelWidget extends StatefulWidget {
  /// 能显示的数量
  final int viewCnt;

  /// 选中状态 Text 样式
  final TextStyle selectedTextStyle;

  /// 未选中状态 Text 样式
  final TextStyle unSelectedTextStyle;

  /// 分割线颜色
  final Color divideColor;

  /// 是否显示分割线
  final bool showDivide;

  /// 分割线高度
  final double divideHeight;

  /// 数据源1
  final List<String> data;

  /// 数据源2 不一定有
  final List<String>? secData;

  /// 数据源1 回调
  final ValueChanged<int>? onSelected;

  /// 数据源2 回调
  final ValueChanged<int>? onSecSelected;

  /// 数据源1 初始选择项
  final int initIndex;

  /// 数据源2 初始选择项
  final int initSecIndex;

  WheelWidget({
    this.viewCnt = 5,
    this.selectedTextStyle =
        const TextStyle(fontSize: 20, color: Color(0xFF774EFF)),
    this.unSelectedTextStyle =
        const TextStyle(fontSize: 20, color: Color(0xFF999999)),
    required this.data,
    this.secData,
    this.divideColor = const Color(0xFFF3F3F3),
    this.showDivide = false,
    this.divideHeight = 1,
    this.onSelected,
    this.onSecSelected,
    this.initIndex = 0,
    this.initSecIndex = 0,
  })  : assert(selectedTextStyle != null, 'selectedTextStyle is null'),
        assert(unSelectedTextStyle != null, 'unSelectedTextStyle is null'),
        assert(data != null, 'data is null'),
        assert(!(data == null && secData != null), 'use data first');

  @override
  _WheelWidgetState createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget> {
  GlobalKey _keyStack = GlobalKey();

  /// 数据源1 当前选择 index
  int _selectedIndex = 0;

  /// 数据源2 当前选择 index
  int _secSelectedIndex = 0;

  /// PageView 中间控件高度
  double itemHeight = 0;

  /// 数据源1 pageController
  late PageController pageController;

  /// 数据源2 pageController
  late PageController secPageController;

  /// 参数: 用于控制 PageView 一次显示多少个 Item
  /// 0.2: 表示显示 5 个， 1/0.2=5
  double viewportFraction = 0.2;

  /// Stack 高度, 用这个值计算 Item 高度
  double _widgetHeight = 0;

  @override
  void initState() {
    viewportFraction = 1 / widget.viewCnt;
    pageController = PageController(
        viewportFraction: viewportFraction, initialPage: widget.initIndex);
    _selectedIndex = widget.initIndex;
    if (widget.onSelected != null) {
      widget.onSelected?.call(_selectedIndex);
    }

    if (widget.secData != null) {
      secPageController = PageController(
          viewportFraction: viewportFraction, initialPage: widget.initSecIndex);
      _secSelectedIndex = widget.initSecIndex;
      if (widget.onSecSelected != null) {
        widget.onSecSelected?.call(_secSelectedIndex);
      }
    }

    Future.delayed(Duration.zero, () {
      RenderBox rb = _keyStack.currentContext?.findRenderObject() as RenderBox;
      _widgetHeight = rb.size.height;
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(WheelWidget oldWidget) {
    if (widget.initIndex != oldWidget.initIndex ||
        widget.secData != oldWidget.secData) {
      // pageController.jumpToPage(widget.initIndex);
      _secSelectedIndex = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    itemHeight = _widgetHeight * viewportFraction;
    return Stack(
      key: _keyStack,
      children: <Widget>[
        _buildPageView(),
        _buildDivideLine(),
      ],
    );
  }

  Widget _buildDivideLine() {
    if (!widget.showDivide) {
      return SizedBox(height: 0);
    }
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: widget.divideHeight,
            color: widget.divideColor,
          ),
          SizedBox(height: itemHeight),
          Container(
            width: double.infinity,
            height: widget.divideHeight,
            color: widget.divideColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    if (widget.secData == null) {
      return _buildOne();
    } else {
      return Row(
        children: <Widget>[
          Expanded(child: _buildOne()),
          Expanded(child: _buildSec()),
        ],
      );
    }
  }

  PageView _buildOne() {
    return PageView.builder(
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (widget.onSelected != null) {
          widget.onSelected?.call(_selectedIndex);
        }
      },
      controller: pageController,
      itemBuilder: (context, index) => _buildItem(context, index),
      scrollDirection: Axis.vertical,
      itemCount: widget.data.length,
    );
  }

  PageView _buildSec() {
    return PageView.builder(
      onPageChanged: (index) {
        setState(() {
          _secSelectedIndex = index;
        });
        if (widget.onSecSelected != null) {
          widget.onSecSelected?.call(_secSelectedIndex);
        }
      },
      controller: secPageController,
      itemBuilder: (context, index) => _buildSecItem(context, index),
      scrollDirection: Axis.vertical,
      itemCount: widget.data.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      height: itemHeight,
      alignment: Alignment.center,
      child: Text(
        widget.data.elementAt(index),
        style: _selectedIndex == index
            ? widget.selectedTextStyle
            : widget.unSelectedTextStyle,
      ),
    );
  }

  Widget _buildSecItem(BuildContext context, int index) {
    String name = '';
    if (widget.secData != null && widget.secData!.length > index) {
      name = widget.secData?.elementAt(index) ?? '';
    }
    return Container(
      height: itemHeight,
      alignment: Alignment.center,
      child: Text(
        name,
        style: _secSelectedIndex == index
            ? widget.selectedTextStyle
            : widget.unSelectedTextStyle,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
