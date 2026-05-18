import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';   // ← SR3Strings
import '../main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = SR3Strings.of(context);
    final currentLocale = Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_flag(currentLocale.languageCode),
                style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down,
                color: Colors.white.withOpacity(0.7), size: 18),
          ],
        ),
      ),
      onSelected: (Locale locale) {
        SR3UrbanApp.setLocale(context, locale);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.languageChanged),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      itemBuilder: (_) => [
        _item(const Locale('fr'), '🇫🇷', l10n.french,  currentLocale),
        _item(const Locale('ar'), '🇸🇦', l10n.arabic,  currentLocale),
      ],
    );
  }

  PopupMenuItem<Locale> _item(
      Locale locale, String flag, String label, Locale current) {
    final isActive = current.languageCode == locale.languageCode;
    return PopupMenuItem<Locale>(
      value: locale,
      child: Row(children: [
        Text(flag, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isActive ? const Color(0xFF1a5276) : null)),
        if (isActive) ...[
          const Spacer(),
          const Icon(Icons.check, color: Color(0xFF1a5276), size: 18),
        ],
      ]),
    );
  }

  String _flag(String code) {
    switch (code) {
      case 'fr': return '🇫🇷';
      case 'ar': return '🇸🇦';
      default:   return '🌐';
    }
  }
}