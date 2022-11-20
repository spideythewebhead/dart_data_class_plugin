import 'package:data_class_plugin/data_class_plugin.dart';

@DataClass(
  toJson: false,
  fromJson: true,
  copyWith: false,
  hashAndEquals: false,
  $toString: false,
)
class User {
  /// Shorthand constructor
  User({
    required this.id,
    required this.username,
  });

  final String id;

  @JsonKey<String>(fromJson: _usernameConverter)
  final String username;

  static String _usernameConverter(Map<dynamic, dynamic> json) {
    return json['username'] ?? json['uname'];
  }
}
