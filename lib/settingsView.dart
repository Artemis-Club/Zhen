import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationsEnabled = false;
  bool _isDarkTheme = false;
  String _language = 'Español';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationsEnabled = prefs.getBool('notifications') ?? false;
      _isDarkTheme = prefs.getBool('darkTheme') ?? false;
      _language = prefs.getString('language') ?? 'Español';
    });
  }

  void _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
    _loadSettings(); // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Activar notificaciones'),
            value: _isNotificationsEnabled,
            onChanged: (bool newValue) {
              _saveSetting('notifications', newValue);
            },
          ),
          SwitchListTile(
            title: const Text('Tema oscuro'),
            value: _isDarkTheme,
            onChanged: (bool newValue) {
              _saveSetting('darkTheme', newValue);
            },
          ),
          ListTile(
            title: const Text('Idioma'),
            subtitle: Text(_language),
            onTap: () => _changeLanguage(),
          ),
        ],
      ),
    );
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un idioma'),
          content: DropdownButton<String>(
            value: _language,
            onChanged: (String? newValue) {
              if (newValue != null) {
                Navigator.of(context).pop();
                _saveSetting('language', newValue);
              }
            },
            items: <String>['Español', 'English', 'Français']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

