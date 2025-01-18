enum Flavor {
  free,
  pro,
}

class FlavorConfig {
  static late Flavor flavor;

  static void setFlavor(String flavorValue) {
    flavor = Flavor.values.firstWhere(
      (element) => element.toString().split('.').last == flavorValue,
      orElse: () => Flavor.free,
    );
  }
}
