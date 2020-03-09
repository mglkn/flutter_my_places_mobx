import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../store/stores.dart';

class RatingInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Modular.get<PlaceFormStore>();

    return RatingBar(
      initialRating: store.rate?.toDouble() ?? 0,
      minRating: 0,
      itemCount: 5,
      allowHalfRating: false,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.black45,
      ),
      direction: Axis.horizontal,
      onRatingUpdate: (rating) {
        store.rate = rating.toInt();
      },
      itemSize: 35.0,
      unratedColor: Colors.grey[400],
      glow: false,
      // ignoreGestures: true,
    );
  }
}
