class LocalizationBody {
  String? languageName;
  String? languageKey;
  List<LocalizationData>? localizationData;

  LocalizationBody({this.languageName, this.localizationData,this.languageKey});

  LocalizationBody.fromJson(Map<String, dynamic> json) {
    languageName = json['languageName'];
    languageKey = json['languageKey'];
    if (json['localizationData'] != null) {
      localizationData = <LocalizationData>[];
      json['localizationData'].forEach((v) {
        localizationData!.add(LocalizationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageName'] = languageName;
    data['languageKey'] = languageKey;
    if (localizationData != null) {
      data['localizationData'] =
          localizationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalizationData {
  String? localizationKey;
  String? localizationLabel;

  LocalizationData({this.localizationKey, this.localizationLabel});

  LocalizationData.fromJson(Map<String, dynamic> json) {
    localizationKey = json['localizationKey'];
    localizationLabel = json['localizationLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localizationKey'] = localizationKey;
    data['localizationLabel'] = localizationLabel;
    return data;
  }
}
