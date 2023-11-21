import 'package:flutter/material.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.body,
    this.isPadding = true,
    this.isSafeArea = true,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final Widget body;
  final bool isPadding;
  final bool isSafeArea;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final padding = isPadding
        ? Padding(
            padding: 24.all,
            child: body,
          )
        : body;
    return Scaffold(
      appBar: appBar,
      body: isSafeArea
          ? SafeArea(
              child: padding,
            )
          : padding,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
