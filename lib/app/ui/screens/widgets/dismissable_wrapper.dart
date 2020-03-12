import 'dart:async';
import 'package:async/async.dart' show StreamGroup;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../data/db.dart';
import '../../../data/db_repository.dart';
import '../../../store/stores.dart';

// TODO: revise (ui or code) for more comfortable dismiss
class DismissibleWrapper extends StatefulWidget {
  final Widget child;
  final Place place;
  final Key key;
  final repo = Modular.get<DbDataRepository>();
  final deleteDelay = const Duration(milliseconds: 2000);
  final showSnackBarDelay = const Duration(milliseconds: 1700);
  final placeListStore = Modular.get<PlaceListStore>();

  DismissibleWrapper({this.key, this.child, this.place});

  @override
  _DismissibleWrapperState createState() => _DismissibleWrapperState();
}

class _DismissibleWrapperState extends State<DismissibleWrapper> {
  StreamController streamControllerCancel;
  StreamController streamControllerDone;
  StreamSubscription resultStream;

  void _closeStreams() {
    resultStream?.cancel();
    streamControllerCancel?.close();
    streamControllerDone?.close();
  }

  Stream<bool> _createStreams() {
    _closeStreams();

    streamControllerCancel = StreamController<bool>();
    streamControllerDone = StreamController<bool>();

    final streamCancel = streamControllerCancel.stream.map<bool>((_) => false);
    final streamDone = streamControllerDone.stream.asyncMap<bool>((_) async {
      await Future.delayed(widget.deleteDelay);
      return true;
    });

    return StreamGroup.merge<bool>([streamDone, streamCancel])
        .take(1)
        .asBroadcastStream();
  }

  // Create two streams (done and cancel), merge them and
  // evaluate merged stream as Future.
  // `Done` stream with delay and pass `true` value.
  // `Cancel` stream pass `false` and can called
  // through `streamControllerCancel.sink.add(null)`
  Future<bool> _onDismissed(_) async {
    if (widget.placeListStore.isDismissing) return false;

    widget.placeListStore.isDismissing = true;

    bool resultDesision;
    resultStream = _createStreams().listen(
      (bool desision) {
        resultDesision = desision;
      },
    );

    _showCancelSnackBar();

    streamControllerDone.sink.add(null);

    await resultStream.asFuture();

    if (resultDesision) {
      await widget.repo.removePlace(widget.place);
    }

    widget.placeListStore.isDismissing = false;

    return resultDesision;
  }

  _showCancelSnackBar() {
    final snackbar = SnackBar(
      duration: widget.showSnackBarDelay,
      content: Text('Are you shure?'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          streamControllerCancel.sink.add(null);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _closeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: _onDismissed,
      key: widget.key,
      child: widget.child,
    );
  }
}
