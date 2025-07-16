import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import '../controller/business_present_screen_controller.dart';
import 'offer_item.dart';

class OfferItemState extends State<OfferItem> {
  bool _isExpanded = false;
  final editTitleController = TextEditingController();
  final editDescriptionController = TextEditingController();
  late bool _isDefault;
  int? _selectedPercentage;

  final BusinessPresetScreenController controller =
  Get.find<BusinessPresetScreenController>();

  @override
  void initState() {
    super.initState();
    _isDefault = widget.isDefault;
    editTitleController.text = widget.title;
    editDescriptionController.text = widget.description;
    _selectedPercentage = widget.discount;
  }

  @override
  void dispose() {
    editTitleController.dispose();
    editDescriptionController.dispose();
    super.dispose();
  }

  Widget _buildOfferButton(int percentage, Function(int) onSelected) {
    bool isSelected = _selectedPercentage == percentage;
    return GestureDetector(
      onTap: () {
        onSelected(percentage);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? AppColors.green500 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage% offer',
              style: const TextStyle(fontSize: 10, color: AppColors.grey700),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.close,
              size: 16,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferButtonsRow(Function(int) onSelected) {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          10,
              (index) {
            int percentage = 5 * (index + 1);
            return _buildOfferButton(percentage, onSelected);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: _isExpanded ? AppColors.green50 : AppColors.grey50,
          ),
        ),
        color: _isExpanded ? AppColors.green50 : AppColors.white,
        child: ExpansionTile(
          shape: Border.all(color: Colors.transparent),
          title: TextWidget(
            text: widget.title,
            fontWeight: FontWeight.w500,
            fontColor: _isExpanded ? AppColors.green500 : AppColors.grey700,
            fontSize: 14,
            textAlignment: TextAlign.start,
          ),
          trailing: _isExpanded
              ? SizedBox(
            width: 80,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButtonWidget(
                  onTap: () {
                    showCustomPopup(
                      context,
                      [
                        const Center(
                          child: TextWidget(
                            text: AppStrings.editMessage,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.grey700,
                            textAlignment: TextAlign.center,
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 11),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            text: 'Title',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.green500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: editTitleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.grey300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.grey300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.green500),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            text: 'Description',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.green500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: editDescriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.grey300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.grey300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.green500),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState) {
                            return Column(
                              children: [
                                _buildOfferButtonsRow(
                                        (selectedPercentage) {
                                      setState(() {
                                        _selectedPercentage =
                                            selectedPercentage;
                                      });
                                    }),
                                const SizedBox(height: 18),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ButtonWidget(
                                    label: AppStrings.update,
                                    onPressed: () {
                                      if (_selectedPercentage == null) {
                                        AppSnackBar.error(
                                            "Please select a discount percentage.");
                                        return;
                                      }
                                      controller.updateOffer(
                                        offerId: widget.offerId,
                                        title: editTitleController.text
                                            .trim(),
                                        description:
                                        editDescriptionController.text
                                            .trim(),
                                        discount: _selectedPercentage!,
                                      );
                                      Get.back();
                                    },
                                    buttonHeight: 36,
                                    buttonWidth: 90,
                                    backgroundColor: AppColors.green500,
                                    textColor: AppColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                  icon: AppIconsPath.editIcon,
                  color: AppColors.green500,
                  size: 16,
                ),
                const SpaceWidget(spaceWidth: 4),
                IconButtonWidget(
                  onTap: () {
                    controller.deleteOffer(widget.offerId);
                  },
                  icon: AppIconsPath.deleteIcon,
                  color: AppColors.grey300,
                  size: 16,
                ),
              ],
            ),
          )
              : const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.grey700,
            size: 16,
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: TextWidget(
                text: widget.description,
                fontColor: AppColors.green400,
                fontSize: 12,
                textAlignment: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: "Set as default response",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.grey500,
                    textAlignment: TextAlign.start,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _isDefault,
                      onChanged: (value) {
                        setState(() {
                          _isDefault = value;
                        });
                        widget.onToggleDefault(value);
                      },
                      activeColor: AppColors.green500,
                      activeTrackColor: AppColors.green100,
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
