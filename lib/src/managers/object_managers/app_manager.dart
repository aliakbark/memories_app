import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

class AppManager {
  AppInfo _appInfo;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<AppInfo> init() async {
    if (_appInfo != null) return _appInfo;
    _appInfo = AppInfo();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
      _appInfo.deviceInfo = DeviceInfo(
          device: deviceData.brand,
          deviceModel: deviceData.model,
          osInfo: Platform.operatingSystem,
          deviceVersion:
              '${deviceData.version.release}/${deviceData.version.sdkInt}/${deviceData.version.securityPatch}',
          deviceId: deviceData.androidId);
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceData = await deviceInfoPlugin.iosInfo;
      _appInfo.deviceInfo = DeviceInfo(
          device: deviceData.name,
          deviceModel: deviceData.model,
          osInfo: Platform.operatingSystem,
          deviceVersion: deviceData.systemVersion,
          deviceId: deviceData.identifierForVendor);
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appInfo.appPackageInfo = AppPackageInfo(
        appName: packageInfo.appName,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
        buildNumber: packageInfo.buildNumber);
    return _appInfo;
  }

  Future<AppInfo> get appInfo async {
    if (_appInfo != null) return _appInfo;

    _appInfo = await init();
    return _appInfo;
  }
}

class AppInfo {
  AppInfo({
    this.deviceInfo,
    this.appPackageInfo,
  });

  DeviceInfo deviceInfo;
  AppPackageInfo appPackageInfo;
}

class DeviceInfo {
  DeviceInfo({
    @required this.device,
    @required this.deviceModel,
    @required this.osInfo,
    @required this.deviceVersion,
    @required this.deviceId,
  });

  String device;
  String deviceModel;
  String osInfo;
  String deviceVersion;
  String deviceId;

  @override
  String toString() {
    return '$device/$deviceModel/$osInfo/$deviceVersion';
  }
}

class AppPackageInfo {
  AppPackageInfo({
    @required this.appName,
    @required this.packageName,
    @required this.version,
    @required this.buildNumber,
  });

  String appName;
  String packageName;
  String version;
  String buildNumber;

  @override
  String toString() {
    return '$appName/$packageName/$version/$buildNumber';
  }
}
