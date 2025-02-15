abstract class EnvServer {
  const EnvServer();

  String get baseUrl;

  bool get isShowFloatingLogger;
}

class EnvDev implements EnvServer {
  const EnvDev();

  @override

  /// url development
  String get baseUrl => 'https://fakestoreapi.com';

  @override
  bool get isShowFloatingLogger => true;
}

class EnvProd implements EnvServer {
  const EnvProd();

  @override
  String get baseUrl => 'https://fakestoreapi.com';

  @override
  bool get isShowFloatingLogger => false;
}

class Env {
  const Env._();

  static const development = EnvDev();

  static const production = EnvProd();
}
