// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaksi_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransaksiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransaksiStateCopyWith<$Res> {
  factory $TransaksiStateCopyWith(
          TransaksiState value, $Res Function(TransaksiState) then) =
      _$TransaksiStateCopyWithImpl<$Res, TransaksiState>;
}

/// @nodoc
class _$TransaksiStateCopyWithImpl<$Res, $Val extends TransaksiState>
    implements $TransaksiStateCopyWith<$Res> {
  _$TransaksiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetWalletModel? selectedWallet});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedWallet = freezed,
  }) {
    return _then(_$LoadedImpl(
      selectedWallet: freezed == selectedWallet
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as GetWalletModel?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({this.selectedWallet});

  @override
  final GetWalletModel? selectedWallet;

  @override
  String toString() {
    return 'TransaksiState.data(selectedWallet: $selectedWallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.selectedWallet, selectedWallet) ||
                other.selectedWallet == selectedWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedWallet);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return data(selectedWallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return data?.call(selectedWallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(selectedWallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements TransaksiState {
  const factory _Loaded({final GetWalletModel? selectedWallet}) = _$LoadedImpl;

  GetWalletModel? get selectedWallet;

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedListImplCopyWith<$Res> {
  factory _$$LoadedListImplCopyWith(
          _$LoadedListImpl value, $Res Function(_$LoadedListImpl) then) =
      __$$LoadedListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GetWalletModel>? listselectedWallet});
}

/// @nodoc
class __$$LoadedListImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$LoadedListImpl>
    implements _$$LoadedListImplCopyWith<$Res> {
  __$$LoadedListImplCopyWithImpl(
      _$LoadedListImpl _value, $Res Function(_$LoadedListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listselectedWallet = freezed,
  }) {
    return _then(_$LoadedListImpl(
      listselectedWallet: freezed == listselectedWallet
          ? _value._listselectedWallet
          : listselectedWallet // ignore: cast_nullable_to_non_nullable
              as List<GetWalletModel>?,
    ));
  }
}

/// @nodoc

class _$LoadedListImpl implements _LoadedList {
  const _$LoadedListImpl({final List<GetWalletModel>? listselectedWallet})
      : _listselectedWallet = listselectedWallet;

  final List<GetWalletModel>? _listselectedWallet;
  @override
  List<GetWalletModel>? get listselectedWallet {
    final value = _listselectedWallet;
    if (value == null) return null;
    if (_listselectedWallet is EqualUnmodifiableListView)
      return _listselectedWallet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TransaksiState.list(listselectedWallet: $listselectedWallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedListImpl &&
            const DeepCollectionEquality()
                .equals(other._listselectedWallet, _listselectedWallet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listselectedWallet));

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedListImplCopyWith<_$LoadedListImpl> get copyWith =>
      __$$LoadedListImplCopyWithImpl<_$LoadedListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return list(listselectedWallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return list?.call(listselectedWallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(listselectedWallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return list(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return list?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(this);
    }
    return orElse();
  }
}

abstract class _LoadedList implements TransaksiState {
  const factory _LoadedList({final List<GetWalletModel>? listselectedWallet}) =
      _$LoadedListImpl;

  List<GetWalletModel>? get listselectedWallet;

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedListImplCopyWith<_$LoadedListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'TransaksiState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TransaksiState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'TransaksiState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements TransaksiState {
  const factory _Success() = _$SuccessImpl;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TransaksiState.failed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return failed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return failed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements TransaksiState {
  const factory _Failed(final String message) = _$FailedImpl;

  String get message;

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutImplCopyWith<$Res> {
  factory _$$LogoutImplCopyWith(
          _$LogoutImpl value, $Res Function(_$LogoutImpl) then) =
      __$$LogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutImplCopyWithImpl<$Res>
    extends _$TransaksiStateCopyWithImpl<$Res, _$LogoutImpl>
    implements _$$LogoutImplCopyWith<$Res> {
  __$$LogoutImplCopyWithImpl(
      _$LogoutImpl _value, $Res Function(_$LogoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransaksiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutImpl implements _Logout {
  const _$LogoutImpl();

  @override
  String toString() {
    return 'TransaksiState.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetWalletModel? selectedWallet) data,
    required TResult Function(List<GetWalletModel>? listselectedWallet) list,
    required TResult Function() initial,
    required TResult Function() success,
    required TResult Function(String message) failed,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetWalletModel? selectedWallet)? data,
    TResult? Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult? Function()? initial,
    TResult? Function()? success,
    TResult? Function(String message)? failed,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetWalletModel? selectedWallet)? data,
    TResult Function(List<GetWalletModel>? listselectedWallet)? list,
    TResult Function()? initial,
    TResult Function()? success,
    TResult Function(String message)? failed,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) data,
    required TResult Function(_LoadedList value) list,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Logout value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? data,
    TResult? Function(_LoadedList value)? list,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Logout value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? data,
    TResult Function(_LoadedList value)? list,
    TResult Function(_Initial value)? initial,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class _Logout implements TransaksiState {
  const factory _Logout() = _$LogoutImpl;
}
