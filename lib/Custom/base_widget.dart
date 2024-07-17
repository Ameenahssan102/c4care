import 'package:flutter/material.dart';

import '../values/values.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final GlobalKey<ScaffoldState>? keyScafold;
  final bool? resizeToAvoidBottomInset;

  const BaseWidget(
      {Key? key,
      required this.child,
      this.backgroundColor = AppColors.white,
      this.appBar,
      this.floatingActionButton,
      this.drawer,
      this.endDrawer,
      this.keyScafold,
      this.resizeToAvoidBottomInset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: keyScafold,
        drawer: drawer,
        endDrawer: endDrawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        backgroundColor: backgroundColor,
        body: SafeArea(child: child),
      ),
    );
  }
}
