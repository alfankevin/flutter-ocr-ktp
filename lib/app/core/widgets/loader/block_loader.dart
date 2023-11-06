import 'package:flutter/material.dart';

class BlockLoader extends StatelessWidget {
  const BlockLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }
}
