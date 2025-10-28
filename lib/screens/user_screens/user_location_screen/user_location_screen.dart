import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  bool isLoading = false;
  String? currentAddress; // Store the current location name

  // Dhaka coordinates
  final LatLng dhakaBounds = const LatLng(23.8103, 90.4125);
  
  // Google API key for geocoding
  final String googleApiKey = "AIzaSyA-MGtSQ8650xB0WmwJejvDbbrvTYzL6us";
  
  // Get human-readable address from coordinates
  Future<String> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json'
          '?latlng=${coordinates.latitude},${coordinates.longitude}'
          '&key=$googleApiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          // Use the most detailed address (first result)
          return data['results'][0]['formatted_address'];
        }
      }
      return "Unknown location"; // Fallback
    } catch (e) {
      return "Unknown location"; // Error fallback
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
    // Now that controller is initialized, we can safely call _trackMyLocation
    _trackMyLocation();
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

        final newLocation = LatLng(position.latitude, position.longitude);
        
        // Get address for this location
        final address = await getAddressFromCoordinates(newLocation);
        
        setState(() {
          currentLocation = newLocation;
          currentAddress = address;
        });

        // Update marker to the tapped location if controller is available
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(currentLocation!, 15),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location found: $address'),
              duration: const Duration(seconds: 2),
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
              onMapCreated: _onMapCreated,
              markers: currentLocation != null
                  ? {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: currentLocation!,
                  infoWindow: InfoWindow(
                    title: currentAddress ?? 'Your Location',
                    snippet: 'Tap to select this location',
                  ),
                ),
              }
                  : {},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (LatLng position) async {
                setState(() {
                  isLoading = true;
                  currentLocation = position;
                });
                
                // Get address for the tapped location
                final address = await getAddressFromCoordinates(position);
                
                setState(() {
                  currentAddress = address;
                  isLoading = false;
                });
                
                // Update marker to the tapped location
                mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(position, 15),
                );
              },
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
    mapController?.dispose();
    super.dispose();
  }
}