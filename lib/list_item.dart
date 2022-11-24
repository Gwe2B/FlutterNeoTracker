import 'package:flutter/material.dart';
import 'package:master_neo/model/neo.dart';

class ListItem extends StatelessWidget {
  final NEO object;

  const ListItem({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double minDiameter =
        (object.estimatedDiameter.getMinDiameterInKilometers() * 100)
                .roundToDouble() /
            100;
    double maxDiameter =
        (object.estimatedDiameter.getMaxDiameterInKilometers() * 100)
                .roundToDouble() /
            100;

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(object.name,
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text(
                object.id.toString(),
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Ø',
                      style: textTheme.bodyLarge,
                      children: [
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
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.blue,
              )),
        ],
      ),
    ));
  }
}
