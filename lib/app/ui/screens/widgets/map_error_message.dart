import 'package:flutter/material.dart';

class MapErrorMessage extends StatelessWidget {
  final String message;

  MapErrorMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
