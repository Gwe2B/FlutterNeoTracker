import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:master_neo/api_calls.dart';

import 'model/neo.dart';

class DetailedView extends StatefulWidget {
  final NEO object;
  const DetailedView({Key? key, required this.object}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  static const double viewPadding = 8.0;

  late Future<List<String>> neoImagesUri;

  @override
  void initState() {
    super.initState();
    neoImagesUri = ApiCalls.fetchImagesUri(widget.object.shortName);
  }

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

    double anl =
        (double.parse(widget.object.orbitalInfo.ascendingNodeLongitude) * 100)
                .roundToDouble() /
            100;
    double eccentriciti =
        (double.parse(widget.object.orbitalInfo.eccentricity) * 100)
                .roundToDouble() /
            100;
    double inclination =
        (double.parse(widget.object.orbitalInfo.inclination) * 100)
                .roundToDouble() /
            100;
    double sma = (double.parse(widget.object.orbitalInfo.semiMajorAxis) * 100)
            .roundToDouble() /
        100;

    return Scaffold(
      appBar: AppBar(title: const Text('Near Earth Object')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(viewPadding),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - (2 * viewPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.object.name,
                maxLines: 2,
                style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                'id: ${widget.object.id}',
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              RichText(
                  maxLines: 3,
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
                            style: textTheme.bodyMedium),
                      ])),
              Accordion(
                  maxOpenSections: 2,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      leftIcon: SvgPicture.asset(
                        'assets/orbit.svg',
                        width: 32,
                      ),
                      header: const Text(
                        'Orbital Informations',
                        maxLines: 2,
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                text: TextSpan(text: 'Firt seen: ', children: [
                                  TextSpan(
                                      text: widget.object.orbitalInfo
                                          .getFormattedFirstSeenDate())
                                ]),
                              ),
                              RichText(
                                text: TextSpan(text: 'Last seen: ', children: [
                                  TextSpan(
                                      text: widget.object.orbitalInfo
                                          .getFormattedLastSeenDate())
                                ]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Semi-major Axis: ',
                                    children: [TextSpan(text: '$sma (A.U.)')]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Eccentriciti: ',
                                    children: [
                                      TextSpan(text: eccentriciti.toString())
                                    ]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Inclination: ',
                                    children: [
                                      TextSpan(text: '$inclination°')
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'ANL: ',
                                    children: [TextSpan(text: '$anl°')]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                    ),
                    AccordionSection(
                      header: const Text(
                        'Approach Datas',
                        maxLines: 2,
                      ),
                      content: const Text('Lorem Ipsum Dolor Sin Amet'),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                    )
                  ]),
              Text(
                'Gallery',
                style: textTheme.bodyLarge,
              ),
              //Make a GridView
              FutureBuilder<List<String>>(
                  future: neoImagesUri,
                  builder: ((context, snapshot) {
                    Widget retour = const Center(child: CircularProgressIndicator());

                    if (snapshot.hasData) {
                      retour = GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: ((context, index) {
                          return Image.network(snapshot.data!.elementAt(index));
                        }),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      );
                    } else if (snapshot.hasError) {
                      retour = Text('${snapshot.error}');
                    }
                    return retour;
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
