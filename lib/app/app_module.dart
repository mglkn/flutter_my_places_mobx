import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoder/geocoder.dart';

import 'ui/screens/screens.dart';

import 'data/db_repository.dart';
import 'store/place_form.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<DbDataRepository>((_) => DbDataRepository.db()),
        Bind<PlaceFormStore>(
            (_) => PlaceFormStore(repo: DbDataRepository.db())),
      ];

  @override
  List<Router> get routers => [
        Router(PlacesListScreen.routeName,
            child: (_, __) => PlacesListScreen()),
        Router(PlaceFormScreen.routeName,
            child: (_, args) => PlaceFormScreen(place: args.data)),
        Router<Address>(MapScreen.routeName, child: (_, __) => MapScreen()),
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
