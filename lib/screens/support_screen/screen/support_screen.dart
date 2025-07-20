import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../../../utils/app_size.dart';

import '../controller/supportApiCallerController.dart';
import '../widget/support_request_widget.dart';

class SupportScreen extends StatelessWidget {

 const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportRequestController>(
      init: SupportRequestController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                backgroundColor: AppColors.white,
                title: const TextWidget(
                  text: AppStrings.supportRequestScreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.grey700,
                ),
              ),
              body: Column(
                children: [
                  Container(
                    height: AppSize.height(value: 50),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.green50),
                    child: TabBar(
                      indicatorColor: AppColors.green500,
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.green500,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: controller.onStatusChange,
                      indicator: BoxDecoration(
                        color: AppColors.green500,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      tabs: controller.changeStatus.map((status) => Tab(text: status)).toList(),
                    )
                  ),
                  const SpaceWidget(spaceHeight: 8),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        SupportRequestWidget(),
                        SupportRequestWidget(),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}






