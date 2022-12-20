import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:file_generation_mode/data_class.dart';

part 'union.gen.dart';

@Union(
  fromJson: true,
  unionJsonKey: 'code',
  unionFallbackJsonValue: 'error',
)
abstract class GetUserResult {
  const GetUserResult._();

  /// Creates an instance of [GetUserResult] from [json]
  factory GetUserResult.fromJson(Map<dynamic, dynamic> json) => _$GetUserResultFromJson(json);

  @UnionJsonKeyValue('ok')
  factory GetUserResult.data({
    required User user,
  }) = _GetUserResultData;

  @UnionJsonKeyValue('error')
  factory GetUserResult.error({
    Exception? exception,
    String? message,
  }) = _GetUserResultError;
}
