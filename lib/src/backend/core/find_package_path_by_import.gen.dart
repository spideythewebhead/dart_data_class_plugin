// AUTO GENERATED - DO NOT MODIFY

part of 'find_package_path_by_import.dart';

class _$PackageNotInstalledExceptionImpl extends PackageNotInstalledException {
  _$PackageNotInstalledExceptionImpl({
    required this.packageName,
  }) : super._();

  @override
  final String packageName;

  @override
  String toString() {
    String value = 'PackageNotInstalledException{<optimized out>}';
    assert(() {
      value =
          'PackageNotInstalledException@<$hexIdentity>{packageName: $packageName}';
      return true;
    }());
    return value;
  }
}

class _$PackageInfoImpl extends PackageInfo {
  _$PackageInfoImpl({
    required this.name,
    required this.rootUri,
    required this.packageUri,
    required this.languageVersion,
  }) : super._();

  @override
  final String name;

  @override
  final Uri rootUri;

  @override
  final Uri packageUri;

  @override
  final String languageVersion;

  factory _$PackageInfoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$PackageInfoImpl(
      name: json['name'] as String,
      rootUri:
          jsonConverterRegistrant.find(Uri).fromJson(json['rootUri']) as Uri,
      packageUri:
          jsonConverterRegistrant.find(Uri).fromJson(json['packageUri']) as Uri,
      languageVersion: json['languageVersion'] as String,
    );
  }
}
