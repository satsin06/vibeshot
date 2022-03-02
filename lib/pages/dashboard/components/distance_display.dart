import 'package:flutter/material.dart';

class DistanceDisplayer extends StatelessWidget {
  final double distance;

  const DistanceDisplayer({
    Key? key,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on),
        const SizedBox(
          width: 5,
        ),
        Text('$distance miles away')
      ],
    );
  }
}
