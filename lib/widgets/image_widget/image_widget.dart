import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_size.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final BoxFit fit;

  const ImageWidget({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Image.asset(
      imagePath,
      height: ResponsiveUtils.width(height),
      width: ResponsiveUtils.width(width),
      fit: fit,
    );
  }
}


class NetworkImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String networkImageUrl;
  final BoxFit fit;

  const NetworkImageWidget({
    super.key,
    required this.height,
    required this.width,
    required this.networkImageUrl,
    this.fit = BoxFit.cover,
  });

 /* @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);

    bool isNetworkUrl = networkImageUrl.startsWith('http');

    return isNetworkUrl
        ? Image.network(
      networkImageUrl,
      height: ResponsiveUtils.width(height),
      width: ResponsiveUtils.width(width),
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/dev_images/bookings_image.png', // fallback asset
          height: ResponsiveUtils.width(height),
          width: ResponsiveUtils.width(width),
          fit: fit,
        );
      },
    )
        : Image.asset(
      'assets/dev_images/bookings_image.png',
      height: ResponsiveUtils.width(height),
      width: ResponsiveUtils.width(width),
      fit: fit,
    );
  }*/



  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);

    // Step 1: http থাকলে https এ কনভার্ট
    String finalUrl = networkImageUrl.replaceFirst('http://', 'https://');

    // Step 2: চেক করা এটা নেটওয়ার্ক URL কিনা
    bool isNetworkUrl = finalUrl.startsWith('http');

    appLog('finalUrl ==>>> $finalUrl');

    return isNetworkUrl
        ? Image.network(
      finalUrl,
      height: ResponsiveUtils.width(height),
      width: ResponsiveUtils.width(width),
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return _buildProfileIcon();
      },
    )
        : _buildProfileIcon();
  }


  Widget _buildProfileIcon() {
    return Container(
      height: ResponsiveUtils.width(height),
      width: ResponsiveUtils.width(width),
      color: Colors.grey[300], // optional background color
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 40, // adjust based on design
      ),
    );
  }



}



