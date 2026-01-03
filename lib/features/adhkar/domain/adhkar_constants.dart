class AdhkarConstants {
  static const String morning = 'أذكار الصباح';
  static const String evening = 'أذكار المساء';
  static const String sleep =
      'أذكار النوم'; // or 'أذكار الاستيقاظ من النوم' for sake of example in json it's specific
  static const String prayer = 'أذكار الصلاة';

  // Helper to map UI logic if needed
  static bool isMorningOrEvening(String name) {
    return name == morning || name == evening;
  }
}
