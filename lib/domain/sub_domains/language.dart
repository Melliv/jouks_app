class Language {
  String id = "";
  String en = "";
  String ee = "";

  Language();

  factory Language.fromJson(Map<String, dynamic> json) {
    Language language = Language();
    language.en = json["en"];
    language.ee = json["ee"];
    return language;
  }
}
