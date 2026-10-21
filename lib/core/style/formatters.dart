/// 1800000 -> "1,800,000"
String formatNumber(num value) {
  final s = value.toStringAsFixed(0);
  return s.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
}
