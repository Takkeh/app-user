class ApiUrl {
  static const String mainUrl = "http://takkeh.wecan.jo/public";

  //registration
  static const String signIn = "/api/v1/login";
  static const String createAccount = "/api/v1/user-reg";
  static const String logOut = "/api/v1/logout";
  static const String countries = "/api/v1/countries";
  static const String checkOtp = "/api/v1/otb-check";
  static const String resetPassStep1 = "/api/v1/password-otb";
  static const String resetPassStep2 = "/api/v1/otb-check";
  static const String resetPassStep3 = "/api/v1/change-password";

  //home
  static const String categories = "/api/v1/categories";
  static const String slider = "/api/v1/sliders";
  static const String offers = "/api/v1/offers";
  static const String specialOffers = "/api/v1/specials";

  //restaurants
  static const String restaurantCategories = "/api/v1/categories";
  static const String viewRestaurantProduct = "/api/v1/products/";
  static const String restaurants = "/api/v1/restaurant/catpro/search";
  static const String viewRestaurants = "/api/v1/restaurant/products/";
  static const String makeOrder = "/api/v1/make-order";
  static const String updateOrder = "/api/v1/update-order";
  static const String restaurantsSearch = "/api/v1/restaurants/search/";
  static const String tags = "/api/v1/tags";

  //profile
  static const String updateProfile = "/api/v1/update-profile";
  static const String updatePassword = "/api/v1/update-password";

  //promo codes
  static const String promoCodes = "/api/v1/promo-code";
  static const String addPromoCode = "/api/v1/add-code-to-order";

  // orders
  static const String myOrders = "/api/v1/my-orders";

}
