import 'package:flutter/material.dart';

/**
 * @feature: PageView를 사용하면서 페이지의 상태를 유지하기 위한 위젯이다.
 * @author: 2023/02/14 4:03 PM donghwishin
 *
 * @exampel:{
 *  PageView(child: Text("Hello World"));
 * }
 */
class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
