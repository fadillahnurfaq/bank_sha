class AppConstant {
  static String apiUrl = "https://bwabank.my.id/api/";

  static configPost(String url) {
    var uri = apiUrl + url;
    return uri;
  }

  static checkEmail() {
    return configPost("is-email-exist");
  }

  static register() {
    return configPost("register");
  }

  static login() {
    return configPost("login");
  }

  static logout() {
    return configPost("logout");
  }

  static getTransactions() {
    return configPost("transactions");
  }

  static getRecentUsers() {
    return configPost("transfer_histories");
  }

  static getUsersByUsername(String username) {
    return configPost("users/$username");
  }

  static tips() {
    return configPost("tips");
  }

  static editProfile() {
    return configPost("users");
  }

  static operatorCards() {
    return configPost("operator_cards");
  }

  static dataPlan() {
    return configPost("data_plans");
  }

  static paymentMethods() {
    return configPost("payment_methods");
  }

  static topUp() {
    return configPost("top_ups");
  }

  static transfer() {
    return configPost("transfers");
  }

  static updatePin() {
    return configPost("wallets");
  }
}
