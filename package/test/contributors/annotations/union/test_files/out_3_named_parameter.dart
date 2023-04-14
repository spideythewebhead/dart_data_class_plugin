part 'in_3_named_parameter.gen.dart';

@Union()
abstract class AsyncResult {
  const AsyncResult._();

  factory AsyncResult.data({required int data}) = AsyncResultData;
  factory AsyncResult.error({required Object error}) = AsyncResultError;
}
