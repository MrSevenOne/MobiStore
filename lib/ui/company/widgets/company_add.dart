import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';

class StoreAddDialog extends StatefulWidget {
  const StoreAddDialog({super.key});

  @override
  State<StoreAddDialog> createState() => _CompanyAddDialogState();
  static Future<void> show(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StoreAddDialog(),
    );
  }
}

class _CompanyAddDialogState extends State<StoreAddDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title:  Align(
        alignment: Alignment.topCenter,
        child: Text("store_create".tr,style: theme.textTheme.titleSmall,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Text(
            "store_name".tr,
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "store_name_add".tr),
          ),
          Text(
            "store_location".tr,
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'store_location_add'.tr),
          ),
        ],
      ),
      actions: [
        DialogButtons(
          onCancel: () {
            Navigator.pop(context);
          },
          onSubmit: () {
            Navigator.pop(context);
            print('add store');
          },
        ),
      ],
    );
  }
}
