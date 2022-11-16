import 'package:data_class_plugin/data_class_plugin.dart';

@Union(
  dataClass: true,
  fromJson: false,
  toJson: false,
)
class AsyncResult<T> {
  const AsyncResult._();

  const factory AsyncResult.data({
    required T data,
  }) = AsyncResultData<T>;

  const factory AsyncResult.loading() = AsyncResultLoading<T>;

  const factory AsyncResult.error({
    required Object error,
    StackTrace? stackTrace,
  }) = AsyncResultError<T>;
}
