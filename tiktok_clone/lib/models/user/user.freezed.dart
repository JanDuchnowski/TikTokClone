// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get profilePhoto => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  List<dynamic> get following => throw _privateConstructorUsedError;
  List<dynamic> get followers => throw _privateConstructorUsedError;
  List<dynamic> get friends => throw _privateConstructorUsedError;
  List<dynamic> get currentlyLikedPosts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String name,
      String email,
      String profilePhoto,
      String uid,
      int likes,
      List<dynamic> following,
      List<dynamic> followers,
      List<dynamic> friends,
      List<dynamic> currentlyLikedPosts});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? profilePhoto = null,
    Object? uid = null,
    Object? likes = null,
    Object? following = null,
    Object? followers = null,
    Object? friends = null,
    Object? currentlyLikedPosts = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      following: null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentlyLikedPosts: null == currentlyLikedPosts
          ? _value.currentlyLikedPosts
          : currentlyLikedPosts // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String profilePhoto,
      String uid,
      int likes,
      List<dynamic> following,
      List<dynamic> followers,
      List<dynamic> friends,
      List<dynamic> currentlyLikedPosts});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? profilePhoto = null,
    Object? uid = null,
    Object? likes = null,
    Object? following = null,
    Object? followers = null,
    Object? friends = null,
    Object? currentlyLikedPosts = null,
  }) {
    return _then(_$_User(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      following: null == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      followers: null == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentlyLikedPosts: null == currentlyLikedPosts
          ? _value._currentlyLikedPosts
          : currentlyLikedPosts // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User extends _User {
  const _$_User(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.uid,
      required this.likes,
      required final List<dynamic> following,
      required final List<dynamic> followers,
      required final List<dynamic> friends,
      required final List<dynamic> currentlyLikedPosts})
      : _following = following,
        _followers = followers,
        _friends = friends,
        _currentlyLikedPosts = currentlyLikedPosts,
        super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String profilePhoto;
  @override
  final String uid;
  @override
  final int likes;
  final List<dynamic> _following;
  @override
  List<dynamic> get following {
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_following);
  }

  final List<dynamic> _followers;
  @override
  List<dynamic> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  final List<dynamic> _friends;
  @override
  List<dynamic> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  final List<dynamic> _currentlyLikedPosts;
  @override
  List<dynamic> get currentlyLikedPosts {
    if (_currentlyLikedPosts is EqualUnmodifiableListView)
      return _currentlyLikedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentlyLikedPosts);
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, profilePhoto: $profilePhoto, uid: $uid, likes: $likes, following: $following, followers: $followers, friends: $friends, currentlyLikedPosts: $currentlyLikedPosts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            const DeepCollectionEquality()
                .equals(other._following, _following) &&
            const DeepCollectionEquality()
                .equals(other._followers, _followers) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality()
                .equals(other._currentlyLikedPosts, _currentlyLikedPosts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      email,
      profilePhoto,
      uid,
      likes,
      const DeepCollectionEquality().hash(_following),
      const DeepCollectionEquality().hash(_followers),
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_currentlyLikedPosts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {required final String name,
      required final String email,
      required final String profilePhoto,
      required final String uid,
      required final int likes,
      required final List<dynamic> following,
      required final List<dynamic> followers,
      required final List<dynamic> friends,
      required final List<dynamic> currentlyLikedPosts}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get profilePhoto;
  @override
  String get uid;
  @override
  int get likes;
  @override
  List<dynamic> get following;
  @override
  List<dynamic> get followers;
  @override
  List<dynamic> get friends;
  @override
  List<dynamic> get currentlyLikedPosts;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
