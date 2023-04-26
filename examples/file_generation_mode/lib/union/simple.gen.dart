// AUTO GENERATED - DO NOT MODIFY

// ignore_for_file: library_private_types_in_public_api, unused_element, unused_field

part of 'simple.dart';

extension $AsyncResult on AsyncResult {
  R when<R>({
    required R Function() loading,
    required R Function(AsyncResultData value) data,
    required R Function(AsyncResultError value) error,
  }) {
    if (this is AsyncResultLoading) {
      return loading();
    }
    if (this is AsyncResultData) {
      return data(this as AsyncResultData);
    }
    if (this is AsyncResultError) {
      return error(this as AsyncResultError);
    }
    throw UnimplementedError('$runtimeType is not generated by this plugin');
  }

  R maybeWhen<R>({
    R Function()? loading,
    R Function(AsyncResultData value)? data,
    R Function(AsyncResultError value)? error,
    required R Function() orElse,
  }) {
    if (loading != null && this is AsyncResultLoading) {
      return loading();
    }
    if (data != null && this is AsyncResultData) {
      return data(this as AsyncResultData);
    }
    if (error != null && this is AsyncResultError) {
      return error(this as AsyncResultError);
    }
    return orElse();
  }
}

class AsyncResultLoading extends AsyncResult {
  const AsyncResultLoading() : super._();

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is AsyncResultLoading && runtimeType == other.runtimeType;
  }

  @override
  String toString() {
    String toStringOutput = 'AsyncResultLoading{<optimized out>}';
    assert(() {
      toStringOutput = 'AsyncResultLoading@<$hexIdentity>{}';
      return true;
    }());
    return toStringOutput;
  }
}

class AsyncResultData extends AsyncResult {
  AsyncResultData(
    this.data,
  ) : super._();

  final int data;

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      data,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is AsyncResultData && runtimeType == other.runtimeType && data == other.data;
  }

  @override
  String toString() {
    String toStringOutput = 'AsyncResultData{<optimized out>}';
    assert(() {
      toStringOutput = 'AsyncResultData@<$hexIdentity>{data: $data}';
      return true;
    }());
    return toStringOutput;
  }
}

class AsyncResultError extends AsyncResult {
  AsyncResultError(
    this.error, {
    this.stackTrace,
  }) : super._();

  final Object error;

  final StackTrace? stackTrace;

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      error,
      stackTrace,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is AsyncResultError &&
            runtimeType == other.runtimeType &&
            error == other.error &&
            stackTrace == other.stackTrace;
  }

  @override
  String toString() {
    String toStringOutput = 'AsyncResultError{<optimized out>}';
    assert(() {
      toStringOutput = 'AsyncResultError@<$hexIdentity>{error: $error, stackTrace: $stackTrace}';
      return true;
    }());
    return toStringOutput;
  }
}
