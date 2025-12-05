import 'package:flutter/material.dart';
import 'package:fyp_project/l10n/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  final Locale selectedLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const LanguageScreen({
    Key? key,
    required this.selectedLocale,
    required this.onLocaleChanged,
  }) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = widget.selectedLocale.languageCode;
  }

  void _setLanguage(String code) {
    widget.onLocaleChanged(Locale(code));
    setState(() => _selectedCode = code);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.language)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: Text(loc.english),
            trailing: _selectedCode == 'en' ? const Icon(Icons.check) : null,
            onTap: () => _setLanguage('en'),
          ),
          ListTile(
            title: Text(loc.sinhala),
            trailing: _selectedCode == 'si' ? const Icon(Icons.check) : null,
            onTap: () => _setLanguage('si'),
          ),
        ],
      ),
    );
  }
}
