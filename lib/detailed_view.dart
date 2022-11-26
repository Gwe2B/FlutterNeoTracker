import 'package:flutter/material.dart';

import 'model/neo.dart';

class DetailedView extends StatefulWidget {
  final NEO object;
  const DetailedView({Key? key, required this.object}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double minDiameter =
        (widget.object.estimatedDiameter.getMinDiameterInKilometers() * 100)
                .roundToDouble() /
            100;
    double maxDiameter =
        (widget.object.estimatedDiameter.getMaxDiameterInKilometers() * 100)
                .roundToDouble() /
            100;

    return Scaffold(
      appBar: AppBar(title: const Text('Near Earth Object')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.object.name,
              overflow: TextOverflow.clip,
              style: textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'id: ${widget.object.id}',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            RichText(
              overflow: TextOverflow.clip,
                text:
                    TextSpan(text: 'Ø', style: textTheme.bodyLarge, children: [
              TextSpan(
                  text: 'Min. : ${minDiameter.toString()}km; ',
                  style: textTheme.bodyMedium),
              TextSpan(text: 'Ø', style: textTheme.bodyLarge),
              TextSpan(
                  text: 'Max. : ${maxDiameter.toString()}km',
                  style: textTheme.bodyMedium)
            ]))
          ],
        ),
      ),
    );
  }
}
