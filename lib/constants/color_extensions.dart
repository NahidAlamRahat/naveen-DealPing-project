import 'dart:ui';

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(percent >= 1 && percent <= 100, 'Percent must be between 1 and 100');
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha, // Use direct property instead of _floatToInt8(a)
      (red * value).round(), // Use direct property with proper conversion
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(percent >= 1 && percent <= 100, 'Percent must be between 1 and 100');
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color avg(Color other) {
    final redAvg = (red + other.red) ~/ 2;
    final greenAvg = (green + other.green) ~/ 2;
    final blueAvg = (blue + other.blue) ~/ 2;
    final alphaAvg = (alpha + other.alpha) ~/ 2;
    return Color.fromARGB(alphaAvg, redAvg, greenAvg, blueAvg);
  }
}
