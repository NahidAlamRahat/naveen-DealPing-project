import 'dart:math';

String? getExactStepLabel(double minValue, double maxValue, double value, {int stepsCount = 5}) {
  if (minValue >= maxValue) return null;
  if (value < minValue) return null; // ignore values below min

  final range = maxValue - minValue;
  final rawStep = range / stepsCount;

  final magnitude = pow(10, rawStep.log10().floor());
  final multiples = [1, 2, 5, 10];
  num niceStepMultiplier = multiples.first;
  for (var m in multiples) {
    if (rawStep / magnitude <= m) {
      niceStepMultiplier = m;
      break;
    }
  }
  final niceStep = niceStepMultiplier * magnitude;

  // Generate all step values starting from minValue ceilinged to step
  List<num> steps = [];
  num currentStep = (minValue / niceStep).ceil() * niceStep;
  while (currentStep <= maxValue) {
    steps.add(currentStep);
    currentStep += niceStep;
  }

  // Check if value exactly matches any step (allow small floating point error)
  for (var step in steps) {
    if ((value - step).abs() < 0.0001) {
      return _formatNumberWithSuffix(step);
    }
  }

  return null; // no exact match or below min
}

String _formatNumberWithSuffix(num value) {
  if (value >= 1e9) {
    return (value / 1e9).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'B';
  } else if (value >= 1e6) {
    return (value / 1e6).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'M';
  } else if (value >= 1e3) {
    return (value / 1e3).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'K';
  } else if (value is int || value == value.roundToDouble()) {
    return value.toInt().toString();
  } else {
    return value.toStringAsFixed(2);
  }
}

extension NumLog on num {
  double log10() => log(this) / ln10;
}
