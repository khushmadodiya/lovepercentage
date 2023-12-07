import 'dart:math';
late String per;
double value() {
  double minRange = 87.0;
  double maxRange = 99.0;

  // Generate a random double within the specified range
  double randomNumber = Random().nextDouble() * (maxRange - minRange) + minRange;

  print(double.parse(randomNumber.toStringAsFixed(2)));
  double rand = double.parse(randomNumber.toStringAsFixed(2));
  return  rand;
}