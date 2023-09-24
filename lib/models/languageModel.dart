class Language {
  final int id;

  final String flag;
  final String name;
  final String languageCode;
  bool isSelected;

  Language(this.id, this.flag, this.name, this.languageCode,
      {this.isSelected = false});

  static List<Language> languageList = [
    Language(0, "flag", "Arabic", "ar"),
    Language(1, "flag", "English", "en"),
    // Language(3, "flag", "Deutsch", "de"),
  ];
}

// class LanguagesList {
//   List<Language>? _languages;
//
//   LanguagesList() {
//     _languages = [
//       Language(
//         1,
//         "assets/images/ge.png",
//         "German",
//         "de",
//       ),
//       Language(2, "assets/images/en.jpeg", "English", "en", isSelected: true),
//       Language(
//         3,
//         "assets/images/ar.png",
//         "العربية",
//         "ar",
//       ),
//     ];
//   }
//
//   List<Language> get languages => _languages!;
// }
