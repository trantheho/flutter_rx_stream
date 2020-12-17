extension StringExtension on String {
  String toUpperCaseFirst() {
    if (this.length == 0) return this;
    return this.replaceFirst(this.substring(0, 1), this.substring(0, 1).toUpperCase());
  }

  double toDouble() {
    if (this.length == 0) return 0.0;
    return double.parse(this);
  }

  int toInt() {
    if (this.length == 0) return 0;
    return int.parse(this);
  }
}