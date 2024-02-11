class CalculateDiscount {
  static String calculateDiscount(double price, double discount) {
    double discountedPrice = price * discount / 100;

    return discountedPrice.toString();
  }
}
