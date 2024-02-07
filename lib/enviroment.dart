import 'package:test_app/core/constants/contants.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';

  late BaseEnvConfig config;

  initConfig(String environment) => config = _getConfig(environment);

  BaseEnvConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.DEV:
        return DevConfig();
      default:
        return DevConfig();
    }
  }
}

abstract class BaseEnvConfig {
  String get env;

  String get apiHost;

  bool get useHttps;
}

class DevConfig implements BaseEnvConfig {
  @override
  String get env => Environment.DEV;

  @override
  String get apiHost => BASE_DEV_API_URL;

  @override
  bool get useHttps => false;
}
