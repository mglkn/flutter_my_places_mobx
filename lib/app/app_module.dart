import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ui/screens/screens.dart';

import 'data/db_repository.dart';
import 'store/stores.dart';
import 'services/geocoder_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<DbDataRepository>((_) => DbDataRepository.db()),
        Bind<GeocoderService>((_) => GeocoderService.instance()),
        Bind<PlaceFormStore>(
            (_) => PlaceFormStore(repo: DbDataRepository.db())),
        Bind<PlaceListStore>((_) => PlaceListStore()),
      ];

  @override
  List<Router> get routers => [
        Router(PlacesListScreen.routeName,
            child: (_, __) => PlacesListScreen()),
        Router(PlaceFormScreen.routeName,
            child: (_, args) => PlaceFormScreen(place: args.data)),
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
