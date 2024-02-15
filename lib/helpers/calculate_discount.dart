class CalculateDiscount {
  static String calculateDiscount(double price, double discount) {
    if (discount != 0) {
      double discountedPrice = price * discount / 100;
      double newPrice = price - discountedPrice;

      return newPrice.toString();
    }

    return price.toString();
  }
}
