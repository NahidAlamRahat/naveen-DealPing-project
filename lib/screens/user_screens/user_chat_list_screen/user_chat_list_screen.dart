import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/widgets/space_widget/space_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class UserChatListScreen extends StatelessWidget {
  final List<String> chatItems = [
    "Lunch In Dhaka Today",
    "Haircutting in 1205",
    "Sanitary-related problems in Rajsthan",
    "Sanitary-related problems in Rajsthan",
    "Sanitary-related problems in Rajsthan",
    "Sanitary-related problems in Rajsthan",
    "Sanitary-related problems in Rajsthan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceWidget(spaceHeight: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: AppStrings.chatList,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.grey700,
                    textAlignment: TextAlign.start,
                  ),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 1) {}
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.grey300,
                            ),
                            SpaceWidget(spaceWidth: 10),
                            Text(
                              "Delete chat list",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.grey300),
                            )
                          ],
                        ),
                      ),
                    ],
                    // offset: Offset(0, 100),
                    color: AppColors.white,
                    elevation: 2,
                  ),
                ],
              ),
            ),
            const SpaceWidget(spaceHeight: 6),
            // Chat List
            ...List.generate(
              chatItems.length,
              (index) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey50, width: 1),
                ),
                child: ListTile(
                  onTap: () {},
                  title: TextWidget(
                    text: chatItems[index],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.grey300,
                    textAlignment: TextAlign.start,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button for New Chat
    );
  }
}
