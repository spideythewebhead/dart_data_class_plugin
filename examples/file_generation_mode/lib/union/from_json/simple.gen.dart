// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// coverage:ignore-file

part of 'simple.dart';

class _$PostImpl extends Post {
  _$PostImpl({
    required this.id,
    required this.title,
  }) : super.ctor();

  @override
  final String id;

  @override
  final String title;

  factory _$PostImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$PostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  @override
  bool operator ==(Object? other) {
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

class _$PostCopyWithProxy {
  _$PostCopyWithProxy(this._value);

  final Post _value;

  @pragma('vm:prefer-inline')
  Post id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  Post title(String newValue) => this(title: newValue);

  @pragma('vm:prefer-inline')
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

class $PostCopyWithProxyChain<$Result> {
  $PostCopyWithProxyChain(this._value, this._chain);

  final Post _value;
  final $Result Function(Post update) _chain;

  @pragma('vm:prefer-inline')
  $Result id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  $Result title(String newValue) => this(title: newValue);

  @pragma('vm:prefer-inline')
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
  _$PostCopyWithProxy get copyWith => _$PostCopyWithProxy(this);
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

GetPostsResponse _$GetPostsResponseFromJson(Map<dynamic, dynamic> json) {
  switch (json['code']) {
    case 'ok':
      return GetPostsResponseOk.fromJson(json);
    default:
      return GetPostsResponseError.fromJson(json);
  }
}

class GetPostsResponseError extends GetPostsResponse {
  GetPostsResponseError() : super._();

  factory GetPostsResponseError.fromJson(Map<dynamic, dynamic> json) {
    return GetPostsResponseError();
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  bool operator ==(Object? other) {
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
    List<Post> posts,
  )   : _posts = posts,
        super._();

  List<Post> get posts => List<Post>.unmodifiable(_posts);
  final List<Post> _posts;

  factory GetPostsResponseOk.fromJson(Map<dynamic, dynamic> json) {
    return GetPostsResponseOk(
      <Post>[
        for (final dynamic i0 in (json['posts'] as List<dynamic>)) Post.fromJson(i0),
      ],
    );
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is GetPostsResponseOk &&
            runtimeType == other.runtimeType &&
            deepEquality(posts, other.posts);
  }

  @override
  String toString() {
    String toStringOutput = 'GetPostsResponseOk{<optimized out>}';
    assert(() {
      toStringOutput = 'GetPostsResponseOk@<$hexIdentity>{posts: $posts}';
      return true;
    }());
    return toStringOutput;
  }
}
