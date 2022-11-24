class NeoDiameter {
  /// Minimum diameter of the NEO in meters
  final double min;

  /// Maximum diameter of the NEO in meters
  final double max;

  const NeoDiameter({required this.min, required this.max});

  double getMinDiameterInKilometers() {
    return min / 1000;
  }

  double getMaxDiameterInKilometers() {
    return max / 1000;
  }
}
