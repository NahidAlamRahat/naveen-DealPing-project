import 'package:deal_ping/utils/app_size.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_image/app_image.dart';

class NetworkImageGrid extends StatelessWidget {
  final List<String>? images;
  final Function(int index)? onTap;

  const NetworkImageGrid({
    Key? key,
    required this.images,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) return const SizedBox();

    if (images!.length == 1) {
      return GestureDetector(
        onTap: () => onTap?.call(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: AppSize.height(value: 200),
            child: AppImage(
              url: images![0],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }


    if (images!.length == 2) {
      return Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap?.call(index),
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? 8 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(url: images![index], fit: BoxFit.cover),
                ),
              ),
            ),
          );
        }),
      );
    }

    if (images!.length == 3) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => onTap?.call(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(url: images![0], fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => onTap?.call(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppImage(url: images![1], fit: BoxFit.cover),
                  ),
                ),
                // const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => onTap?.call(2),
                  child: AspectRatio(
                    aspectRatio: 166 / 249,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AppImage(url: images![2], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (images!.length == 4) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 4,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppImage(url: images![index], fit: BoxFit.cover),
            ),
          );
        },
      );
    }

    // 5 or more
    return Column(
      children: [
        Row(
          children: List.generate(2, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? 8 : 0),
                child: GestureDetector(
                  onTap: () => onTap?.call(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppImage(url: images![index], fit: BoxFit.cover),
                  ),
                ),
              ),
            );
          }),
        ),
        // const SizedBox(height: 8),
        Row(
          children: List.generate(3, (index) {
            int imgIndex = index + 2;
            bool isLast = imgIndex == 4 && images!.length > 5;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                child: GestureDetector(
                  onTap: () => onTap?.call(imgIndex),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppImage(url: images![imgIndex], fit: BoxFit.cover),
                          if (isLast)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '+${images!.length - 5}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
