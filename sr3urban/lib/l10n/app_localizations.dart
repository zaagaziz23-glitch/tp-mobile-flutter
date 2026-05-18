import 'package:flutter/material.dart';

class SR3Strings {
  final Locale locale;
  SR3Strings(this.locale);

  static SR3Strings of(BuildContext context) {
    return Localizations.of<SR3Strings>(context, SR3Strings)!;
  }

  static const LocalizationsDelegate<SR3Strings> delegate = _Delegate();

  static const Map<String, Map<String, String>> _t = {
    'fr': {
      'navContext':    'Contexte',
      'navMethodo':   'Méthodo',
      'navResults':   'Résultats',
      'navDashboard': 'Dashboard',
      'languageChanged': 'Langue modifiée',
      'french':  'Français',
      'arabic':  'العربية',
      'welcomeTitle':    'Super-Résolution\nd\'Images\nSatellitaires',
      'welcomeSubtitle': 'par Modèles de Diffusion — SR3',
      'welcomeDesc':
      'Pipeline de super-résolution d\'images satellitaires urbaines '
          'basé sur l\'architecture SR3. Quatre améliorations successives '
          '(Edge Loss, Transformer Block, SSIM Loss, Cosine Annealing) '
          'ont permis de passer de 14.18 dB à 19.49 dB de PSNR.',
      'continueBtn': 'Continuer',
      'footer':      'SR3Urban © 2026 — EABA Géomatique',
      'statPsnr':    'PSNR Final',
      'statGain':    'Gain Total',
      'statAmeli':   'Améliorations',
    },
    'ar': {
      'navContext':    'السياق',
      'navMethodo':   'المنهجية',
      'navResults':   'النتائج',
      'navDashboard': 'لوحة القيادة',
      'languageChanged': 'تم تغيير اللغة',
      'french':  'Français',
      'arabic':  'العربية',
      'welcomeTitle':    'فائق الدقة\nللصور\nالفضائية',
      'welcomeSubtitle': 'بنماذج الانتشار — SR3',
      'welcomeDesc':
      'خط معالجة لتحسين دقة الصور الفضائية الحضرية '
          'باستخدام معمارية SR3. أربعة تحسينات متتالية '
          'رفعت الأداء من 14.18 dB إلى 19.49 dB.',
      'continueBtn': 'متابعة',
      'footer':      'SR3Urban © 2026 — EABA هندسة جيوديسية',
      'statPsnr':    'PSNR النهائي',
      'statGain':    'إجمالي الكسب',
      'statAmeli':   'تحسينات',
    },
  };

  String _g(String key) =>
      _t[locale.languageCode]?[key] ?? _t['fr']![key] ?? key;

  String get navContext    => _g('navContext');
  String get navMethodo   => _g('navMethodo');
  String get navResults   => _g('navResults');
  String get navDashboard => _g('navDashboard');
  String get languageChanged => _g('languageChanged');
  String get french       => _g('french');
  String get arabic       => _g('arabic');
  String get welcomeTitle    => _g('welcomeTitle');
  String get welcomeSubtitle => _g('welcomeSubtitle');
  String get welcomeDesc  => _g('welcomeDesc');
  String get continueBtn  => _g('continueBtn');
  String get footer       => _g('footer');
  String get statPsnr     => _g('statPsnr');
  String get statGain     => _g('statGain');
  String get statAmeli    => _g('statAmeli');
  bool get isRtl => locale.languageCode == 'ar';
}

class _Delegate extends LocalizationsDelegate<SR3Strings> {
  const _Delegate();
  @override
  bool isSupported(Locale l) => ['fr', 'ar'].contains(l.languageCode);
  @override
  Future<SR3Strings> load(Locale l) async => SR3Strings(l);
  @override
  bool shouldReload(_Delegate old) => false;
}