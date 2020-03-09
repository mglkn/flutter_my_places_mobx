import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../store/place_form.dart';
import 'widgets/widgets.dart';
import '../../data/db.dart';

class PlaceFormScreen extends StatefulWidget {
  static String routeName = '/place_form';
  final Place place;

  PlaceFormScreen({this.place});

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  @override
  void initState() {
    Modular.get<PlaceFormStore>().init(widget.place);
    super.initState();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return Scaffold(
      appBar: _appBarBuild(store),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Save'),
        elevation: 3.0,
        onPressed: () async {
          final result = await store.savePlace();
          if (result) Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _focusReset(context),
          child: PlaceForm(),
        ),
      ),
    );
  }

  _appBarBuild(PlaceFormStore store) {
    return AppBar(
      title: Observer(
        builder: (_) => Text(
          store.place != null ? store.place.name : 'New Place',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      iconTheme: IconThemeData(color: Colors.grey[700]),
      elevation: 0.0,
    );
  }
}

class PlaceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageSelector(),
          NameInput(),
          TypeInput(),
          AddressInput(),
          const SizedBox(height: 20.0),
          RatingInput(),
        ],
      ),
    );
  }
}
