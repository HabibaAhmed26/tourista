part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileUploadLoading extends ProfileState {}

class ProfileUploadSuccess extends ProfileState {}

class ProfileUploadError extends ProfileState {
  final String message;
  ProfileUploadError(this.message);
}

class ProfileDeleteLoading extends ProfileState {}

class ProfileDeleteSuccess extends ProfileState {}

class ProfileDeleteError extends ProfileState {
  final String message;
  ProfileDeleteError(this.message);
}
