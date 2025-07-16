import 'package:flutter/material.dart';

import '../business_preset_screen.dart';
import 'offer_item_state.dart';

class OfferItem extends StatefulWidget {
  final String offerId;
  final String title;
  final String description;
  final int discount;
  final bool isDefault;
  final ValueChanged<bool> onToggleDefault;

  const OfferItem({
    super.key,
    required this.offerId,
    required this.title,
    required this.description,
    required this.discount,
    required this.isDefault,
    required this.onToggleDefault,
  });

  @override
  OfferItemState createState() => OfferItemState();
}
