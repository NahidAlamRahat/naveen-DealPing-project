import 'package:deal_ping/constants/app_colors.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../models/booking-growth.dart';
import '../../../models/user-growth.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/business_my_report_controller.dart';

class BusinessMyReportScreen extends StatefulWidget {
  const BusinessMyReportScreen({super.key});

  @override
  State<BusinessMyReportScreen> createState() => _BusinessMyReportScreenState();
}

class _BusinessMyReportScreenState extends State<BusinessMyReportScreen> {
  // Line Chart Gradient Colors
  List<Color> gradientColors = [
    AppColors.green500,
    AppColors.green50,
  ];

  // Bar Chart Colors for two items
  final List<Color> barColors = [
    AppColors.green500, // Color for first item (e.g., active calories)
    AppColors.grey50, // Color for second item (e.g., passive calories)
  ];

  int touchedIndex = 2; // Highlighting Wednesday by default
  final ReportController controller = Get.put(ReportController());

  @override
  void initState() {
    super.initState();
    // Initial API calls for both user growth & booking growth
    controller.changeUserFilterType(controller.userFilterType.value);
    controller.changeBookingFilterType(controller.bookingFilterType.value);
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.myReport,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Line Chart Section (unchanged)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextWidget(
                      text: 'User Growth',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.green500,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 12),

                  ///user

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() {
                      int selectedIndex = controller.userSelectedTabIndex.value;

                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.changeUserSelectedTab(0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: selectedIndex == 0
                                      ? AppColors.green500
                                      : Colors.grey.shade300,
                                ),
                                const SpaceWidget(spaceWidth: 8),
                                TextWidget(
                                  text: 'Received Request',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontColor: selectedIndex == 0
                                      ? AppColors.grey700
                                      : Colors.grey.shade400,
                                ),
                                const SpaceWidget(spaceWidth: 20),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.changeUserSelectedTab(1),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: selectedIndex == 1
                                      ? AppColors.green500
                                      : Colors.grey.shade300,
                                ),
                                const SpaceWidget(spaceWidth: 8),
                                TextWidget(
                                  text: 'Converted Booking',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontColor: selectedIndex == 1
                                      ? AppColors.grey700
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );

                    }),
                  ),

                  ///user
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                              () => DropdownButton<String>(
                            value: controller.userFilterType.value,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.green500),
                            items: ["Month", "Year"]
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(
                                      color: AppColors.grey300, fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: controller.changeUserFilterType,
                          ),
                        )
                        ,
                      ],
                    ),
                  ),


                  ///user
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 24,
                        bottom: 12,
                      ),
                      child:Obx(() {
                        final userGrowth = controller.userStats.value;
                        final selectedIndex = controller.userSelectedTabIndex.value;
                        if (userGrowth == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return LineChart(getMainData(userGrowth, selectedIndex));
                      }),

                    ),
                  ),

                ],
              ),


              const SpaceWidget(spaceHeight: 26),

              // Bar Chart Section
          AspectRatio(
            aspectRatio: 1, // Width:Height = 1:1
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Booking Ratio',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.green500,
                  ),

                  const SpaceWidget(spaceHeight: 12),

                /*  const Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.green50,
                      ),
                      SpaceWidget(spaceWidth: 8),
                      TextWidget(
                        text: 'Booking Confirmation',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.grey700,
                      ),
                      SpaceWidget(spaceWidth: 20),
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: AppColors.green500,
                          ),
                          SpaceWidget(spaceWidth: 8),
                          TextWidget(
                            text: 'Checked In Confirmation',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontColor: AppColors.grey700,
                          ),
                        ],
                      ),

                      Flexible(
                        child: Obx(
                              () => DropdownButton<String>(
                            value: controller.userFilterType.value,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.green500),
                            items: ["Month", "Year"]
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(
                                      color: AppColors.grey300, fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: controller.changeBookingFilterType,
                          ),
                        )
                        ,
                      ),
                    ],
                  ),
*/

                  ///Booking
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() {
                      int selectedIndex = controller.bookingSelectedTabIndex.value;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => controller.changeBookingSelectedTab(0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: selectedIndex == 0
                                      ? AppColors.green500
                                      : Colors.grey.shade300,
                                ),
                                const SpaceWidget(spaceWidth: 8),
                                TextWidget(
                                  text: 'Booking Confirmation',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontColor: selectedIndex == 0
                                      ? AppColors.grey700
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                          const SpaceWidget(spaceWidth: 20),

                          GestureDetector(
                            onTap: () => controller.changeBookingSelectedTab(1),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: selectedIndex == 1
                                      ? AppColors.green500
                                      : Colors.grey.shade300,
                                ),
                                const SpaceWidget(spaceWidth: 8),
                                TextWidget(
                                  text: 'Checked In Confirmation',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontColor: selectedIndex == 1
                                      ? AppColors.grey700
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );

                    }),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                              () => DropdownButton<String>(
                            value: controller.bookingFilterType.value,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.green500),
                            items: ["Month", "Year"]
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: const TextStyle(
                                      color: AppColors.grey300, fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: controller.changeBookingFilterType,
                          ),
                        )
                        ,
                      ],
                    ),
                  ),


                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 24,
                        bottom: 12,
                      ),
                      child:Obx(() {
                        final userGrowth = controller.bookingStats.value;
                        final selectedIndex = controller.bookingSelectedTabIndex.value;
                        if (userGrowth == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SizedBox(
                            height: 220,
                            child: BarChart(mainBarData()));
                      }),

                    ),
                  ),


                  const SpaceWidget(spaceHeight: 12),

                  // এখানে পরিবর্তন: Expanded এর বদলে SizedBox দিয়ে fixed height দিলাম
               /*   SizedBox(
                    height: 250,  // তোমার প্রয়োজনমতো adjust করো
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(mainBarData()),
                    ),
                  ),*/

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),


            ],
          ),
        ),
      ),
    );
  }

  // Line Chart Methods (unchanged)
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey700,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta,
      {required double minimum, required double maximum}) {
    // appLog('===========================> $value');
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey700,
    );

    String? text = getExactStepLabel(minimum, maximum, value, stepsCount: 5);
    if (text == null) return Container();
    // appLog("❤️❤️❤️👌👌👌👌👌 $text");
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, // Axis থেকে gap
      child: Text(text, style: style),
    );
  }

  LineChartData getMainData(UserGrowthResponse data, int selectedIndex) {
    if (selectedIndex == 0) {
      // Received Request -> requests data
      List<double> values = data.requests.map((e) => e.value).toList();
      double minValue = values.reduce((a, b) => a < b ? a : b);
      double maxValue = values.reduce((a, b) => a > b ? a : b);

      return LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) => leftTitleWidgets(
                  value, meta,
                  minimum: minValue, maximum: maxValue),
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: data.requests.isNotEmpty ? data.requests.last.day.toDouble() : 0,
        minY: 0,
        maxY: data.requests.isNotEmpty
            ? data.requests.map((e) => e.value).reduce((a, b) => a > b ? a : b)
            : 0,
        lineBarsData: [
          LineChartBarData(
            spots: data.requests
                .map((e) => FlSpot(e.day.toDouble(), e.value))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(colors: gradientColors),
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    } else {
      // Converted Booking -> bookings data
      List<double> values = data.bookings.map((e) => e.value).toList();
      double minValue = values.reduce((a, b) => a < b ? a : b);
      double maxValue = values.reduce((a, b) => a > b ? a : b);

      return LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) => leftTitleWidgets(
                  value, meta,
                  minimum: minValue, maximum: maxValue),
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: data.bookings.isNotEmpty ? data.bookings.last.day.toDouble() : 0,
        minY: 0,
        maxY: data.bookings.isNotEmpty
            ? data.bookings.map((e) => e.value).reduce((a, b) => a > b ? a : b)
            : 0,
        lineBarsData: [
          LineChartBarData(
            spots: data.bookings
                .map((e) => FlSpot(e.day.toDouble(), e.value))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(colors: gradientColors),
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    }
  }



  // Bar Chart Helper Methods
  BarChartGroupData _makeGroupData(
      int x,
      double y1, // First value (e.g., active calories)
      double y2, // Second value (e.g., passive calories)
      {bool isTouched = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1 + y2, // Total height of the bar (stacked)
          rodStackItems: [
            BarChartRodStackItem(0, y1,
                isTouched ? barColors[0].withOpacity(0.8) : barColors[0]),
            // First segment
            BarChartRodStackItem(y1, y1 + y2,
                isTouched ? barColors[1].withOpacity(0.8) : barColors[1]),
            // Second segment
          ],
          width: 20,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(100), bottom: Radius.circular(100)),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarData() {
    final bookingStats = controller.bookingStats.value;

    if (bookingStats == null) {
      return [];
    }

    final List<double> placedPerWeekday = List.filled(7, 0.0);

    for (var data in bookingStats.placed) {
      int weekdayIndex = dayOfWeekFromDayNumber(data.day);
      placedPerWeekday[weekdayIndex] += data.value;
    }

    return List.generate(7, (i) {
      return _makeGroupData(
        i,
        placedPerWeekday[i],
        0.0,
        isTouched: i == touchedIndex,
      );
    });
  }




   mainBarData() {

     double maxValue =( controller.bookingStats.value?.placed.map((e)=> e.value).toList() ?? [])
         .reduce((a, b) => a > b ? a : b);
    return BarChartData(
      alignment: BarChartAlignment.center,
      barTouchData: BarTouchData(
        enabled: true, // Enable touch interactions
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            setState(() {
              touchedIndex = -1;
            });
            return;
          }
          setState(() {
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: _getBottomTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(color: AppColors.grey700, fontSize: 14);
              return Text('${value.toInt()}', style: style);
            },
          ),
        ),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: _generateBarData(),
      gridData: const FlGridData(show: true, drawVerticalLine: false),
      maxY: maxValue +16, // Adjust based on your max stacked value
    );
  }

  // Bottom Titles for Bar Chart
  Widget _getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.grey700,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    final titles = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final index = value.toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        index < titles.length ? titles[index] : '',
        style: style,
      ),
    );
  }



  int dayOfWeekFromDayNumber(int dayNumber) {
    DateTime date = DateTime(DateTime.now().year, DateTime.now().month, dayNumber);


    return date.weekday % 7; // Sunday -> 0, Monday ->1 ... Saturday -> 6
  }


}
