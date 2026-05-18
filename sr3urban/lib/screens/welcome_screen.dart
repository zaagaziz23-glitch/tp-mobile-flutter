import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/language_selector.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = SR3Strings.of(context);

    return Directionality(
      textDirection: l10n.isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 40,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(spacing: 8, children: [
                            _Badge('PFA 2025–2026'),
                            _Badge('Deep Learning'),
                          ]),
                          const LanguageSelector(),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Text(l10n.welcomeTitle,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                            height: 1.15,
                          )),
                      const SizedBox(height: 10),
                      Text(l10n.welcomeSubtitle,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF5dade2),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.12)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Icon(Icons.description_outlined,
                                  color: Color(0xFF5dade2), size: 18),
                              const SizedBox(width: 8),
                              Text('Description',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ]),
                            const SizedBox(height: 12),
                            Text(l10n.welcomeDesc,
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.80),
                                  fontSize: 14,
                                  height: 1.7,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(children: [
                        Expanded(
                          child: _StatCard(
                              value: '17.74', unit: 'dB',
                              label: l10n.statPsnr,
                              icon: Icons.speed,
                              color: const Color(0xFF5dade2)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                              value: '+5.31', unit: 'dB',
                              label: l10n.statGain,
                              icon: Icons.trending_up,
                              color: const Color(0xFF2ecc71)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                              value: '4', unit: '',
                              label: l10n.statAmeli,
                              icon: Icons.upgrade,
                              color: const Color(0xFFe67e22)),
                        ),
                      ]),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.12)),
                        ),
                        child: Column(children: [
                          _InfoRow('👤', 'Mohamed Aziz Zaag'),
                          const Divider(color: Colors.white12, height: 22),
                          _InfoRow('👨‍🏫', 'lt. ben KHALIFA Aymen (Encadrant)'),
                          const Divider(color: Colors.white12, height: 22),
                          _InfoRow('🏛️', 'EABA — Géomatique 2ème Année'),
                          const Divider(color: Colors.white12, height: 22),
                          _InfoRow('💻', 'NVIDIA RTX 4050 — 6 GB VRAM'),
                          const Divider(color: Colors.white12, height: 22),
                          _InfoRow('🏗️', 'Architecture : SR3 + 4 améliorations'),
                          const Divider(color: Colors.white12, height: 22),
                          _InfoRow('📅', 'Année académique 2025–2026'),
                        ]),
                      ),
                      const SizedBox(height: 36),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MainShell()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5dade2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(l10n.continueBtn,
                                  style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward_rounded,
                                  size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(l10n.footer,
                            style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.25),
                                fontSize: 11)),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge(this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.10),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.15)),
    ),
    child: Text(label,
        style: GoogleFonts.inter(
            color: Colors.white60,
            fontSize: 12,
            fontWeight: FontWeight.w600)),
  );
}

class _StatCard extends StatelessWidget {
  final String value, unit, label;
  final IconData icon;
  final Color color;
  const _StatCard(
      {required this.value, required this.unit, required this.label,
        required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Column(children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(children: [
          TextSpan(
              text: value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          if (unit.isNotEmpty)
            TextSpan(
                text: ' $unit',
                style: GoogleFonts.inter(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
        ]),
      ),
      const SizedBox(height: 4),
      Text(label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: Colors.white54, fontSize: 11, height: 1.4)),
    ]),
  );
}

class _InfoRow extends StatelessWidget {
  final String emoji, text;
  const _InfoRow(this.emoji, this.text);
  @override
  Widget build(BuildContext context) => Row(children: [
    Text(emoji, style: const TextStyle(fontSize: 18)),
    const SizedBox(width: 12),
    Expanded(
      child: Text(text,
          style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              fontWeight: FontWeight.w500)),
    ),
  ]);
}