import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:meta/meta.dart';
import 'package:tourista/core/theme/app_colors.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  getLocation() async {
    emit(Locationloading());
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(LocationError("Service Disabled"));
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(LocationError("Permission Denied"));
        return null;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null && _locationData.longitude != null) {
      emit(
        LocationLoaded(
          currentLocation: LatLng(
            _locationData.latitude!,
            _locationData.longitude!,
          ),
        ),
      );
    }
    return null;
  }
}
