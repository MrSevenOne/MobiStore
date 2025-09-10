import 'package:flutter/material.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';

/// Faqat matnni son sifatida olish uchun Controller
class CurrencyTextController extends TextEditingController {
  CurrencyTextController({String? text}) : super(text: text ?? '');
  
  /// Asl son (foydalanuvchi kiritgan qiymatni double sifatida olish)
  double get numericValue => CurrencyHelper.parseToDouble(text);
}