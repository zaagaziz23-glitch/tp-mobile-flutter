import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContextScreen extends StatelessWidget {
  const ContextScreen({super.key});

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
            backgroundColor: const Color(0xFF1a5276),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Contexte du Projet',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1a5276), Color(0xFF0d2b47)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    right: -20,
                    top: 10,
                    child: Icon(Icons.satellite_alt,
                        size: 170, color: Colors.white.withOpacity(0.06)),
                  ),
                  Positioned(
                    left: 24,
                    bottom: 60,
                    child: Text('Imagerie satellitaire urbaine — IA',
                        style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13)),
                  ),
                ]),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Problématique ─────────────────────────────────
                _InfoCard(
                  icon: Icons.help_outline_rounded,
                  color: const Color(0xFFe74c3c),
                  title: 'Problématique',
                  content:
                  'Les images satellitaires à basse résolution spatiale '
                      'limitent la précision des analyses urbaines (détection '
                      'de bâtiments, suivi d\'occupation du sol, planification). '
                      'L\'acquisition d\'images haute résolution est coûteuse '
                      'et contrainte par les capacités des capteurs. La '
                      'super-résolution par IA représente une alternative '
                      'efficace et économique.',
                ),
                const SizedBox(height: 16),

                // ── Objectif général ──────────────────────────────
                _InfoCard(
                  icon: Icons.track_changes_rounded,
                  color: const Color(0xFF27ae60),
                  title: 'Objectif Général',
                  content:
                  'Développer un modèle de super-résolution d\'images '
                      'satellitaires urbaines capable d\'améliorer la '
                      'résolution spatiale par un facteur ×4, en exploitant '
                      'les modèles de diffusion débruitage (SR3) pour générer '
                      'des détails réalistes à haute résolution.',
                ),
                const SizedBox(height: 16),

                // ── Objectifs spécifiques ─────────────────────────
                _InfoCard(
                  icon: Icons.format_list_bulleted_rounded,
                  color: const Color(0xFF9b59b6),
                  title: 'Objectifs Spécifiques',
                  content: '',
                  child: Column(
                    children: [
                      _ObjectiveRow('01', 'Implémenter l\'architecture SR3',
                          'Adapter le modèle de diffusion SR3 pour la super-résolution ×4 d\'images urbaines.',
                          const Color(0xFF3498db)),
                      _ObjectiveRow('02', 'Améliorer le modèle de base',
                          'Intégrer 4 améliorations successives : Edge Loss, Transformer, SSIM Loss, Cosine Annealing.',
                          const Color(0xFF9b59b6)),
                      _ObjectiveRow('03', 'Évaluer quantitativement',
                          'Mesurer les performances avec la métrique PSNR (dB) à chaque étape d\'amélioration.',
                          const Color(0xFF27ae60)),
                      _ObjectiveRow('04', 'Optimiser pour GPU limité',
                          'Rendre le pipeline entraînable sur une RTX 4050 6 GB avec gestion mémoire adaptée.',
                          const Color(0xFFe67e22)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Contexte académique ───────────────────────────
                _InfoCard(
                  icon: Icons.school_rounded,
                  color: const Color(0xFF3498db),
                  title: 'Contexte Académique',
                  content:
                  "Projet de Fin d'Année (PFA) réalisé en 2ème année "
                      "de formation en Géomatique à l'EABA, sous la "
                      "supervision de l'encadrant académique.",
                ),
                const SizedBox(height: 16),

                // ── Fiche projet ──────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1a5276), Color(0xFF0d2b47)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF1a5276).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('📋 Fiche du Projet',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _FicheRow('Étudiant', 'Mohamed Aziz Zaag'),
                      _FicheRow('Spécialité', 'Géomatique — 2ème Année'),
                      _FicheRow('Établissement', 'EABA'),
                      _FicheRow('Sujet', 'Super-Résolution d\'Images Satellitaires'),
                      _FicheRow('Architecture', 'SR3 — Modèle de Diffusion'),
                      _FicheRow('GPU utilisé', 'NVIDIA RTX 4050 — 6 GB VRAM'),
                      _FicheRow('Framework', 'PyTorch'),
                      _FicheRow('Facteur SR', '×4 (LR → HR)'),
                      _FicheRow('Année', '2025–2026'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Mots-clés ─────────────────────────────────────
                Text('Mots-clés',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF1e293b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Super-Résolution',
                    'Modèle de Diffusion',
                    'SR3',
                    'Imagerie Satellitaire',
                    'Milieu Urbain',
                    'PyTorch',
                    'PSNR',
                    'Edge Loss',
                    'Transformer',
                    'SSIM',
                    'Cosine Annealing',
                    'Deep Learning',
                    'Géomatique',
                  ].map((k) => _KeywordChip(k)).toList(),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Widgets ─────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String content;
  final Widget? child;
  const _InfoCard(
      {required this.icon,
        required this.color,
        required this.title,
        required this.content,
        this.child});

  @override
  Widget build(BuildContext context) => Container(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Text(title,
              style: GoogleFonts.inter(
                  color: const Color(0xFF1e293b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 14),
        if (content.isNotEmpty)
          Text(content,
              style: GoogleFonts.inter(
                  color: const Color(0xFF64748b), fontSize: 14, height: 1.65)),
        if (child != null) child!,
      ],
    ),
  );
}

class _ObjectiveRow extends StatelessWidget {
  final String num;
  final String title;
  final String desc;
  final Color color;
  const _ObjectiveRow(this.num, this.title, this.desc, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8)),
        child: Text(num,
            style: GoogleFonts.inter(
                color: color, fontSize: 12, fontWeight: FontWeight.w800)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: GoogleFonts.inter(
                  color: const Color(0xFF1e293b),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(desc,
              style: GoogleFonts.inter(
                  color: const Color(0xFF64748b), fontSize: 13, height: 1.5)),
        ]),
      ),
    ]),
  );
}

class _FicheRow extends StatelessWidget {
  final String label;
  final String value;
  const _FicheRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 120,
        child: Text(label,
            style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.50),
                fontSize: 12,
                fontWeight: FontWeight.w500)),
      ),
      Expanded(
        child: Text(value,
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ),
    ]),
  );
}

class _KeywordChip extends StatelessWidget {
  final String label;
  const _KeywordChip(this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF1a5276).withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF1a5276).withOpacity(0.2)),
    ),
    child: Text(label,
        style: GoogleFonts.inter(
            color: const Color(0xFF1a5276),
            fontSize: 12,
            fontWeight: FontWeight.w600)),
  );
}