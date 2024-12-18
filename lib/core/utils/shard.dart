class Shard {
  int parseAmount(String amountString) {
    try {
      return double.parse(amountString).toInt();
    } catch (e) {
      print('Error parsing amount: $amountString');
      return 0;
    }
  }
}
