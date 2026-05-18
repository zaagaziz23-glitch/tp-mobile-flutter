import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fafc),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF1e8449),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Résultats Principaux',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1e8449), Color(0xFF145a32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    right: -10,
                    top: 10,
                    child: Icon(Icons.bar_chart,
                        size: 160, color: Colors.white.withOpacity(0.06)),
                  ),
                  Positioned(
                    left: 24,
                    bottom: 60,
                    child: Text('Métrique : PSNR (dB) — 60 000 itérations',
                        style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 12)),
                  ),
                ]),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Résultat final ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1e8449), Color(0xFF145a32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF1e8449).withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: Column(
                    children: [
                      Text('🏆 PSNR Final (Évaluation)',
                          style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text('17.74 dB',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -2)),
                      const SizedBox(height: 8),
                      Text('Modèle final avec 4 améliorations — 60K itérations',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: Colors.white60, fontSize: 12)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _MiniStat('Baseline', '14.18 dB', Colors.white54),
                          Container(width: 1, height: 40, color: Colors.white24),
                          _MiniStat('Meilleur (train)', '19.49 dB', const Color(0xFF82e0aa)),
                          Container(width: 1, height: 40, color: Colors.white24),
                          _MiniStat('Gain total', '+5.31 dB', const Color(0xFFf8c471)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Progression PSNR ──────────────────────────────
                _SectionTitle('Progression par Amélioration'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      _PsnrBar('Baseline SR3', 14.18, 14.18, 19.49,
                          const Color(0xFF95a5a6), false),
                      _PsnrBar('+ Edge Loss', 15.83, 14.18, 19.49,
                          const Color(0xFF3498db), false),
                      _PsnrBar('+ Transformer Block', 17.21, 14.18, 19.49,
                          const Color(0xFF9b59b6), false),
                      _PsnrBar('+ SSIM Loss', 18.64, 14.18, 19.49,
                          const Color(0xFF1abc9c), false),
                      _PsnrBar('+ Cosine Annealing (train)', 19.49, 14.18, 19.49,
                          const Color(0xFF1e8449), true),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFfef9e7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFf39c12).withOpacity(0.3)),
                        ),
                        child: Row(children: [
                          const Icon(Icons.info_outline,
                              color: Color(0xFFf39c12), size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'PSNR évaluation finale : 17.74 dB '
                                  '(écart avec train expliqué par l\'overfitting et la correction du dataset)',
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF7d6608),
                                  fontSize: 12,
                                  height: 1.5),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Tableau comparatif ────────────────────────────
                _SectionTitle('Tableau Comparatif Détaillé'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      // En-tête
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFf1f5f9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                        ),
                        child: Row(children: [
                          Expanded(
                              flex: 5,
                              child: Text('Modèle',
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text('PSNR (dB)',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text('Δ Gain',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                        ]),
                      ),
                      // Lignes
                      ...[
                        _TableRow('Baseline SR3', 14.18, 0.0, const Color(0xFF95a5a6)),
                        _TableRow('+ Edge Loss', 15.83, 1.65, const Color(0xFF3498db)),
                        _TableRow('+ Transformer Block', 17.21, 1.38, const Color(0xFF9b59b6)),
                        _TableRow('+ SSIM Loss', 18.64, 1.43, const Color(0xFF1abc9c)),
                        _TableRow('+ Cosine Annealing', 19.49, 0.85, const Color(0xFF1e8449),
                            isBest: true),
                      ].map((row) => _buildTableRow(row)).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Analyse ───────────────────────────────────────
                _SectionTitle('Analyse des Résultats'),
                const SizedBox(height: 12),
                ...[
                  _Analysis(
                    icon: Icons.trending_up,
                    color: const Color(0xFF1e8449),
                    title: 'Progression constante',
                    text:
                    'Chaque amélioration apporte un gain positif, validant '
                        'l\'approche incrémentale. Le gain le plus important est '
                        'apporté par l\'Edge Loss (+1.65 dB), confirmant l\'importance '
                        'des contours dans les images urbaines.',
                  ),
                  _Analysis(
                    icon: Icons.memory,
                    color: const Color(0xFF3498db),
                    title: 'Contrainte GPU gérée',
                    text:
                    'L\'ensemble du pipeline a été entraîné sur une RTX 4050 '
                        '6 GB. Des ajustements de batch size (→4), de résolution '
                        '(64×64) et de gradient checkpointing ont permis d\'éviter '
                        'les erreurs OOM (Out of Memory).',
                  ),
                  _Analysis(
                    icon: Icons.bug_report_outlined,
                    color: const Color(0xFFe67e22),
                    title: 'Problème dataset détecté',
                    text:
                    'Un problème sur les images LR (résolution incorrecte) '
                        'a été détecté et corrigé en cours de projet, expliquant '
                        'l\'écart entre le PSNR d\'entraînement (19.49 dB) et le '
                        'PSNR d\'évaluation finale (17.74 dB).',
                  ),
                  _Analysis(
                    icon: Icons.school_outlined,
                    color: const Color(0xFF9b59b6),
                    title: 'Apport scientifique',
                    text:
                    'L\'intégration du Transformer dans SR3 pour les images '
                        'satellitaires urbaines est une contribution originale. '
                        'La combinaison Edge Loss + SSIM représente une approche '
                        'perceptuelle multi-critères adaptée au milieu urbain.',
                  ),
                ].map((a) => _AnalysisCard(data: a)),
                const SizedBox(height: 28),

                // ── Perspectives ──────────────────────────────────
                _SectionTitle('Perspectives & Travaux Futurs'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      _PerspRow('🔬', 'Tester sur des images à plus haute résolution (×8, 256×256)'),
                      _PerspRow('📊', 'Ajouter la métrique SSIM et LPIPS pour une évaluation perceptuelle complète'),
                      _PerspRow('🚀', 'Entraîner sur GPU plus puissant pour plus d\'itérations (>100K)'),
                      _PerspRow('🛰️', 'Étendre à d\'autres types d\'images satellitaires (zones rurales, agricoles)'),
                      _PerspRow('⚡', 'Explorer DDPM avec moins de pas (DDIM) pour l\'inférence rapide'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(_TableRow row) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: row.isBest ? const Color(0xFF1e8449).withOpacity(0.05) : null,
        border: const Border(
            top: BorderSide(color: Color(0xFFf1f5f9))),
      ),
      child: Row(children: [
        Expanded(
          flex: 5,
          child: Row(children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: row.color, borderRadius: BorderRadius.circular(3)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(row.label,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF334155),
                      fontSize: 13,
                      fontWeight:
                      row.isBest ? FontWeight.bold : FontWeight.normal)),
            ),
          ]),
        ),
        Expanded(
          flex: 3,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (row.isBest)
              const Icon(Icons.star_rounded,
                  color: Color(0xFF1e8449), size: 14),
            const SizedBox(width: 2),
            Text(
              '${row.psnr.toStringAsFixed(2)} dB',
              style: GoogleFonts.inter(
                color: row.color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 3,
          child: Text(
            row.gain == 0.0 ? '—' : '+${row.gain.toStringAsFixed(2)} dB',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: row.gain > 0
                  ? const Color(0xFF1e8449)
                  : const Color(0xFF94a3b8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]),
    );
  }
}

// ─── Modèles de données locaux ────────────────────────────────────

class _TableRow {
  final String label;
  final double psnr;
  final double gain;
  final Color color;
  final bool isBest;
  const _TableRow(this.label, this.psnr, this.gain, this.color,
      {this.isBest = false});
}

class _Analysis {
  final IconData icon;
  final Color color;
  final String title;
  final String text;
  const _Analysis(
      {required this.icon,
        required this.color,
        required this.title,
        required this.text});
}

// ─── Widgets ─────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.inter(
          color: const Color(0xFF1e293b),
          fontSize: 20,
          fontWeight: FontWeight.bold));
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniStat(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value,
        style: GoogleFonts.inter(
            color: color, fontSize: 16, fontWeight: FontWeight.bold)),
    const SizedBox(height: 4),
    Text(label,
        style: GoogleFonts.inter(color: Colors.white54, fontSize: 11)),
  ]);
}

class _PsnrBar extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final Color color;
  final bool isBest;
  const _PsnrBar(this.label, this.value, this.min, this.max, this.color,
      this.isBest);
  @override
  Widget build(BuildContext context) {
    final progress = (value - min) / (max - min);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            if (isBest)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.star_rounded,
                    color: Color(0xFF1e8449), size: 14),
              ),
            Text(label,
                style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13,
                    fontWeight:
                    isBest ? FontWeight.bold : FontWeight.normal)),
          ]),
          Text('${value.toStringAsFixed(2)} dB',
              style: GoogleFonts.inter(
                  color: color, fontSize: 13, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFe2e8f0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ]),
    );
  }
}

class _AnalysisCard extends StatelessWidget {
  final _Analysis data;
  const _AnalysisCard({required this.data});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3))
      ],
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: data.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Icon(data.icon, color: data.color, size: 20),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF1e293b),
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(data.text,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF64748b),
                      fontSize: 13,
                      height: 1.55)),
            ]),
      ),
    ]),
  );
}

class _PerspRow extends StatelessWidget {
  final String emoji;
  final String text;
  const _PerspRow(this.emoji, this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 12),
      Expanded(
        child: Text(text,
            style: GoogleFonts.inter(
                color: const Color(0xFF475569), fontSize: 14, height: 1.55)),
      ),
    ]),
  );
}