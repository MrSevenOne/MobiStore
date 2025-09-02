import 'package:flutter/material.dart';
import 'package:mobi_store/ui/core/ui/drawer/drawer_body.dart';
import 'package:mobi_store/ui/core/ui/drawer/drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            DrawerHeaderSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0,),
              child: Divider(color: theme.colorScheme.shadow),
            ),
            Expanded(child: DrawerBodySection()),
          ],
        ),
      ),
    );
  }
}


