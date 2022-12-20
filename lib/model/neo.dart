import 'package:flutter/cupertino.dart';
import 'package:master_neo/model/approach_data.dart';
import 'package:master_neo/model/neo_diameter.dart';
import 'package:master_neo/model/orbit.dart';

class NEO {
  final int id;
  final String name;
  final String shortName;
  final double absoluteMagnitude;
  final NeoDiameter estimatedDiameter;
  final bool isPotentiallyHazardous;
  final List<ApproachData> closeApproach;
  final Orbit orbitalInfo;
  final bool isSentryObject;

  const NEO(
      {required this.id,
      required this.name,
      required this.shortName,
      required this.absoluteMagnitude,
      required this.estimatedDiameter,
      required this.isPotentiallyHazardous,
      required this.closeApproach,
      required this.orbitalInfo,
      required this.isSentryObject});

  factory NEO.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> buf = json['estimated_diameter'];
    Map<String, dynamic> estimatedDiameter = buf['meters'];
    Map<String, dynamic> orbitalData = json['orbital_data'];
    List<dynamic> appDataBuf = json['close_approach_data'];

    List<ApproachData> appData = List.empty(growable: true);
    for (var element in appDataBuf) {
      Map<String, dynamic> velocity = element['relative_velocity'];
      Map<String, dynamic> missDistance = element['miss_distance'];

      appData.add(ApproachData(
          date: DateTime.parse(element['close_approach_date']),
          relativeVelocity: double.parse(velocity['kilometers_per_second']),
          missDistance: double.parse(missDistance['astronomical']),
          orbitingObject: element['orbiting_body']));
    }

    return NEO(
        id: int.parse(json['id']),
        name: json['name'],
        shortName: json['name_limited'],
        absoluteMagnitude: json['absolute_magnitude_h'],
        estimatedDiameter: NeoDiameter(
          min: estimatedDiameter['estimated_diameter_min'],
          max: estimatedDiameter['estimated_diameter_max'],
        ),
        isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'],
        orbitalInfo: Orbit(
          id: orbitalData['orbit_id'],
          orbitDetermination:
              DateTime.parse(orbitalData['orbit_determination_date']),
          firstObservation:
              DateTime.parse(orbitalData['first_observation_date']),
          lastObservation: DateTime.parse(orbitalData['last_observation_date']),
          arcInDays: orbitalData['data_arc_in_days'],
          uncertainty: orbitalData['orbit_uncertainty'],
          minimumOrbitIntersection: orbitalData['minimum_orbit_intersection'],
          epochOsculation: orbitalData['epoch_osculation'],
          eccentricity: orbitalData['eccentricity'],
          semiMajorAxis: orbitalData['semi_major_axis'],
          inclination: orbitalData['inclination'],
          ascendingNodeLongitude: orbitalData['ascending_node_longitude'],
          orbitalPeriod: orbitalData['orbital_period'],
        ),
        closeApproach: appData,
        isSentryObject: json['is_sentry_object']);
  }
}
