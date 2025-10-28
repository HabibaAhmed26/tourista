part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class Authenticationloading extends AuthenticationState {}

final class Authenticationloaded extends AuthenticationState {
  final AppUser currentUser;
  Authenticationloaded({required this.currentUser});
}

final class AuthenticationError extends AuthenticationState {
  final String message;
  AuthenticationError({required this.message});
}
