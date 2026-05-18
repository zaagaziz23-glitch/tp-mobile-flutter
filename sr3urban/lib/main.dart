import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/welcome_screen.dart';
import 'screens/context_screen.dart';
import 'screens/methodology_screen.dart';
import 'screens/results_screen.dart';
import 'screens/dashboard_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() => runApp(const SR3UrbanApp());

class SR3UrbanApp extends StatefulWidget {
  const SR3UrbanApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    context.findAncestorStateOfType<_SR3UrbanAppState>()?.setLocale(locale);
  }

  @override
  State<SR3UrbanApp> createState() => _SR3UrbanAppState();
}

class _SR3UrbanAppState extends State<SR3UrbanApp> {
  Locale _locale = const Locale('fr');

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SR3Urban — PFA',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('fr'), Locale('ar')],
      localizationsDelegates: const [
        SR3Strings.delegate,                        // ← notre delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1a5276)),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ContextScreen(),
    MethodologyScreen(),
    ResultsScreen(),
    DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}