import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  static String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuild(),
      body: Center(
        child: Text('map screen'),
      ),
    );
  }

  _appBarBuild() {
    return AppBar(
      title: Text(
        'Map',
        style: TextStyle(color: Colors.grey[700]),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      iconTheme: IconThemeData(color: Colors.grey[700]),
      elevation: 0.0,
    );
  }
}
