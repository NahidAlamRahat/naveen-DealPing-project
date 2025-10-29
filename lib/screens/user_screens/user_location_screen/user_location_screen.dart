import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_strings.dart';
import 'package:deal_ping/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

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
  double radius = 5.0; // Default radius in km

  // Dhaka coordinates
  final LatLng dhakaBounds = const LatLng(23.8103, 90.4125);
  
  // Google API key for geocoding
  final String googleApiKey = "AIzaSyA-MGtSQ8650xB0WmwJejvDbbrvTYzL6us";
  
  // Calculate appropriate zoom level based on radius
  double _getZoomLevel(double radiusInKm) {
    // Approximate zoom levels for different radius ranges
    if (radiusInKm <= 1) return 14.5;
    if (radiusInKm <= 2) return 13.5;
    if (radiusInKm <= 5) return 12.5;
    if (radiusInKm <= 10) return 11.5;
    if (radiusInKm <= 20) return 10.5;
    if (radiusInKm <= 50) return 9.5;
    return 8.5;
  }

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
    // Get radius from arguments
    final args = Get.arguments;
    if (args != null && args['radius'] != null) {
      radius = args['radius'] as double;
    }
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
        // Zoom based on radius so the circle is fully visible
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(currentLocation!, _getZoomLevel(radius)),
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
            // Location address display at top
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  if (currentAddress != null) {
                    Navigator.pop(context, currentAddress);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.green500),
                      const SizedBox(width: 10),
                      Expanded(
                        child: isLoading
                          ? const Row(
                              children: [
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.green500,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Getting location...",
                                  style: TextStyle(
                                    color: AppColors.grey300,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              currentAddress ?? "Tap on map to select location",
                              style: const TextStyle(
                                color: AppColors.contentColorBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                      if (currentAddress != null)
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.green300.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.touch_app,
                                    color: AppColors.green500,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Tap to select",
                                    style: TextStyle(
                                      color: AppColors.green500,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
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
                    snippet: 'Radius: ${radius.toStringAsFixed(1)} km',
                  ),
                  // Add onTap handler for the marker itself
                  onTap: () {
                    // First show info window
                    mapController?.showMarkerInfoWindow(const MarkerId('current_location'));
                    
                    // After a short delay, return to home screen with the selected location
                    Future.delayed(const Duration(milliseconds: 800), () {
                      if (mounted && currentAddress != null) {
                        Navigator.pop(context, currentAddress);
                      }
                    });
                  },
                ),
              }
                  : {},
              circles: currentLocation != null
                  ? {
                Circle(
                  circleId: const CircleId('radius_circle'),
                  center: currentLocation!,
                  radius: radius * 1000, // Convert km to meters
                  fillColor: Colors.blue.withOpacity(0.2),
                  strokeColor: Colors.blue.withOpacity(0.7),
                  strokeWidth: 3,
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
                // Zoom based on radius so the circle is fully visible
                mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(position, _getZoomLevel(radius)),
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