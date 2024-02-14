class CalculateDiscount {
  static String calculateDiscount(double price, double discount) {
    double discountedPrice = price * discount / 100;
    double newPrice = price - discountedPrice;

    return newPrice.toString();
  }
}
