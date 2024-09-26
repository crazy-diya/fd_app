class IPAddress {
  static const String dev = "finnhub.io/";
}

class ServiceProtocol {
  static const String dev = "https://";
}

class ContextRoot {
  static const String dev = "api/v1/news";
}

class NetworkConfig {
  static String getNetworkConfig() {
    return _getServiceProtocol() + _getIpAddress() + _getContextRoot();
  }

  static String _getIpAddress() {
    return IPAddress.dev;
  }

  static String _getContextRoot() {
    return ContextRoot.dev;
  }

  static String _getServiceProtocol() {
    return ServiceProtocol.dev;
  }
}
