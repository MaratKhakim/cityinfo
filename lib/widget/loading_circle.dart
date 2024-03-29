import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          strokeWidth: 6.0,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}