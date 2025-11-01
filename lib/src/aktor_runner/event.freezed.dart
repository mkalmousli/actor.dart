// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Event {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Event()';
}


}

/// @nodoc
class $EventCopyWith<$Res>  {
$EventCopyWith(Event _, $Res Function(Event) __);
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Start value)?  start,TResult Function( Stop value)?  stop,TResult Function( FileDeleted value)?  fileDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Start() when start != null:
return start(_that);case Stop() when stop != null:
return stop(_that);case FileDeleted() when fileDeleted != null:
return fileDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Start value)  start,required TResult Function( Stop value)  stop,required TResult Function( FileDeleted value)  fileDeleted,}){
final _that = this;
switch (_that) {
case Start():
return start(_that);case Stop():
return stop(_that);case FileDeleted():
return fileDeleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Start value)?  start,TResult? Function( Stop value)?  stop,TResult? Function( FileDeleted value)?  fileDeleted,}){
final _that = this;
switch (_that) {
case Start() when start != null:
return start(_that);case Stop() when stop != null:
return stop(_that);case FileDeleted() when fileDeleted != null:
return fileDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Mode mode)?  start,TResult Function()?  stop,TResult Function()?  fileDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Start() when start != null:
return start(_that.mode);case Stop() when stop != null:
return stop();case FileDeleted() when fileDeleted != null:
return fileDeleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Mode mode)  start,required TResult Function()  stop,required TResult Function()  fileDeleted,}) {final _that = this;
switch (_that) {
case Start():
return start(_that.mode);case Stop():
return stop();case FileDeleted():
return fileDeleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Mode mode)?  start,TResult? Function()?  stop,TResult? Function()?  fileDeleted,}) {final _that = this;
switch (_that) {
case Start() when start != null:
return start(_that.mode);case Stop() when stop != null:
return stop();case FileDeleted() when fileDeleted != null:
return fileDeleted();case _:
  return null;

}
}

}

/// @nodoc


class Start implements Event {
  const Start({required this.mode});
  

 final  Mode mode;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartCopyWith<Start> get copyWith => _$StartCopyWithImpl<Start>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Start&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'Event.start(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $StartCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $StartCopyWith(Start value, $Res Function(Start) _then) = _$StartCopyWithImpl;
@useResult
$Res call({
 Mode mode
});




}
/// @nodoc
class _$StartCopyWithImpl<$Res>
    implements $StartCopyWith<$Res> {
  _$StartCopyWithImpl(this._self, this._then);

  final Start _self;
  final $Res Function(Start) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(Start(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as Mode,
  ));
}


}

/// @nodoc


class Stop implements Event {
  const Stop();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stop);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Event.stop()';
}


}




/// @nodoc


class FileDeleted implements Event {
  const FileDeleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Event.fileDeleted()';
}


}




// dart format on
