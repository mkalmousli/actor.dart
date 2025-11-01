// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dart_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DartFile {

 File get file; List<Aktor> get aktors;
/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DartFileCopyWith<DartFile> get copyWith => _$DartFileCopyWithImpl<DartFile>(this as DartFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DartFile&&(identical(other.file, file) || other.file == file)&&const DeepCollectionEquality().equals(other.aktors, aktors));
}


@override
int get hashCode => Object.hash(runtimeType,file,const DeepCollectionEquality().hash(aktors));

@override
String toString() {
  return 'DartFile(file: $file, aktors: $aktors)';
}


}

/// @nodoc
abstract mixin class $DartFileCopyWith<$Res>  {
  factory $DartFileCopyWith(DartFile value, $Res Function(DartFile) _then) = _$DartFileCopyWithImpl;
@useResult
$Res call({
 File file, List<Aktor> aktors
});




}
/// @nodoc
class _$DartFileCopyWithImpl<$Res>
    implements $DartFileCopyWith<$Res> {
  _$DartFileCopyWithImpl(this._self, this._then);

  final DartFile _self;
  final $Res Function(DartFile) _then;

/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,Object? aktors = null,}) {
  return _then(_self.copyWith(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,aktors: null == aktors ? _self.aktors : aktors // ignore: cast_nullable_to_non_nullable
as List<Aktor>,
  ));
}

}


/// Adds pattern-matching-related methods to [DartFile].
extension DartFilePatterns on DartFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MainFile value)?  main,TResult Function( PartFile value)?  part,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MainFile() when main != null:
return main(_that);case PartFile() when part != null:
return part(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MainFile value)  main,required TResult Function( PartFile value)  part,}){
final _that = this;
switch (_that) {
case MainFile():
return main(_that);case PartFile():
return part(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MainFile value)?  main,TResult? Function( PartFile value)?  part,}){
final _that = this;
switch (_that) {
case MainFile() when main != null:
return main(_that);case PartFile() when part != null:
return part(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( File file,  List<Aktor> aktors)?  main,TResult Function( File mainFile,  File file,  List<Aktor> aktors)?  part,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MainFile() when main != null:
return main(_that.file,_that.aktors);case PartFile() when part != null:
return part(_that.mainFile,_that.file,_that.aktors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( File file,  List<Aktor> aktors)  main,required TResult Function( File mainFile,  File file,  List<Aktor> aktors)  part,}) {final _that = this;
switch (_that) {
case MainFile():
return main(_that.file,_that.aktors);case PartFile():
return part(_that.mainFile,_that.file,_that.aktors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( File file,  List<Aktor> aktors)?  main,TResult? Function( File mainFile,  File file,  List<Aktor> aktors)?  part,}) {final _that = this;
switch (_that) {
case MainFile() when main != null:
return main(_that.file,_that.aktors);case PartFile() when part != null:
return part(_that.mainFile,_that.file,_that.aktors);case _:
  return null;

}
}

}

/// @nodoc


class MainFile implements DartFile {
  const MainFile({required this.file, required final  List<Aktor> aktors}): _aktors = aktors;
  

@override final  File file;
 final  List<Aktor> _aktors;
@override List<Aktor> get aktors {
  if (_aktors is EqualUnmodifiableListView) return _aktors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aktors);
}


/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainFileCopyWith<MainFile> get copyWith => _$MainFileCopyWithImpl<MainFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainFile&&(identical(other.file, file) || other.file == file)&&const DeepCollectionEquality().equals(other._aktors, _aktors));
}


@override
int get hashCode => Object.hash(runtimeType,file,const DeepCollectionEquality().hash(_aktors));

@override
String toString() {
  return 'DartFile.main(file: $file, aktors: $aktors)';
}


}

/// @nodoc
abstract mixin class $MainFileCopyWith<$Res> implements $DartFileCopyWith<$Res> {
  factory $MainFileCopyWith(MainFile value, $Res Function(MainFile) _then) = _$MainFileCopyWithImpl;
@override @useResult
$Res call({
 File file, List<Aktor> aktors
});




}
/// @nodoc
class _$MainFileCopyWithImpl<$Res>
    implements $MainFileCopyWith<$Res> {
  _$MainFileCopyWithImpl(this._self, this._then);

  final MainFile _self;
  final $Res Function(MainFile) _then;

/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? aktors = null,}) {
  return _then(MainFile(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,aktors: null == aktors ? _self._aktors : aktors // ignore: cast_nullable_to_non_nullable
as List<Aktor>,
  ));
}


}

/// @nodoc


class PartFile implements DartFile {
  const PartFile({required this.mainFile, required this.file, required final  List<Aktor> aktors}): _aktors = aktors;
  

 final  File mainFile;
@override final  File file;
 final  List<Aktor> _aktors;
@override List<Aktor> get aktors {
  if (_aktors is EqualUnmodifiableListView) return _aktors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aktors);
}


/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartFileCopyWith<PartFile> get copyWith => _$PartFileCopyWithImpl<PartFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartFile&&(identical(other.mainFile, mainFile) || other.mainFile == mainFile)&&(identical(other.file, file) || other.file == file)&&const DeepCollectionEquality().equals(other._aktors, _aktors));
}


@override
int get hashCode => Object.hash(runtimeType,mainFile,file,const DeepCollectionEquality().hash(_aktors));

@override
String toString() {
  return 'DartFile.part(mainFile: $mainFile, file: $file, aktors: $aktors)';
}


}

/// @nodoc
abstract mixin class $PartFileCopyWith<$Res> implements $DartFileCopyWith<$Res> {
  factory $PartFileCopyWith(PartFile value, $Res Function(PartFile) _then) = _$PartFileCopyWithImpl;
@override @useResult
$Res call({
 File mainFile, File file, List<Aktor> aktors
});




}
/// @nodoc
class _$PartFileCopyWithImpl<$Res>
    implements $PartFileCopyWith<$Res> {
  _$PartFileCopyWithImpl(this._self, this._then);

  final PartFile _self;
  final $Res Function(PartFile) _then;

/// Create a copy of DartFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainFile = null,Object? file = null,Object? aktors = null,}) {
  return _then(PartFile(
mainFile: null == mainFile ? _self.mainFile : mainFile // ignore: cast_nullable_to_non_nullable
as File,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,aktors: null == aktors ? _self._aktors : aktors // ignore: cast_nullable_to_non_nullable
as List<Aktor>,
  ));
}


}

// dart format on
