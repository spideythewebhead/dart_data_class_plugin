// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'json_key.dart';

class _$PostImpl extends Post {
  _$PostImpl({
    required this.id,
    required this.title,
  }) : super.ctor();

  @override
  final String id;

  @override
  final String title;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Post && runtimeType == other.runtimeType && id == other.id && title == other.title;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      id,
      title,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'Post{<optimized out>}';
    assert(() {
      toStringOutput = 'Post@<$hexIdentity>{id: $id, title: $title}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => Post;
}

abstract interface class _PostCopyWithProxy {
  Post id(String newValue);

  Post title(String newValue);

  Post call({
    final String? id,
    final String? title,
  });
}

class _PostCopyWithProxyImpl implements _PostCopyWithProxy {
  _PostCopyWithProxyImpl(this._value);

  final Post _value;

  @pragma('vm:prefer-inline')
  @override
  Post id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  Post title(String newValue) => this(title: newValue);

  @pragma('vm:prefer-inline')
  @override
  Post call({
    final String? id,
    final String? title,
  }) {
    return _$PostImpl(
      id: id ?? _value.id,
      title: title ?? _value.title,
    );
  }
}

sealed class $PostCopyWithProxyChain<$Result> {
  factory $PostCopyWithProxyChain(final Post value, final $Result Function(Post update) chain) =
      _PostCopyWithProxyChainImpl<$Result>;

  $Result id(String newValue);

  $Result title(String newValue);

  $Result call({
    final String? id,
    final String? title,
  });
}

class _PostCopyWithProxyChainImpl<$Result> implements $PostCopyWithProxyChain<$Result> {
  _PostCopyWithProxyChainImpl(this._value, this._chain);

  final Post _value;
  final $Result Function(Post update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result title(String newValue) => this(title: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? id,
    final String? title,
  }) {
    return _chain(_$PostImpl(
      id: id ?? _value.id,
      title: title ?? _value.title,
    ));
  }
}

extension $PostExtension on Post {
  _PostCopyWithProxy get copyWith => _PostCopyWithProxyImpl(this);
}

extension $GetPostsResponse on GetPostsResponse {
  R when<R>({
    required R Function() error,
    required R Function(GetPostsResponseOk value) ok,
  }) {
    if (this is GetPostsResponseError) {
      return error();
    }
    if (this is GetPostsResponseOk) {
      return ok(this as GetPostsResponseOk);
    }
    throw UnimplementedError('$runtimeType is not generated by this plugin');
  }

  R maybeWhen<R>({
    R Function()? error,
    R Function(GetPostsResponseOk value)? ok,
    required R Function() orElse,
  }) {
    if (error != null && this is GetPostsResponseError) {
      return error();
    }
    if (ok != null && this is GetPostsResponseOk) {
      return ok(this as GetPostsResponseOk);
    }
    return orElse();
  }
}

class GetPostsResponseError extends GetPostsResponse {
  GetPostsResponseError() : super._();

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GetPostsResponseError && runtimeType == other.runtimeType;
  }

  @override
  String toString() {
    String toStringOutput = 'GetPostsResponseError{<optimized out>}';
    assert(() {
      toStringOutput = 'GetPostsResponseError@<$hexIdentity>{}';
      return true;
    }());
    return toStringOutput;
  }
}

class GetPostsResponseOk extends GetPostsResponse {
  GetPostsResponseOk(
    List<Post> posts, {
    required this.authorName,
  })  : _posts = posts,
        super._();

  List<Post> get posts => List<Post>.unmodifiable(_posts);
  final List<Post> _posts;

  final String authorName;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'posts_array': <dynamic>[
        for (final Post i0 in posts) i0.toJson(),
      ],
      'author-name': authorName,
    };
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      authorName,
    ]);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GetPostsResponseOk &&
            runtimeType == other.runtimeType &&
            deepEquality(posts, other.posts) &&
            authorName == other.authorName;
  }

  @override
  String toString() {
    String toStringOutput = 'GetPostsResponseOk{<optimized out>}';
    assert(() {
      toStringOutput = 'GetPostsResponseOk@<$hexIdentity>{posts: $posts, authorName: $authorName}';
      return true;
    }());
    return toStringOutput;
  }
}
