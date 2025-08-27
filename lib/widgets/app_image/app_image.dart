import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/api_urls.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_image_path.dart';
import '../../utils/app_log/error_log.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.color = AppColors.grey,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.iconColor,
    this.borderRadius = 8.0,
  });

  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color color;
  final Color? iconColor;
  final double borderRadius; // নতুন parameter

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildImage(),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget _buildImage() {
    if (filePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.file(
          File(filePath!),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            errorLog(error, source: "Error loading file image:");
            return _buildPlaceholder();
          },
        ),
      );
    }

    if (url != null) {
      if (url!.toLowerCase().contains("null")) {
        return _buildPlaceholder();
      }
      return NetworkImageWithRetry(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius, // parameter pass করা হলো
      );
    }

    if (path != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          path!,
          width: width,
          height: height,
          fit: fit,
          color: iconColor,
          errorBuilder: (context, error, stackTrace) {
            errorLog(
              error,
              source: "Error loading asset image:",
            );
            return _buildPlaceholder();
          },
        ),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Icon(
          Icons.image_not_supported,
          color: iconColor ?? Colors.white,
          size: width != null && height != null
              ? (width! < height! ? width! * 0.5 : height! * 0.5)
              : 24.0,
        ),
      ),
    );
  }
}



class NetworkImageWithRetry extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius; // নতুন parameter

  const NetworkImageWithRetry({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius = 8.0, // default value
  });

  @override
  State createState() => _NetworkImageWithRetryState();
}

class _NetworkImageWithRetryState extends State<NetworkImageWithRetry> {
  int _retryCount = 0;
  final int _maxRetries = 3;
  String? _image;

  @override
  void initState() {
    super.initState();
    _setImage();
  }

  void _setImage() {
    try {
      final uri = Uri.tryParse(widget.imageUrl);
      if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
        _image = widget.imageUrl;
      } else {
        _image = "${ApiUrls.imageUrl}${widget.imageUrl}";
      }
    } catch (e) {
      _image = widget.imageUrl;
      errorLog(
        e,
        source: "Error setting image:",
      );
    }
  }

  void _retry() {
    if (_retryCount < _maxRetries) {
      setState(() {
        _retryCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = CustomHttpClient();
    // ✅ ClipOval এর পরিবর্তে ClipRRect ব্যবহার করা হলো
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: FadeInImage(
        placeholder: const AssetImage(AppImagePath.placeholderImage),
        image: NetworkImage(_image ?? ""),
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        imageErrorBuilder: (context, error, stackTrace) {
          errorLog(
            stackTrace,
            source: "Error loading network image:",
          );
          return GestureDetector(
            onTap: _retry,
            child: Container(
              width: widget.width,
              height: widget.height,
              color: AppColors.grey,
              child: const Center(
                child: Icon(Icons.person, color: Colors.white, size: 50),
              ),
            ),
          );
        },
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}