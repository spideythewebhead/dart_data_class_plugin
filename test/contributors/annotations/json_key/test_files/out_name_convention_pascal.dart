@DataClass(
  fromJson: true,
  toJson: true,
  copyWith: false,
  hashAndEquals: false,
  $toString: false,
)
class User {
  /// Shorthand constructor
  User({
    required this.thisIsATestVariable,
  });

  @JsonKey<String>(nameConvention: JsonKeyNameConvention.pascalCase)
  final String thisIsATestVariable;

  /// Converts [User] to a [Map] json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ThisIsATestVariable': thisIsATestVariable,
    };
  }

  /// Creates an instance of [User] from [json]
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      thisIsATestVariable: json['ThisIsATestVariable'] as String,
    );
  }
}
