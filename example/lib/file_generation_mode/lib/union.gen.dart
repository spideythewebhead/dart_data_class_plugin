// AUTO GENERATED - DO NOT MODIFY

part of 'union.dart';

extension $GetUserResult on GetUserResult {
  R when<R>({
    required R Function(GetUserResultData value) data,
    required R Function(GetUserResultError value) error,
  }) {
    if (this is GetUserResultData) {
      return data(this as GetUserResultData);
    }
    if (this is GetUserResultError) {
      return error(this as GetUserResultError);
    }
    throw UnimplementedError('$runtimeType is not generated by this plugin');
  }

  R maybeWhen<R>({
    R Function(GetUserResultData value)? data,
    R Function(GetUserResultError value)? error,
    required R Function() orElse,
  }) {
    if (data != null && this is GetUserResultData) {
      return data(this as GetUserResultData);
    }
    if (error != null && this is GetUserResultError) {
      return error(this as GetUserResultError);
    }
    return orElse();
  }
}

GetUserResult _$GetUserResultFromJson(Map<dynamic, dynamic> json) {
  switch (json['code']) {
    case 'ok':
      return GetUserResultData.fromJson(json);
    default:
      return GetUserResultError.fromJson(json);
  }
}

class GetUserResultData extends GetUserResult {
  GetUserResultData({
    required this.user,
  }) : super._();

  final User user;

  factory GetUserResultData.fromJson(Map<dynamic, dynamic> json) {
    return GetUserResultData(
      user: User.fromJson(json['user']),
    );
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      user,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is GetUserResultData && runtimeType == other.runtimeType && user == other.user;
  }

  @override
  String toString() {
    String toStringOutput = 'GetUserResultData{<optimized out>}';
    assert(() {
      toStringOutput = 'GetUserResultData@<$hexIdentity>{user: $user}';
      return true;
    }());
    return toStringOutput;
  }
}

class GetUserResultError extends GetUserResult {
  GetUserResultError({
    required this.statusCode,
    this.message,
  }) : super._();

  final int statusCode;

  final String? message;

  factory GetUserResultError.fromJson(Map<dynamic, dynamic> json) {
    return GetUserResultError(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
    );
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      statusCode,
      message,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is GetUserResultError &&
            runtimeType == other.runtimeType &&
            statusCode == other.statusCode &&
            message == other.message;
  }

  @override
  String toString() {
    String toStringOutput = 'GetUserResultError{<optimized out>}';
    assert(() {
      toStringOutput =
          'GetUserResultError@<$hexIdentity>{statusCode: $statusCode, message: $message}';
      return true;
    }());
    return toStringOutput;
  }
}
