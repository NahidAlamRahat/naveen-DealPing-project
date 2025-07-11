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

  @override
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
  }
}



