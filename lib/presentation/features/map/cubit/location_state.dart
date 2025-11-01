part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class Locationloading extends LocationState {}

final class LocationLoaded extends LocationState {
  final LatLng currentLocation;

  LocationLoaded({required this.currentLocation});
}

final class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}
