import 'package:mobi_store/export.dart';

// ignore: non_constant_identifier_names
Widget OnboardingButton({required String title, required VoidCallback ontap}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: ontap, child: Text(title),
  );
}
