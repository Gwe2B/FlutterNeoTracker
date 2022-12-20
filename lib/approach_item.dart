import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:master_neo/model/approach_data.dart';

class ApproachItem extends StatelessWidget {
  final ApproachData appData;
  static final Map<String, String> apiToPlanetsName = {
    'Earth': 'Earth',
    'Juptr': 'Jupiter',
    'Merc': 'Mercury',
    'Mars': 'Mars',
    'Nept': 'Neptune',
    'Saturn': 'Saturn',
    'Uranus': 'Uranus',
    'Venus': 'Venus'
  };

  const ApproachItem({Key? key, required this.appData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
                text: TextSpan(text: "Arround: ", children: [
              WidgetSpan(
                  child: SvgPicture.asset(
                'assets/planets-icons/${appData.orbitingObject.toLowerCase()}.svg',
                width: 16,
              )),
              TextSpan(
                  text: ApproachItem.apiToPlanetsName[appData.orbitingObject]),
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text:
                      "Approach Date: ${appData.date.day}/${appData.date.month}/${appData.date.year}")
            ]))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.speed_outlined,
                  size: 16,
                )),
                TextSpan(
                    text:
                        'Relative Speed: ${(appData.relativeVelocity * 100).ceilToDouble() / 100} km/s')
              ])),
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(
                    child: SvgPicture.asset(
                  'assets/distance.svg',
                  width: 16,
                )),
                TextSpan(
                    text:
                        'Distance: ${(appData.missDistance * 100).ceilToDouble() / 100} (A.U.)')
              ]))
            ],
          )
        ],
      ),
    ));
  }
}
