import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/constants/app_icons_path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../widgets/icon_widget/icon_widget.dart';

/// A location search class to simulate a prediction from Google Places API
class LocationPrediction {
  final String description;
  final double latitude;
  final double longitude;
  
  LocationPrediction({
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}

/// A customized HomeScreenInputWidget with location search capability
/// Maintains the same design as HomeScreenInputWidget
class LocationSearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onLocationTap;
  final Function(String placeName, double? latitude, double? longitude)? onPlaceSelected;
  final String googleApiKey;

  const LocationSearchWidget({
    super.key,
    required this.controller,
    this.hintText = "Location",
    this.onLocationTap,
    this.onPlaceSelected,
    this.googleApiKey = "AIzaSyA-MGtSQ8650xB0WmwJejvDbbrvTYzL6us", // Default API key
  });

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<LocationPrediction> _predictions = [];
  bool _isLoading = false;
  bool _justSelected = false; // Flag to prevent suggestions after selection
  
  // API session token for Google Places API
  String? _sessionToken;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (widget.controller.text.isNotEmpty && _predictions.isNotEmpty) {
          _showOverlay();
        }
      } else {
        _hideOverlay();
      }
    });

    // Listen to changes in the text field
    widget.controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Check if a location was just selected
    if (_justSelected) {
      _justSelected = false;
      return;
    }
    
    // Only trigger search if field has focus and text changed by typing (not by selection)
    if (widget.controller.text.isNotEmpty && _focusNode.hasFocus) {
      // Debounce the API calls slightly to avoid too many requests while typing
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _focusNode.hasFocus && !_justSelected) {
          _getPredictions(widget.controller.text);
        }
      });
    } else if (widget.controller.text.isEmpty) {
      setState(() {
        _predictions = [];
        _hideOverlay();
      });
    }
  }

  Future<void> _getPredictions(String query) async {
    if (query.length < 2) {
      setState(() {
        _predictions = [];
        _hideOverlay();
      });
      return;
    }

    // Generate a new session token if none exists
    _sessionToken ??= DateTime.now().millisecondsSinceEpoch.toString();

    setState(() {
      _isLoading = true;
      if (_overlayEntry != null) {
        _updateOverlay();
      } else {
        _showOverlay();
      }
    });

    try {
      // Call Google Places API for autocomplete suggestions
      final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=$query'
          '&key=${widget.googleApiKey}'
          '&sessiontoken=$_sessionToken'
          '&components=country:bd'; // Restrict to Bangladesh

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final List<dynamic> predictions = data['predictions'];
          final places = await Future.wait(
            predictions.map((prediction) async {
              // Get details for each prediction to obtain lat/lng
              final String placeId = prediction['place_id'];
              final detailsResponse = await http.get(
                Uri.parse(
                  'https://maps.googleapis.com/maps/api/place/details/json'
                  '?place_id=$placeId'
                  '&fields=formatted_address,geometry'
                  '&key=${widget.googleApiKey}'
                  '&sessiontoken=$_sessionToken',
                ),
              );

              if (detailsResponse.statusCode == 200) {
                final detailsData = json.decode(detailsResponse.body);
                if (detailsData['status'] == 'OK') {
                  final result = detailsData['result'];
                  final geometry = result['geometry']['location'];
                  return LocationPrediction(
                    description: prediction['description'],
                    latitude: geometry['lat'],
                    longitude: geometry['lng'],
                  );
                }
              }
              // Fallback with just the description and no coordinates
              return LocationPrediction(
                description: prediction['description'],
                latitude: 0,
                longitude: 0,
              );
            }),
          );

          setState(() {
            _predictions = places;
            _isLoading = false;
            if (places.isNotEmpty) {
              if (_overlayEntry != null) {
                _updateOverlay();
              } else {
                _showOverlay();
              }
            } else {
              _hideOverlay();
            }
          });
        } else {
          setState(() {
            _predictions = [];
            _isLoading = false;
            _hideOverlay();
          });
        }
      } else {
        setState(() {
          _predictions = [];
          _isLoading = false;
          _hideOverlay();
        });
      }
    } catch (e) {
      print('Error fetching predictions: $e');
      setState(() {
        _predictions = [];
        _isLoading = false;
        _hideOverlay();
      });
    }
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    _hideOverlay();
    _showOverlay();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: _buildPredictionsList(),
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionsList() {
    if (_isLoading) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    if (_predictions.isEmpty) {
      return Container(); // Empty container when no predictions
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: const BoxConstraints(
        maxHeight: 300,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _predictions.length,
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(
              Icons.location_on,
              color: AppColors.green300,
              size: 20,
            ),
            title: Text(
              _predictions[index].description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grey700,
              ),
            ),
            onTap: () {
              _selectPrediction(_predictions[index]);
            },
          );
        },
      ),
    );
  }

  void _selectPrediction(LocationPrediction prediction) {
    // Set flag to prevent suggestions from showing after selection
    _justSelected = true;
    
    // Update text field with selected location
    widget.controller.text = prediction.description;
    
    // Hide overlay and clear predictions
    _hideOverlay();
    setState(() {
      _predictions = [];
    });
    
    // Remove focus to dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if (widget.onPlaceSelected != null) {
      widget.onPlaceSelected!(
        prediction.description,
        prediction.latitude,
        prediction.longitude,
      );
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    widget.controller.removeListener(_onSearchChanged);
    _hideOverlay();
    // Reset session token
    _sessionToken = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.green200, width: 0.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.grey200,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey700,
                      fontWeight: FontWeight.w400,
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty && _predictions.isNotEmpty) {
                        _selectPrediction(_predictions.first);
                      }
                    },
                  ),
                ),
                // Show a clear icon when text is entered
                if (widget.controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      widget.controller.clear();
                      setState(() {
                        _predictions = [];
                        _hideOverlay();
                      });
                    },
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.grey300,
                      size: 18,
                    ),
                  ),
                const SizedBox(width: 12),
                if (widget.onLocationTap != null)
                  GestureDetector(
                    onTap: widget.onLocationTap,
                    child: const IconWidget(
                      icon: AppIconsPath.locationIcon,
                      color: AppColors.green300,
                      width: 22,
                      height: 22,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
