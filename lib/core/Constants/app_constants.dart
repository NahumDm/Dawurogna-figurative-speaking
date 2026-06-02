/// Application-wide constants (assets, URLs, copy).
abstract final class AppConstants {
  static const String appTitle = 'Dawuro Proverbs & Tales';
  static const String materialAppTitle = 'Dawurogna Figurative Speaking';
  static const String onboardingTitle = 'Dawuro Proverbs & Tales';
  static const String onboardingSubtitle =
      'Dawurotsuwa tossanne misayuwa haasaya amaaratsuwa biletsana';
  static const String continueLabel = 'Continue';
  static const String aboutTitle = 'About';
  static const String settingsTitle = 'Settings';
  static const String settingsAppearanceSection = 'Appearance';
  static const String settingsAppSection = 'App';
  static const String darkModeLabel = 'Dark mode';
  static const String darkModeSubtitle =
      'Use a darker theme for comfortable reading';
  static const String settingsUpdateSubtitle =
      'Check the Play Store for the latest version';
  static const String settingsShareSubtitle =
      'Tell others about Dawuro Proverbs';
  static const String settingsContactSubtitle =
      'Email or message the developer';
  static const String checkForUpdateLabel = 'Check for update';
  static const String shareAppLabel = 'Share app';
  static const String contactDeveloperLabel = 'Contact developer';
  static const String settingsFooterHint =
      'Changes apply immediately across the app.';
  static const String updateAvailableTitle = 'Update Available';
  static const String updateAvailableBody = 'A new version is available!';
  static const String updateLaterLabel = 'Later';
  static const String updateNowLabel = 'Update';
  static const String upToDateMessage = 'Your app is up to date!';
  static const String categoriesTabLabel = 'Categories';
  static const String favoritesTabLabel = 'Favorites';
  static const String favoritesTabLabelCompact = 'Saved';
  static const String aboutTabLabel = 'About';
  static const String aboutTabLabelCompact = 'About';

  static const String favoritesScreenTitle = 'Favorite Proverbs';
  static const String favoritesSearchHint = 'Search favorites…';
  static const String favoritesEmptyTitle = 'No Favorite Proverbs Yet';
  static const String favoritesEmptyMessage =
      'Save your favorite Dawurogna proverbs and build your own personal collection.';
  static const String removeFavoriteLabel = 'Remove from favorites';
  static const String addFavoriteLabel = 'Add to favorites';
  static const String shareProverbLabel = 'Share proverb';

  static const String proverbOfDayTitle = 'Proverb of the Day';
  static const String proverbOfDayActionLabel = "Check today's proverb";
  static const String proverbOfDayActionHint =
      'One special proverb, refreshed each day';
  static const String proverbOfDaySheetSubtitle =
      'Today\'s featured Dawurogna wisdom';
  static const String proverbOfDayReadMore = 'Read full meaning';
  static const String proverbOfDayDismissLabel = 'Close';

  static const String shareProverbFooter =
      'Shared from Dawurogna Proverbs App';
  static const String shareProverbHeader = '📖 Dawurogna Proverb';
  static const String sharePhoneticHeader = '🔤 Phonetic';
  static const String shareAmharicHeader = '🇪🇹 Amharic Meaning';

  static String proverbListAppBarTitle(String letter) => 'Letter $letter';

  static String proverbListCountLabel(int count) =>
      count == 1 ? '1 proverb' : '$count proverbs';

  static const String proverbListTapHint = 'Tap to read full meaning';
  static const String proverbListEmptyMessage =
      'No proverbs found for this letter.';
  static const String proverbListLoadingMessage = 'Loading proverbs…';

  static const String detailDawuroSection = 'Dawurogna Proverb';
  static const String detailPhoneticSection = 'Phonetic Transcription';
  static const String detailAmharicSection = 'Amharic Meaning';
  static const String detailCulturalImageLabel =
      'Dawuro gihibli, traditional musical instrument';
  static String detailPositionLabel(int current, int total) =>
      '$current of $total';
  static const String detailPreviousLabel = 'Previous proverb';
  static const String detailNextLabel = 'Next proverb';
  static const String detailLoadingMessage = 'Loading proverb…';
  static const String detailNotFoundMessage = 'Proverb not found.';
  static const String detailLoadErrorMessage =
      'Unable to load proverbs. Please try again.';
  static const String detailRetryLabel = 'Retry';

  static const String categoryBrowseTitle = 'Browse by letter';
  static const String categoryBrowseSubtitle =
      'Choose a Dawuro alphabet letter to explore its proverbs';
  static const String categoryQuickJumpLabel = 'Quick jump';
  static String categoryLetterCountLabel(int count) =>
      count == 1 ? '1 proverb' : '$count proverbs';
  static String categoryAlphabetCountLabel(int count) =>
      count == 1 ? '1 letter' : '$count letters';

  static const String proverbsAssetPath = 'assets/data/dawurogna_proverbs.json';
  static const String bookIconAsset = 'assets/images/book_icon.png';
  static const String culturalImageAsset = 'assets/images/dawuro_gihibli.png';

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.nahom.dawurogna_figurative_speaking';

  static const String developerEmail =
      'mailto:nahomdesta.dev@gmail.com?subject=Feedback for Dawurogna App';
  static const String developerTelegram = 'https://t.me/NahumD';

  static const String contactSheetTitle = "We'd love to hear from you";
  static const String contactSheetSubtitle =
      'Your feedback helps preserve and improve Dawuro proverbs for everyone.';
  static const String contactEmailTitle = 'Send an email';
  static const String contactEmailDescription =
      'Report issues, suggest proverbs, or share appreciation';
  static const String contactTelegramTitle = 'Message on Telegram';
  static const String contactTelegramDescription =
      'Quick chat for questions and ideas';
  static const String contactSheetFooter =
      'Tap an option above — your message makes a real difference.';
}
