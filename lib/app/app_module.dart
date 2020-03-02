import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ui/screens/screens.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(PlacesListScreen.routeName,
            child: (_, __) => PlacesListScreen()),
        Router(PlaceFormScreen.routeName, child: (_, __) => PlaceFormScreen()),
        Router(MapScreen.routeName, child: (_, __) => MapScreen()),
      ];

  @override
  Widget get bootstrap => App();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Places',

      debugShowCheckedModeBanner: false,

      // Routes
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
    );
  }
}
