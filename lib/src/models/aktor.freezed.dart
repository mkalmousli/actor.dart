// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aktor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Aktor {

/// Function name.
 String get functionName;/// Line number where the function is located.
 int get lineNumber;/// Column number where the function is located.
 int get columnNumber;/// Whether the method is asynchronous.
 bool get isAsync;/// Whether the method requires a context.
 bool get requireContext;/// Whether the aktor is marked with @live annotation.
 bool get isLive;
/// Create a copy of Aktor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AktorCopyWith<Aktor> get copyWith => _$AktorCopyWithImpl<Aktor>(this as Aktor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Aktor&&(identical(other.functionName, functionName) || other.functionName == functionName)&&(identical(other.lineNumber, lineNumber) || other.lineNumber == lineNumber)&&(identical(other.columnNumber, columnNumber) || other.columnNumber == columnNumber)&&(identical(other.isAsync, isAsync) || other.isAsync == isAsync)&&(identical(other.requireContext, requireContext) || other.requireContext == requireContext)&&(identical(other.isLive, isLive) || other.isLive == isLive));
}


@override
int get hashCode => Object.hash(runtimeType,functionName,lineNumber,columnNumber,isAsync,requireContext,isLive);

@override
String toString() {
  return 'Aktor(functionName: $functionName, lineNumber: $lineNumber, columnNumber: $columnNumber, isAsync: $isAsync, requireContext: $requireContext, isLive: $isLive)';
}


}

/// @nodoc
abstract mixin class $AktorCopyWith<$Res>  {
  factory $AktorCopyWith(Aktor value, $Res Function(Aktor) _then) = _$AktorCopyWithImpl;
@useResult
$Res call({
 String functionName, int lineNumber, int columnNumber, bool isAsync, bool requireContext, bool isLive
});




}
/// @nodoc
class _$AktorCopyWithImpl<$Res>
    implements $AktorCopyWith<$Res> {
  _$AktorCopyWithImpl(this._self, this._then);

  final Aktor _self;
  final $Res Function(Aktor) _then;

/// Create a copy of Aktor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? functionName = null,Object? lineNumber = null,Object? columnNumber = null,Object? isAsync = null,Object? requireContext = null,Object? isLive = null,}) {
  return _then(_self.copyWith(
functionName: null == functionName ? _self.functionName : functionName // ignore: cast_nullable_to_non_nullable
as String,lineNumber: null == lineNumber ? _self.lineNumber : lineNumber // ignore: cast_nullable_to_non_nullable
as int,columnNumber: null == columnNumber ? _self.columnNumber : columnNumber // ignore: cast_nullable_to_non_nullable
as int,isAsync: null == isAsync ? _self.isAsync : isAsync // ignore: cast_nullable_to_non_nullable
as bool,requireContext: null == requireContext ? _self.requireContext : requireContext // ignore: cast_nullable_to_non_nullable
as bool,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Aktor].
extension AktorPatterns on Aktor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Aktor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Aktor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Aktor value)  $default,){
final _that = this;
switch (_that) {
case _Aktor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Aktor value)?  $default,){
final _that = this;
switch (_that) {
case _Aktor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String functionName,  int lineNumber,  int columnNumber,  bool isAsync,  bool requireContext,  bool isLive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Aktor() when $default != null:
return $default(_that.functionName,_that.lineNumber,_that.columnNumber,_that.isAsync,_that.requireContext,_that.isLive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String functionName,  int lineNumber,  int columnNumber,  bool isAsync,  bool requireContext,  bool isLive)  $default,) {final _that = this;
switch (_that) {
case _Aktor():
return $default(_that.functionName,_that.lineNumber,_that.columnNumber,_that.isAsync,_that.requireContext,_that.isLive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String functionName,  int lineNumber,  int columnNumber,  bool isAsync,  bool requireContext,  bool isLive)?  $default,) {final _that = this;
switch (_that) {
case _Aktor() when $default != null:
return $default(_that.functionName,_that.lineNumber,_that.columnNumber,_that.isAsync,_that.requireContext,_that.isLive);case _:
  return null;

}
}

}

/// @nodoc


class _Aktor implements Aktor {
  const _Aktor({required this.functionName, required this.lineNumber, required this.columnNumber, this.isAsync = false, this.requireContext = false, this.isLive = false});
  

/// Function name.
@override final  String functionName;
/// Line number where the function is located.
@override final  int lineNumber;
/// Column number where the function is located.
@override final  int columnNumber;
/// Whether the method is asynchronous.
@override@JsonKey() final  bool isAsync;
/// Whether the method requires a context.
@override@JsonKey() final  bool requireContext;
/// Whether the aktor is marked with @live annotation.
@override@JsonKey() final  bool isLive;

/// Create a copy of Aktor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AktorCopyWith<_Aktor> get copyWith => __$AktorCopyWithImpl<_Aktor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Aktor&&(identical(other.functionName, functionName) || other.functionName == functionName)&&(identical(other.lineNumber, lineNumber) || other.lineNumber == lineNumber)&&(identical(other.columnNumber, columnNumber) || other.columnNumber == columnNumber)&&(identical(other.isAsync, isAsync) || other.isAsync == isAsync)&&(identical(other.requireContext, requireContext) || other.requireContext == requireContext)&&(identical(other.isLive, isLive) || other.isLive == isLive));
}


@override
int get hashCode => Object.hash(runtimeType,functionName,lineNumber,columnNumber,isAsync,requireContext,isLive);

@override
String toString() {
  return 'Aktor(functionName: $functionName, lineNumber: $lineNumber, columnNumber: $columnNumber, isAsync: $isAsync, requireContext: $requireContext, isLive: $isLive)';
}


}

/// @nodoc
abstract mixin class _$AktorCopyWith<$Res> implements $AktorCopyWith<$Res> {
  factory _$AktorCopyWith(_Aktor value, $Res Function(_Aktor) _then) = __$AktorCopyWithImpl;
@override @useResult
$Res call({
 String functionName, int lineNumber, int columnNumber, bool isAsync, bool requireContext, bool isLive
});




}
/// @nodoc
class __$AktorCopyWithImpl<$Res>
    implements _$AktorCopyWith<$Res> {
  __$AktorCopyWithImpl(this._self, this._then);

  final _Aktor _self;
  final $Res Function(_Aktor) _then;

/// Create a copy of Aktor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? functionName = null,Object? lineNumber = null,Object? columnNumber = null,Object? isAsync = null,Object? requireContext = null,Object? isLive = null,}) {
  return _then(_Aktor(
functionName: null == functionName ? _self.functionName : functionName // ignore: cast_nullable_to_non_nullable
as String,lineNumber: null == lineNumber ? _self.lineNumber : lineNumber // ignore: cast_nullable_to_non_nullable
as int,columnNumber: null == columnNumber ? _self.columnNumber : columnNumber // ignore: cast_nullable_to_non_nullable
as int,isAsync: null == isAsync ? _self.isAsync : isAsync // ignore: cast_nullable_to_non_nullable
as bool,requireContext: null == requireContext ? _self.requireContext : requireContext // ignore: cast_nullable_to_non_nullable
as bool,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
