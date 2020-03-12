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
    return Container(
      width: 70.0,
      height: 70.0,
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 30.0,
        child: ClipOval(
          child: Hero(
            tag: 'image_$id',
            child: AspectRatio(
              aspectRatio: 1,
              child: image != null
                  ? _FileImage(image)
                  : Image.asset('assets/images/selectImagePlaceholder.png',
                      fit: BoxFit.fitHeight),
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

class _FileImage extends StatefulWidget {
  final String imagePath;

  _FileImage(this.imagePath) : assert(imagePath != null);

  @override
  __FileImageState createState() => __FileImageState();
}

class __FileImageState extends State<_FileImage> {
  bool _isExist = true;
  File _image;

  @override
  void initState() {
    _setImage();
    super.initState();
  }

  Future _setImage() async {
    final image = File(widget.imagePath);
    final isExist = await image.exists();

    setState(() {
      _isExist = isExist;
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isExist && _image != null
        ? Image.file(_image, fit: BoxFit.fitWidth)
        // TODO: chanage placeholder to 'image not exist';
        : Image.asset('assets/images/selectImagePlaceholder.png',
            fit: BoxFit.fitHeight);
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
