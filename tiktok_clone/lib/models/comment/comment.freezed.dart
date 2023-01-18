// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get username => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get datePublished => throw _privateConstructorUsedError;
  List<dynamic> get likes => throw _privateConstructorUsedError;
  String get profilePhoto => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {String username,
      String comment,
      @TimestampConverter() DateTime datePublished,
      List<dynamic> likes,
      String profilePhoto,
      String uid,
      String id});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? comment = null,
    Object? datePublished = null,
    Object? likes = null,
    Object? profilePhoto = null,
    Object? uid = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      datePublished: null == datePublished
          ? _value.datePublished
          : datePublished // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$_CommentCopyWith(
          _$_Comment value, $Res Function(_$_Comment) then) =
      __$$_CommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String comment,
      @TimestampConverter() DateTime datePublished,
      List<dynamic> likes,
      String profilePhoto,
      String uid,
      String id});
}

/// @nodoc
class __$$_CommentCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$_Comment>
    implements _$$_CommentCopyWith<$Res> {
  __$$_CommentCopyWithImpl(_$_Comment _value, $Res Function(_$_Comment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? comment = null,
    Object? datePublished = null,
    Object? likes = null,
    Object? profilePhoto = null,
    Object? uid = null,
    Object? id = null,
  }) {
    return _then(_$_Comment(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      datePublished: null == datePublished
          ? _value.datePublished
          : datePublished // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment extends _Comment {
  _$_Comment(
      {required this.username,
      required this.comment,
      @TimestampConverter() required this.datePublished,
      required final List<dynamic> likes,
      required this.profilePhoto,
      required this.uid,
      required this.id})
      : _likes = likes,
        super._();

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  final String username;
  @override
  final String comment;
  @override
  @TimestampConverter()
  final DateTime datePublished;
  final List<dynamic> _likes;
  @override
  List<dynamic> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  @override
  final String profilePhoto;
  @override
  final String uid;
  @override
  final String id;

  @override
  String toString() {
    return 'Comment(username: $username, comment: $comment, datePublished: $datePublished, likes: $likes, profilePhoto: $profilePhoto, uid: $uid, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Comment &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.datePublished, datePublished) ||
                other.datePublished == datePublished) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, comment, datePublished,
      const DeepCollectionEquality().hash(_likes), profilePhoto, uid, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      __$$_CommentCopyWithImpl<_$_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(
      this,
    );
  }
}

abstract class _Comment extends Comment {
  factory _Comment(
      {required final String username,
      required final String comment,
      @TimestampConverter() required final DateTime datePublished,
      required final List<dynamic> likes,
      required final String profilePhoto,
      required final String uid,
      required final String id}) = _$_Comment;
  _Comment._() : super._();

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String get username;
  @override
  String get comment;
  @override
  @TimestampConverter()
  DateTime get datePublished;
  @override
  List<dynamic> get likes;
  @override
  String get profilePhoto;
  @override
  String get uid;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
