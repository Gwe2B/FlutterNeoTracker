class Orbit {
  final String id;
  final DateTime orbitDetermination;
  final DateTime firstObservation;
  final DateTime lastObservation;
  final int arcInDays;
  final String uncertainty;
  final String minimumOrbitIntersection;
  final String epochOsculation;
  final String eccentricity;
  final String semiMajorAxis;
  final String inclination;
  final String ascendingNodeLongitude;
  final String orbitalPeriod;

  const Orbit(
      {required this.id,
      required this.orbitDetermination,
      required this.firstObservation,
      required this.lastObservation,
      required this.arcInDays,
      required this.uncertainty,
      required this.minimumOrbitIntersection,
      required this.epochOsculation,
      required this.eccentricity,
      required this.semiMajorAxis,
      required this.inclination,
      required this.ascendingNodeLongitude,
      required this.orbitalPeriod});
}
