enum BuildType {
  dev("dev"),
  prod("prod");

  final String flavor;

  const BuildType(this.flavor);

  factory BuildType.byFlavor(String flavor) {
    return values.firstWhere((t) => t.flavor == flavor, orElse: () => dev);
  }
}

class Environment {
  static final Environment _instance = Environment._internal();

  BuildType? _buildType;

  // constructors
  Environment._internal();

  factory Environment.instance({
    BuildType buildType = BuildType.dev,
  }) {
    _instance._buildType ??= buildType;
    return _instance;
  }

  // getters
  Environment get instance => _instance;
  bool get isDev => _buildType == BuildType.dev;
  bool get isProd => _buildType == BuildType.prod;
}
