import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import '../../widgets/text_widget/text_widgets.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.faq,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            FAQItem(
              question: '1. What services can I book through the app?',
              answer:
                  'You can book a wide range of services, including restaurant reservations, spa appointments, salon bookings, fitness classes, and more.',
            ),
            FAQItem(
              question: '2. How do I book a service?',
              answer:
                  'Simply browse the services you’re interested in, select your preferred provider, choose a time, and confirm your booking. Payment will be processed through the app.',
            ),
            FAQItem(
              question: '3. Can I cancel or modify my booking?',
              answer:
                  'Yes, you can cancel or modify your booking through the app. Please check the service provider’s cancellation policy, as some may charge a fee for changes.',
            ),
            FAQItem(
              question: '4. Is there a fee for using the app?',
              answer:
                  'There are no fees to download or use the app. However, some service providers may charge fees for their services or bookings.',
            ),
            FAQItem(
              question: '5. How do I pay for my bookings?',
              answer:
                  'Payments are processed securely through the app using a variety of payment methods. You’ll be prompted to enter your payment details when confirming your booking.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: question,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.grey700,
            textAlignment: TextAlign.start,
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: answer,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.grey300,
            textAlignment: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
