/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Constants
  static const int apiTimeoutSeconds = 60;
  static const int apiRetryAttempts = 3;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;
  
  // Animation Constants
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String appSettingsKey = 'app_settings';
  
  // Error Messages
  static const String networkErrorMessage = 'Tidak dapat terhubung ke server';
  static const String serverErrorMessage = 'Terjadi kesalahan pada server';
  static const String unknownErrorMessage = 'Terjadi kesalahan yang tidak diketahui';
  static const String validationErrorMessage = 'Data yang dimasukkan tidak valid';
  
  // Success Messages
  static const String loginSuccessMessage = 'Berhasil masuk';
  static const String logoutSuccessMessage = 'Berhasil keluar';
  static const String saveSuccessMessage = 'Data berhasil disimpan';
  static const String deleteSuccessMessage = 'Data berhasil dihapus';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Currency
  static const String defaultCurrency = 'IDR';
  static const String currencySymbol = 'Rp';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}

/// Route names for navigation
class RouteNames {
  // Private constructor to prevent instantiation
  RouteNames._();
  
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String transactions = '/transactions';
  static const String wallets = '/wallets';
  static const String categories = '/categories';
  static const String settings = '/settings';
  static const String profile = '/profile';
}

/// Asset paths
class AssetPaths {
  // Private constructor to prevent instantiation
  AssetPaths._();
  
  // Images
  static const String logo = 'assets/Logo.svg';
  static const String splash = 'assets/splash-2.png';
  static const String profileIcon = 'assets/profile-svgrepo-com.svg';
  static const String homeIcon = 'assets/home-icon-silhouette-svgrepo-com.svg';
  
  // Icons
  static const String walletIcon = 'assets/Wallet.svg';
  static const String settingsIcon = 'assets/Setting.svg';
  static const String calendarIcon = 'assets/Calendar.svg';
  static const String transactionIcon = 'assets/Transaksi.svg';
  static const String reportIcon = 'assets/Reports.svg';
  static const String trashIcon = 'assets/Trash_icon.svg';
}
