// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// coverage:ignore-file

part of 'custom_json_converter.dart';

class _$LogRecordImpl extends LogRecord {
  _$LogRecordImpl({
    required this.text,
    required this.datetime,
  }) : super.ctor();

  @override
  final String text;

  @override
  final DateTime datetime;

  factory _$LogRecordImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$LogRecordImpl(
      text: json['text'] as String,
      datetime: const _DateTimeFromSecondsJsonConverter()
          .fromJson(json['timestampInSeconds'], json, 'timestampInSeconds'),
    );
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is LogRecord &&
            runtimeType == other.runtimeType &&
            text == other.text &&
            datetime == other.datetime;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      text,
      datetime,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'LogRecord{<optimized out>}';
    assert(() {
      toStringOutput = 'LogRecord@<$hexIdentity>{text: $text, datetime: $datetime}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => LogRecord;
}

class _$LogRecordCopyWithProxy {
  _$LogRecordCopyWithProxy(this._value);

  final LogRecord _value;

  @pragma('vm:prefer-inline')
  LogRecord text(String newValue) => this(text: newValue);

  @pragma('vm:prefer-inline')
  LogRecord datetime(DateTime newValue) => this(datetime: newValue);

  @pragma('vm:prefer-inline')
  LogRecord call({
    final String? text,
    final DateTime? datetime,
  }) {
    return _$LogRecordImpl(
      text: text ?? _value.text,
      datetime: datetime ?? _value.datetime,
    );
  }
}

class $LogRecordCopyWithProxyChain<$Result> {
  $LogRecordCopyWithProxyChain(this._value, this._chain);

  final LogRecord _value;
  final $Result Function(LogRecord update) _chain;

  @pragma('vm:prefer-inline')
  $Result text(String newValue) => this(text: newValue);

  @pragma('vm:prefer-inline')
  $Result datetime(DateTime newValue) => this(datetime: newValue);

  @pragma('vm:prefer-inline')
  $Result call({
    final String? text,
    final DateTime? datetime,
  }) {
    return _chain(_$LogRecordImpl(
      text: text ?? _value.text,
      datetime: datetime ?? _value.datetime,
    ));
  }
}

extension $LogRecordExtension on LogRecord {
  _$LogRecordCopyWithProxy get copyWith => _$LogRecordCopyWithProxy(this);
}
