String convertCurrency(double amount, String currency, Map<String, double> rates) {
  double rate = rates[currency]!;
  double converted = amount * rate;
  return '$amount THB = ${converted.toStringAsFixed(3)} $currency';
}