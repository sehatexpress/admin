import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double initial;
  final Function(double) onRatingUpdate;
  final bool isWhite;
  final double itemSize;
  final bool tap;
  const CustomRatingBar({
    super.key,
    required this.initial,
    required this.onRatingUpdate,
    this.isWhite = false,
    this.itemSize = 13,
    this.tap = true,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: initial,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: isWhite == false
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
        ),
        half: Icon(
          Icons.star_half,
          color: isWhite == false
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
        ),
        empty: Icon(
          Icons.star_border,
          color: isWhite == false
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
        ),
      ),
      ignoreGestures: tap,
      itemSize: itemSize,
      onRatingUpdate: onRatingUpdate,
    );
  }
}
