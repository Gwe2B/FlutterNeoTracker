class ApproachData {
  final DateTime date;

  /// In Km/h
  final double relativeVelocity;

  /// In AU (Astonomical Unit)
  final double missDistance;
  final String orbitingObject;

  const ApproachData(
      {required this.date,
      required this.relativeVelocity,
      required this.missDistance,
      required this.orbitingObject});
}
