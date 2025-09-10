import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsPageTest extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPageTest> {
  bool pushNotifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF06292), // Pushti AppBar
        title: Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Ortga tugmasini o'chirish
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Foydalanuvchi profili
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/40'), // Avatar uchun placeholder
              backgroundColor: Color(0xFFF06292),
            ),
            title: Text('Yennefer Doe', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Account Settings', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Hisob sozlamalariga o'tish
            },
          ),
          Divider(),
          // Edit profile
          ListTile(
            title: Text('Edit profile'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Edit profile sahifasiga o'tish
            },
          ),
          // Change password
          ListTile(
            title: Text('Change password'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Change password sahifasiga o'tish
            },
          ),
          // Add a payment method
          ListTile(
            title: Text('Add a payment method'),
            trailing: Icon(Icons.add),
            onTap: () {
              // Payment method qo'shish
            },
          ),
          // Push notifications
          SwitchListTile(
            title: Text('Push notifications'),
            value: pushNotifications,
            activeColor: Color(0xFFF06292), // Pushti toggle
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),
          // Dark mode
          SwitchListTile(
            title: Text('Dark mode'),
            value: darkMode,
            activeColor: Color(0xFFF06292), // Pushti toggle
            onChanged: (value) {
              setState(() {
                darkMode = value;
                // Dark mode logikasi
              });
            },
          ),
          Divider(),
          // More
          ListTile(
            title: Text('More', style: TextStyle(color: Colors.grey)),
          ),
          // About us
          ListTile(
            title: Text('About us'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // About us sahifasiga o'tish
            },
          ),
          // Privacy policy
          ListTile(
            title: Text('Privacy policy'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Privacy policy sahifasiga o'tish
            },
          ),
        ],
      ),
    );
  }
}