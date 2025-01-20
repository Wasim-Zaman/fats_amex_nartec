import 'package:package_info_plus/package_info_plus.dart' as package_info;

class PackageInfo {
  static final PackageInfo _instance = PackageInfo._internal();

  late final String _appName;
  late final String _packageName;
  late final String _version;
  late final String _buildNumber;

  PackageInfo._internal();

  static PackageInfo get instance => _instance;

  Future<void> init() async {
    final info = await package_info.PackageInfo.fromPlatform();
    _appName = info.appName;
    _packageName = info.packageName;
    _version = info.version;
    _buildNumber = info.buildNumber;
  }

  String get appName => _appName;
  String get packageName => _packageName;
  String get version => _version;
  String get buildNumber => _buildNumber;
}
