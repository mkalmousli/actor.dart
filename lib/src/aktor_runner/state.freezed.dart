// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$State {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is State);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'State()';
}


}

/// @nodoc
class $StateCopyWith<$Res>  {
$StateCopyWith(State _, $Res Function(State) __);
}


/// Adds pattern-matching-related methods to [State].
extension StatePatterns on State {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Starting value)?  starting,TResult Function( Running value)?  running,TResult Function( Stopping value)?  stopping,TResult Function( Completed value)?  completed,TResult Function( Failed value)?  failed,TResult Function( Stopped value)?  stopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Starting() when starting != null:
return starting(_that);case Running() when running != null:
return running(_that);case Stopping() when stopping != null:
return stopping(_that);case Completed() when completed != null:
return completed(_that);case Failed() when failed != null:
return failed(_that);case Stopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Starting value)  starting,required TResult Function( Running value)  running,required TResult Function( Stopping value)  stopping,required TResult Function( Completed value)  completed,required TResult Function( Failed value)  failed,required TResult Function( Stopped value)  stopped,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Starting():
return starting(_that);case Running():
return running(_that);case Stopping():
return stopping(_that);case Completed():
return completed(_that);case Failed():
return failed(_that);case Stopped():
return stopped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Starting value)?  starting,TResult? Function( Running value)?  running,TResult? Function( Stopping value)?  stopping,TResult? Function( Completed value)?  completed,TResult? Function( Failed value)?  failed,TResult? Function( Stopped value)?  stopped,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Starting() when starting != null:
return starting(_that);case Running() when running != null:
return running(_that);case Stopping() when stopping != null:
return stopping(_that);case Completed() when completed != null:
return completed(_that);case Failed() when failed != null:
return failed(_that);case Stopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  starting,TResult Function( Process process,  File runnerFile)?  running,TResult Function( Process process,  File runnerFile)?  stopping,TResult Function( int exitCode,  File? runnerFile)?  completed,TResult Function( int exitCode,  File? runnerFile)?  failed,TResult Function( File? runnerFile)?  stopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Starting() when starting != null:
return starting();case Running() when running != null:
return running(_that.process,_that.runnerFile);case Stopping() when stopping != null:
return stopping(_that.process,_that.runnerFile);case Completed() when completed != null:
return completed(_that.exitCode,_that.runnerFile);case Failed() when failed != null:
return failed(_that.exitCode,_that.runnerFile);case Stopped() when stopped != null:
return stopped(_that.runnerFile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  starting,required TResult Function( Process process,  File runnerFile)  running,required TResult Function( Process process,  File runnerFile)  stopping,required TResult Function( int exitCode,  File? runnerFile)  completed,required TResult Function( int exitCode,  File? runnerFile)  failed,required TResult Function( File? runnerFile)  stopped,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Starting():
return starting();case Running():
return running(_that.process,_that.runnerFile);case Stopping():
return stopping(_that.process,_that.runnerFile);case Completed():
return completed(_that.exitCode,_that.runnerFile);case Failed():
return failed(_that.exitCode,_that.runnerFile);case Stopped():
return stopped(_that.runnerFile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  starting,TResult? Function( Process process,  File runnerFile)?  running,TResult? Function( Process process,  File runnerFile)?  stopping,TResult? Function( int exitCode,  File? runnerFile)?  completed,TResult? Function( int exitCode,  File? runnerFile)?  failed,TResult? Function( File? runnerFile)?  stopped,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Starting() when starting != null:
return starting();case Running() when running != null:
return running(_that.process,_that.runnerFile);case Stopping() when stopping != null:
return stopping(_that.process,_that.runnerFile);case Completed() when completed != null:
return completed(_that.exitCode,_that.runnerFile);case Failed() when failed != null:
return failed(_that.exitCode,_that.runnerFile);case Stopped() when stopped != null:
return stopped(_that.runnerFile);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements State {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'State.initial()';
}


}




/// @nodoc


class Starting implements State {
  const Starting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Starting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'State.starting()';
}


}




/// @nodoc


class Running implements State {
  const Running({required this.process, required this.runnerFile});
  

 final  Process process;
 final  File runnerFile;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RunningCopyWith<Running> get copyWith => _$RunningCopyWithImpl<Running>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Running&&(identical(other.process, process) || other.process == process)&&(identical(other.runnerFile, runnerFile) || other.runnerFile == runnerFile));
}


@override
int get hashCode => Object.hash(runtimeType,process,runnerFile);

@override
String toString() {
  return 'State.running(process: $process, runnerFile: $runnerFile)';
}


}

/// @nodoc
abstract mixin class $RunningCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory $RunningCopyWith(Running value, $Res Function(Running) _then) = _$RunningCopyWithImpl;
@useResult
$Res call({
 Process process, File runnerFile
});




}
/// @nodoc
class _$RunningCopyWithImpl<$Res>
    implements $RunningCopyWith<$Res> {
  _$RunningCopyWithImpl(this._self, this._then);

  final Running _self;
  final $Res Function(Running) _then;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? process = null,Object? runnerFile = null,}) {
  return _then(Running(
process: null == process ? _self.process : process // ignore: cast_nullable_to_non_nullable
as Process,runnerFile: null == runnerFile ? _self.runnerFile : runnerFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class Stopping implements State {
  const Stopping({required this.process, required this.runnerFile});
  

 final  Process process;
 final  File runnerFile;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoppingCopyWith<Stopping> get copyWith => _$StoppingCopyWithImpl<Stopping>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stopping&&(identical(other.process, process) || other.process == process)&&(identical(other.runnerFile, runnerFile) || other.runnerFile == runnerFile));
}


@override
int get hashCode => Object.hash(runtimeType,process,runnerFile);

@override
String toString() {
  return 'State.stopping(process: $process, runnerFile: $runnerFile)';
}


}

/// @nodoc
abstract mixin class $StoppingCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory $StoppingCopyWith(Stopping value, $Res Function(Stopping) _then) = _$StoppingCopyWithImpl;
@useResult
$Res call({
 Process process, File runnerFile
});




}
/// @nodoc
class _$StoppingCopyWithImpl<$Res>
    implements $StoppingCopyWith<$Res> {
  _$StoppingCopyWithImpl(this._self, this._then);

  final Stopping _self;
  final $Res Function(Stopping) _then;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? process = null,Object? runnerFile = null,}) {
  return _then(Stopping(
process: null == process ? _self.process : process // ignore: cast_nullable_to_non_nullable
as Process,runnerFile: null == runnerFile ? _self.runnerFile : runnerFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class Completed implements State {
  const Completed({required this.exitCode, this.runnerFile});
  

 final  int exitCode;
 final  File? runnerFile;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletedCopyWith<Completed> get copyWith => _$CompletedCopyWithImpl<Completed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Completed&&(identical(other.exitCode, exitCode) || other.exitCode == exitCode)&&(identical(other.runnerFile, runnerFile) || other.runnerFile == runnerFile));
}


@override
int get hashCode => Object.hash(runtimeType,exitCode,runnerFile);

@override
String toString() {
  return 'State.completed(exitCode: $exitCode, runnerFile: $runnerFile)';
}


}

/// @nodoc
abstract mixin class $CompletedCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory $CompletedCopyWith(Completed value, $Res Function(Completed) _then) = _$CompletedCopyWithImpl;
@useResult
$Res call({
 int exitCode, File? runnerFile
});




}
/// @nodoc
class _$CompletedCopyWithImpl<$Res>
    implements $CompletedCopyWith<$Res> {
  _$CompletedCopyWithImpl(this._self, this._then);

  final Completed _self;
  final $Res Function(Completed) _then;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exitCode = null,Object? runnerFile = freezed,}) {
  return _then(Completed(
exitCode: null == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int,runnerFile: freezed == runnerFile ? _self.runnerFile : runnerFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class Failed implements State {
  const Failed({required this.exitCode, this.runnerFile});
  

 final  int exitCode;
 final  File? runnerFile;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedCopyWith<Failed> get copyWith => _$FailedCopyWithImpl<Failed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failed&&(identical(other.exitCode, exitCode) || other.exitCode == exitCode)&&(identical(other.runnerFile, runnerFile) || other.runnerFile == runnerFile));
}


@override
int get hashCode => Object.hash(runtimeType,exitCode,runnerFile);

@override
String toString() {
  return 'State.failed(exitCode: $exitCode, runnerFile: $runnerFile)';
}


}

/// @nodoc
abstract mixin class $FailedCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory $FailedCopyWith(Failed value, $Res Function(Failed) _then) = _$FailedCopyWithImpl;
@useResult
$Res call({
 int exitCode, File? runnerFile
});




}
/// @nodoc
class _$FailedCopyWithImpl<$Res>
    implements $FailedCopyWith<$Res> {
  _$FailedCopyWithImpl(this._self, this._then);

  final Failed _self;
  final $Res Function(Failed) _then;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exitCode = null,Object? runnerFile = freezed,}) {
  return _then(Failed(
exitCode: null == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int,runnerFile: freezed == runnerFile ? _self.runnerFile : runnerFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class Stopped implements State {
  const Stopped({this.runnerFile});
  

 final  File? runnerFile;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoppedCopyWith<Stopped> get copyWith => _$StoppedCopyWithImpl<Stopped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stopped&&(identical(other.runnerFile, runnerFile) || other.runnerFile == runnerFile));
}


@override
int get hashCode => Object.hash(runtimeType,runnerFile);

@override
String toString() {
  return 'State.stopped(runnerFile: $runnerFile)';
}


}

/// @nodoc
abstract mixin class $StoppedCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory $StoppedCopyWith(Stopped value, $Res Function(Stopped) _then) = _$StoppedCopyWithImpl;
@useResult
$Res call({
 File? runnerFile
});




}
/// @nodoc
class _$StoppedCopyWithImpl<$Res>
    implements $StoppedCopyWith<$Res> {
  _$StoppedCopyWithImpl(this._self, this._then);

  final Stopped _self;
  final $Res Function(Stopped) _then;

/// Create a copy of State
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? runnerFile = freezed,}) {
  return _then(Stopped(
runnerFile: freezed == runnerFile ? _self.runnerFile : runnerFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

// dart format on
