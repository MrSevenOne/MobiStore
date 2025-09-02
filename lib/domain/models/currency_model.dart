import 'package:intl/intl.dart';

class CurrencyModel {
  final int id;
  final String code;        // masalan: "840"
  final String ccy;         // masalan: "USD"
  final String nameRu;      // "Доллар США"
  final String nameUz;      // "AQSH dollari"
  final String nameUzc;     // "АҚШ доллари"
  final String nameEn;      // "US Dollar"
  final int nominal;        // masalan: 1
  final double rate;        // 12412.98
  final double diff;        // 58.33
  final DateTime date;      // 28.08.2025

  CurrencyModel({
    required this.id,
    required this.code,
    required this.ccy,
    required this.nameRu,
    required this.nameUz,
    required this.nameUzc,
    required this.nameEn,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as int,
      code: json['Code'] as String,
      ccy: json['Ccy'] as String,
      nameRu: json['CcyNm_RU'] as String,
      nameUz: json['CcyNm_UZ'] as String,
      nameUzc: json['CcyNm_UZC'] as String,
      nameEn: json['CcyNm_EN'] as String,
      nominal: int.parse(json['Nominal']),
      rate: double.parse(json['Rate']),
      diff: double.parse(json['Diff']),
      date: DateFormat("dd.MM.yyyy").parse(json['Date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Code": code,
      "Ccy": ccy,
      "CcyNm_RU": nameRu,
      "CcyNm_UZ": nameUz,
      "CcyNm_UZC": nameUzc,
      "CcyNm_EN": nameEn,
      "Nominal": nominal.toString(),
      "Rate": rate.toString(),
      "Diff": diff.toString(),
      "Date": DateFormat("dd.MM.yyyy").format(date),
    };
  }
}
