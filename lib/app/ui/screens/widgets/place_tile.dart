import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../data/db.dart';
import '../../screens/screens.dart';

class PlaceTile extends StatelessWidget {
  final Place place;

  PlaceTile(this.place);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(PlaceFormScreen.routeName, arguments: place);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border(
            top: BorderSide(
              color: Colors.grey[300],
              width: 2.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _TileImage(image: place.image, id: place.id),
            Expanded(
              child: _TileContent(place),
            ),
            _TileRate(place.rate),
          ],
        ),
      ),
    );
  }
}

class _TileImage extends StatelessWidget {
  final String image;
  final int id;

  _TileImage({this.id, this.image}) : assert(id != null);

  @override
  Widget build(BuildContext context) {
    Widget _image = image != null
        ? Image.file(File(image), fit: BoxFit.fill)
        : Image.asset('assets/images/selectImagePlaceholder.png',
            fit: BoxFit.fill);

    return Container(
      width: 70.0,
      height: 70.0,
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 30.0,
        child: Hero(
          tag: 'image_$id',
          child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: _image,
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

class _TileContent extends StatelessWidget {
  final Place place;

  _TileContent(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(place.name, style: TextStyle(fontSize: 20.0)),
          Text(place.type, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _TileRate extends StatelessWidget {
  final int rate;

  _TileRate(this.rate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: RatingBar(
        initialRating: rate?.toDouble() ?? 0,
        minRating: 0,
        itemCount: 5,
        allowHalfRating: false,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.black45,
        ),
        direction: Axis.horizontal,
        itemSize: 15.0,
        unratedColor: Colors.grey[400],
        glow: false,
        ignoreGestures: true,
        onRatingUpdate: (_) {},
      ),
    );
  }
}
