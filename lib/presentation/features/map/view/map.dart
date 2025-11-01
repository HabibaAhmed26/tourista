import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/presentation/features/map/cubit/location_cubit.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final LatLngBounds _egyptBounds = LatLngBounds(
    LatLng(21.725, 24.625), // Southwest corner
    LatLng(31.834, 36.917), // Northeast corner
  );

  @override
  Widget build(BuildContext context) {
    context.read<LocationCubit>().getLocation();
    return Scaffold(
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationLoaded) {
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter:
                        state.currentLocation, // Default to Cairo if not loaded
                    cameraConstraint: CameraConstraint.contain(
                      bounds: _egyptBounds,
                    ),
                    interactionOptions: InteractionOptions(
                      flags:
                          InteractiveFlag.pinchZoom |
                          InteractiveFlag.drag |
                          InteractiveFlag.doubleTapZoom,
                    ),
                    initialZoom: 12.0,
                    minZoom: 5.0,
                    maxZoom: 100.0,
                  ),
                  children: [openStreetMapLayer, location],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('© OpenStreetMap'),
                ),
              ],
            );
          } else if (state is Locationloading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LocationError) {
            Center(child: Text(state.message));
          }
          return Center(child: Text("Error"));
        },
      ),
    );
    ;
  }
}

TileLayer get openStreetMapLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.example.tourista',
  tileBounds: LatLngBounds(
    LatLng(32.2934590056236, 24.328924534719548),
    LatLng(21.792152188247265, 37.19854583903912),
  ),
);
CurrentLocationLayer get location => CurrentLocationLayer(
  style: LocationMarkerStyle(
    marker: GestureDetector(
      onTap: () {},
      child: DefaultLocationMarker(color: AppColors.darkBlue),
    ),
  ),
);
