import 'package:flutter/material.dart';

class BaseLoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  final String semanticsLabel;
  final String semanticsValue;
  final double width;
  final double height;
  final Color color;
  final bool isRow;

  const BaseLoadingIndicator({
    super.key,
    this.backgroundColor = Colors.white60,
    this.semanticsLabel = 'Loading',
    this.semanticsValue = 'please wait..',
    this.width = 50,
    this.height = 50,
    this.color = Colors.black,
    this.isRow = false,
  });

  Widget _buildLoadingWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$semanticsLabel...',
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }

  Widget _buildLoadingRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 2 / 3,
          height: height * 2 / 3,
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '$semanticsLabel...',
          style: TextStyle(fontSize: 14, color: color),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: isRow
            ? _buildLoadingRowWidget(context)
            : _buildLoadingWidget(context),
      ),
    );
  }
}
