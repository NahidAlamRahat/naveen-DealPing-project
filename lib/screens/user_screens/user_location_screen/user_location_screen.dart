import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  late GoogleMapController mapController;
  LatLng? currentLocation;
  bool isLoading = false;

  // Dhaka coordinates
  final LatLng dhakaBounds = const LatLng(23.8103, 90.4125);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _trackMyLocation() async {
    setState(() => isLoading = true);

    try {
      // Check permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Get current position
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });

        // Animate camera to current location
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(currentLocation!, 15),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location found successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission denied'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Google Map
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: dhakaBounds,
                zoom: 12,
              ),
              markers: currentLocation != null
                  ? {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: currentLocation!,
                  infoWindow: const InfoWindow(
                    title: 'Your Location',
                  ),
                ),
              }
                  : {},
              myLocationEnabled: false,
            ),
            // Button at bottom
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: ButtonWidget(
                onPressed: isLoading ? null : _trackMyLocation,
                label: isLoading ? 'Finding Location...' : AppStrings.trackMyLocation,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}