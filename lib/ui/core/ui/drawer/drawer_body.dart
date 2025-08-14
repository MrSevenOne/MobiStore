import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class DrawerBodySection extends StatelessWidget {
  const DrawerBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildMenuItem(IconData icon, String title, VoidCallback ontap) {
      return ListTile(
        leading: Icon(icon, color: theme.colorScheme.shadow),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        onTap: ontap,
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildMenuItem(
          CupertinoIcons.person_crop_circle, // Profil icon
          "Profile",
          () => Navigator.pushNamed(context, AppRouter.profile),
        ),
        buildMenuItem(
          CupertinoIcons.gear_alt, // Sozlamalar icon
          "Setting",
          () => Navigator.pushNamed(context, AppRouter.setting),
        ),
         buildMenuItem(
          CupertinoIcons.creditcard, // Tariff icon
          "Tariffs",
          () {},
        ),
        buildMenuItem(
          CupertinoIcons.info, // App haqida icon
          "About App",
          () => Navigator.pushNamed(context, AppRouter.profile),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(color: theme.colorScheme.shadow),
        ),
        ListTile(
          leading: const Icon(
            CupertinoIcons.square_arrow_right, // Logout icon
            color: Colors.red,
          ),
          title: Text(
            "Sign Out",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          onTap: () async {
            await context.read<SelectedStoreViewModel>().clearStoreId();
            await context.read<AuthViewModel>().signOut();
            Navigator.pushReplacementNamed(context, AppRouter.splash);
          },
        ),
      ],
    );
  }
}
