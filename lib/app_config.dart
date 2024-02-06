import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

class AppConfig {
  static bool isStaging = kDebugMode;
  static bool isProfile = kProfileMode;
  static bool isRelease = kReleaseMode;
  // TODO
  static String baseStagingUrl = "https://admin-staging.****.com";
  static String betaProfileUrl = 'https://d10ekrzdzzpe83.*******.net/';
  static String baseProductionUrl = "https://admin.****************.com";

  //
  static String get authBaseUrl {
    return "${isRelease ? baseProductionUrl : isProfile ? betaProfileUrl : baseStagingUrl}/api/v1/auth";
  }

  static String get apiBaseUrl {
    return "${isRelease ? baseProductionUrl : isProfile ? betaProfileUrl : baseStagingUrl}/api/v1/";
  }

  static PackageInfo? packageInfo; // app version will be assigned later in below method

  static String get appVersion {
    if (kDebugMode) {
      return "${packageInfo?.version ?? ""} (${packageInfo?.buildNumber ?? ""})";
    } else if (kProfileMode) {
      return "${packageInfo?.version ?? ""} (${packageInfo?.buildNumber ?? ""})";
    } else {
      return packageInfo?.version ?? "";
    }
  }
}
